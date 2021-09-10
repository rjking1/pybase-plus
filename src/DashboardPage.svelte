<script>
  import { onMount } from "svelte";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
  } from "../../common/dbutils";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { dbN, page, permissions, views } from "./Stores.js";
  import ButtonWidget from "./ButtonWidget.svelte";
  import TextWidget from "./TextWidget.svelte";
  import TableWidget from "./TableWidget.svelte";
  import ChartWidget from "./ChartWidget.svelte";
  import { roundedDateTimeToISO } from "./utilFuncs";

  let p;
  let viewName;
  let v;
  let html = undefined;
  let widgetList = [];
  let datetime;
  let results = [];

  // const regionNames = ["QLD1", "NSW1", "VIC1", "SA1", "TAS1"];

  onMount(async () => {
    await doGetHTML();
    await performQueries(); // views and embedded SQL
    await addWidgetsToHTML();
    await doUpdateAll();
  });

  async function doGetHTML() {
    p = pageDetails();
    console.log(p);
    viewName = p.viewName; // 1 of N dashboards (dashboards are just special multi-views)
    v = viewDetail($views, viewName);
    // console.log(v);
    let res = await doFetch(
      $dbN,
      "select datetime from events where id=" + p.id
    ); // consider passing this in an object of pageDetails - "extras"
    datetime = res[0].datetime;
    html = v.formDesc;
  }

  async function performQueries() {
    results = [];

    let sqlStmt;

    // there is a bug here - must only load views once - not for every reference
    // check if have view name (as sqlID already)
    const sources = document.querySelectorAll("[data-source^='view']"); // each "source" is actually a widget
    for (let source of sources) {
      console.log(source);
      sqlStmt = viewDetail($views, source.dataset.view).get_sql;
      sqlStmt = sqlStmt.replaceAll(":datetime:", datetime); // maybe this should also quote the datetime string
      console.log(sqlStmt);
      let [opts, result] = await doGetResult(sqlStmt);
      results.push({
        sqlID: source.dataset.source, // careful - using data-source here; sql id below -- all must be unique
        opts: opts,
        result: result,
      });
    }

    const sqls = document.querySelectorAll("[id^='sql-']");
    for (let sql of sqls) {
      console.log(sql);
      let sqlID = sql.id; // todo make this uppercase
      console.log(sqlID);
      sqlStmt = sql.dataset.sql; // don't forget to drop the "data-" prefix !!!!!
      sqlStmt = sqlStmt.replaceAll(":datetime:", datetime); // maybe this should also quote the datetime string
      console.log(sqlStmt);
      let [opts, result] = await doGetResult(sqlStmt);
      results.push({
        sqlID: sqlID,
        opts: opts,
        result: result,
      });
    }
  }

  async function doGetResult(sql_text) {
    let [opts, ...sql] = sql_text.split(/\r?\n/);
    if (opts.startsWith("-- {")) {
      opts = JSON.parse(opts.slice(3));
      sql = sql.join("\n");
    } else {
      opts = {};
      sql = sql_text;
    }

    let res = await doFetch($dbN, sql);
    return [opts, res];
  }

  async function addWidgetsToHTML() {
    // known widgets not marked as widgets -- no datasource or sql --can detect as datasource is undefined at line 108
    addTextWidget("#market_time", "Market time: " + datetime); // can write to a widget directly if we know it is there -- do not mark as a "widget" !!

    // todo: make above a friendly time

    // tagged widgets
    const widgets = document.querySelectorAll("[data-id='widget']");
    for (let widget of widgets) {
      console.log(widget);
      let widgetType = widget.dataset.type;
      let dataSource = widget.dataset.source;
      if (!dataSource) {
        dataSource = widget.dataset.view;
      }

      // if dataSource is undefined here then this is a non-data-aware widget

      if (widgetType == "button") {
        addButtonWidget("#" + widget.id, widget.id, async () => {
          if (widget.id == "now") {
            datetime = roundedDateTimeToISO();
            await performQueries();
            doUpdateAll();
          }
        });
      } else if (widgetType == "text") {
        addTextWidget("#" + widget.id);
      } else if (widgetType == "table") {
        addTableWidget("#" + widget.id); // not efficient to pass across a selector that needs to be found when we have the element
      } else if (widgetType == "chart") {
        console.log("adding chart #" + widget.id);
        addChartWidget("#" + widget.id);
      }
    }
  }

  async function doUpdateAll() {
    updateTextWidget("#market_time", "Market time: " + datetime);

    const widgets = document.querySelectorAll("[data-id='widget']");
    for (let widget of widgets) {
      console.log(widget.id);
      let widgetType = widget.dataset.type;
      console.log(widgetType);
      let dataSource = widget.dataset.source;
      if (dataSource == undefined) {
        dataSource = widget.dataset.view;
      }
      console.log(dataSource);

      if (widgetType == "button") {
        // do nothing as don't expect to have to update a button caption or callback fn atm
      } else {
        let result = results.find((r) => r.sqlID == dataSource)?.result;
        let opts = results.find((r) => r.sqlID == dataSource)?.opts;
        if (widgetType == "text") {
          // in my example the sql result has key and value columns
          // keys <-> id
          updateTextWidget(
            "#" + widget.id,
            widget.id + ": " + lookup(result, widget.id)
          );
        } else if (widgetType == "table") {
          updateTableWidget("#" + widget.id, result); // not efficient to pass across a selector that needs to be found when we have the element
        } else if (widgetType == "chart") {
          console.log("updating chart #" + widget.id);
          console.log(widget.dataset.subtype);
          addChartWidget(
            // this shuould be update but plotly draws into a div I give it and this makes it differnt
            "#" + widget.id,
            result,
            widget.dataset.subtype,
            opts
          );
        }
      }
    }
  }

  function lookup(rows, key) {
    console.log(rows);
    console.log(key);
    return rows.find((row) => row.key === key)["value"];
  }

  function addButtonWidget(s, c, fn) {
    new ButtonWidget({
      target: document.querySelector(s),
      props: {
        caption: c,
        fn: fn,
      },
    });
  }

  function addTextWidget(s, v) {
    // can allow an init txt string
    widgetList.push({
      sel: s,
      wgt: new TextWidget({
        target: document.querySelector(s),
        props: {
          txt: v,
        },
      }),
    });
  }

  function updateTextWidget(s, v) {
    let widget = widgetList.find((w) => w.sel == s)["wgt"];
    widget.$set({ txt: v });
  }

  function addTableWidget(s, v) {
    widgetList.push({
      sel: s,
      wgt: new TableWidget({
        target: document.querySelector(s),
        props: {
          qresult: v,
        },
      }),
    });
  }

  function updateTableWidget(s, v) {
    let widget = widgetList.find((w) => w.sel == s)["wgt"];
    widget.$set({ qresult: v });
  }

  function addChartWidget(s, data, chartType, opts) {
    widgetList.push({
      sel: s,
      wgt: new ChartWidget({
        target: document.querySelector(s),
        props: {
          div: s,
          data: data,
          chartType: chartType,
          opts: opts,
        },
      }),
    });
  }

  function updateChartWidget(s, data, chartType, opts) {
    let widget = widgetList.find((w) => w.sel == s)["wgt"];
    console.log("found chart: ");
    console.log(widget);
    widget.$set({
      div: s,
      data: data,
      chartType: chartType,
      opts: opts,
    });
  }
</script>

<main>
  {@html html}
</main>

<style>
</style>
