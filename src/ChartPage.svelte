<script>
  import { onMount } from "svelte";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
    writeAuditText,
  } from "./Common.js";

  import { chart } from "svelte-apexcharts";

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let data = null;
  let aresult = null;

  let dates = null;
  let dots = null;
  let heatmapDataKms = null;
  let heatmapDataAlt = null;
  let heatmapColorsKms;
  let heatmapColorsAlt;

  let options = null;

  // a lot of this should go into common as membersPage and CalendarPage have thee 3 functions in common
  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    console.log(v);
    viewIsEditable =
      !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
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
    console.log(fields);
    let sql = v.get_sql.replace("%d", p.id);
    data = await doFetch($dbN, sql);

    if (v.formDesc == "!chart bar") {
      doBarChart();
    }
    if (v.formDesc == "!chart dots") {
      // doDotChart();
    }
    if (v.formDesc == "!heatmap") {
      // doHeatmap();
    }
  }

  function doBarChart() {
    let x = [];
    let y1 = [];
    let y2 = [];
    data.forEach((item) => {
      // item=row
      console.log(item);
      // we don't care what the col names are
      // first is usually date on x axis
      // second+ are y values
      x.push(Object.values(item)[0]);
      y1.push(Object.values(item)[1]);
      y2.push(Object.values(item)[2]);
    });

    options = {
    chart: {
      type: "bar",
    },
    series: [
      {
        name: "km",
        data: y1,
      },
      {
        name: "m",
        data: y2,
      },
    ],
    xaxis: {
      categories: x,
    },
  };
  }

</script>

<h4>Chart</h4>

{#if options}
<div use:chart={options} />
{/if}
