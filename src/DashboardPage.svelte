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
  import TextWidget from "./TextWidget.svelte";
  import TableWidget from "./TableWidget.svelte";
  import ChartWidget from "./ChartWidget.svelte";

  let p;
  let viewName;
  let v;
  let html = undefined;
  let datetime;
  // let Widget;

  const regionNames = ["QLD1", "NSW1", "VIC1", "SA1", "TAS1"];

  onMount(async () => {
    // Widget = (await import('./Widget.svelte')).default;
    await doGetHTML();
    await doUpdateAll();

    // this updates on each character.  on:change does the same
    //do I need to do the "debouncing"? ie wait for Enter?
    // document.getElementById("market-text").addEventListener("change", () => {
    //   doUpdateAll();
    // });
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
    // console.log(res);
    datetime = res[0].datetime;
    // console.log(datetime);
    html = v.formDesc;
  }

  async function doUpdateAll() {
    addTextWidget("#market_time", "Market time: " + datetime); // can write to a widget directly if we know it is there

    let results = [];
    const sqls = document.querySelectorAll("[id^='sql']");
    for (let sql of sqls) {
      console.log(sql);
      let sqlID = sql.id; // todo make this uppercase
      console.log(sqlID);
      let sqlStmt = sql.dataset.sql;  // don't forget to drop the "data-" prefix !!!!!
      sqlStmt = sqlStmt.replaceAll(":datetime:", datetime); // maybe this should also quote the datetime string
      let result = await doGetResult(sqlStmt);
      results.push({
        sqlID: sqlID,
        result: result,
      });
    }

    const widgets = document.querySelectorAll("[data-id^='widget']");
    let result;
    for (let widget of widgets) {
      let widgetType = widget.dataset.type;
      console.log(widgetType);
      let dataSource = widget.dataset.source;
      console.log(dataSource);

      if (widgetType == "text") {
        // addTextWidget(widget, reg);  ?????
      }
      if (widgetType == "table") {
        result = results.find((r) => r.sqlID == dataSource)["result"];
        // console.log(widget.id);
        addTableWidget("#" + widget.id, result);  // not efficient to pass across a selector that needs to be found when we have the element
      }
      if(widgetType=="chart") {
        result = results.find((r) => r.sqlID == dataSource)["result"];
        addChartWidget("#" + widget.id, result, widget.dataset.subtype);
      }
    }

    // for (let reg of regionNames) {
    //   addWidget("#" + reg + "_price", reg);
    //   addWidget("#" + reg + "_price", lookup(result, reg + "_price"));
    // }

    //   `select concat(p.regionid, "_price") as "key", rrp as "value" from DISPATCH__PRICE p
    //   where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE)`
    // );
    // console.log(result);

    // sql = matches[1].dataset.sql; // special function: reads data-sql attribute
    // console.log(sql);

    /// we already have all the sql in memory in the $views store
    // so should allow a view name to be used
    // which avoids needing to have a copy in the html
    // but having sql in the html as an option allows for max flexibility

    // result = await doGetResult(sql);
    //   `select p.regionid as "Region", format(rrp, 2) as "RRP", format(clearedsupply,0) as "Demand",
    //   format(dispatchablegeneration,0) as "Generation" ,
    //   format(availablegeneration,0) as "Available"
    //   from DISPATCH__PRICE p join DISPATCH__REGIONSUM r
    //   on p.settlementdate = r.settlementdate and p.regionid = r.regionid
    //   where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE) - interval 1 minute
    //   and r.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE) - interval 1 minute
    //   order by 1`
    // );
    // addTableWidget("#t1", result);

    // an advantage of not passing a view into the table or chart widgets is that we can share the result
    // tho I'm not doing that here !

    // let dt = datetime;
    // // let el = document.getElementById("market-text");
    // // if (el) {
    // //   dt = el.value;
    // // } else {
    // //   dt = new Date().toISOString();
    // // }
    // // console.log(dt);
    // // if (dt != "") {
    //   sql =
    //   'select regionid as "_", settlementdate, rrp as "rrp_" from DISPATCH__PRICE where settlementdate >= "' +
    //   dt + '" - interval 30 minute and settlementdate <= "' + dt + '" + interval 30 minute';
    //   console.log(sql);
    //   result = await doGetResult(sql);
    //   addChartWidget("#c1", result, "bar");
    // // }

    // // use existing view:  need a way of specifying a view name in the html data-view="view-1"?

    // sql = viewDetail($views, "09 Current gen").get_sql;
    // console.log(sql);
    // result = await doGetResult(sql);
    // addChartWidget("#c2", result, "bar");

    // sql = viewDetail($views, "reg ft sunburst").get_sql;
    // console.log(sql);
    // result = await doGetResult(sql);
    // addChartWidget("#c3", result, "sunburst");
  }

  function lookup(rows, key) {
    return rows.find((row) => row.key === key)["value"];
  }

  async function doGetResult(sql) {
    return await doFetch($dbN, sql);
  }

  function addTextWidget(s, v) {
    new TextWidget({
      target: document.querySelector(s),
      props: {
        txt: v,
      },
    });
  }

  function addTableWidget(s, v) {
    new TableWidget({
      target: document.querySelector(s),
      props: {
        qresult: v,
      },
    });
  }

  function addChartWidget(s, data, chartType, opts) {
    new ChartWidget({
      target: document.querySelector(s),
      props: {
        div: s,
        data: data,
        chartType: chartType,
        opts: opts,
      },
    });
  }
</script>

<main>
  {@html html}
</main>

<style>
</style>
