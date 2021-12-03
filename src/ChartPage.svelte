<script>
  import { onMount } from "svelte";
  import { dbN, page, permissions, views, emailDetails, gOptions } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import {
    doFetch,
    getLatestDateTimeAsISO,
    titleCase,
    viewDetail,
  } from "../../common/dbutils";
  // import DataFrame from "dataframe-js";
  import ChartWidget from "./ChartWidget.svelte";

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let data;
  let options = null;
  let widgetList = []; // in case useful to support multiple charts one day and have to update them (copied from dashboard)

  // a lot of this should go into common as membersPage and CalendarPage have thee 3 functions in common
  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    console.log(v);
    // viewIsEditable =
    // !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
    entityName = titleCase(viewName) || "";
    doChart();
    // doGetActions();
  });

  async function doChart() {
    fields = JSON.parse(v.fields);
    if (fields === null) {
      fields = [];
    }
    fields.push({ fieldName: "id", visibility: false });
    // console.log(fields);

    let sql_text = v.get_sql.replace("%d", p.id);
    let [opts, ...sql] = sql_text.split(/\r?\n/);
    if (opts.startsWith("-- {")) {
      opts = JSON.parse(opts.slice(3));
      sql = sql.join("\n");
    } else {
      opts = {};
      sql = sql_text;
    }

    // console.log(sql);
    const datetime = $gOptions.datetime
    sql = sql.replaceAll(":datetime:", datetime ); // maybe this should also quote the datetime string
    sql = sql.replaceAll(":duid:", $gOptions.duid); 
    console.log(sql);

    opts.datetime = datetime;
    console.log(opts);

    data = await doFetch($dbN, sql);

    addChartWidget("#plotlychart", data, v.formDesc.slice(7), opts);
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
</script>

<h3>{entityName}</h3>

<div id="plotlychart" />
