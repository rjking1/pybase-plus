<script>
  import { onMount } from "svelte";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
  } from "./Common.js";

  import { chart } from "svelte-apexcharts";

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  // let entityName;
  let data = null;
  let options = null;

  // a lot of this should go into common as membersPage and CalendarPage have thee 3 functions in common
  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    console.log(v);
    // viewIsEditable =
      // !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
    // entityName = titleCase(viewName) || "";
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
      doDotChart();
    }
    if (v.formDesc == "!chart heatmap") {
      doHeatmap();
    }
    if (v.formDesc == "!chart treemap" || v.formDesc == "!chart pie") {
      doTreemap();
    }
  }

  function doBarChart() {
    let x = [];
    let y1 = [];
    let y2 = [];
    data.forEach((item) => {
      // item=row
      // console.log(item);
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
      dataLabels: { position: "top", enabled: false, offsetY: 30 },
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
      yaxis: [
        {
          title: {
            text: "km",
          },
        },
        {
          opposite: true,
          title: {
            text: "m",
          },
        },
      ],
    };
  }

  function doDotChart() {
    let pts = {};
    pts["2021"] = [];
    pts["2020"] = [];
    pts["2019"] = [];
    pts["2018"] = [];
    data.forEach((item) => {
      // item=row
      // console.log(item);
      // we don't care what the col names are
      // first is usually date on x axis
      // second+ are y values
      let yr = Object.values(item)[0]; // should we do .year() here
      let pt = new Array();
      pt.push(parseFloat(Object.values(item)[1]));
      pt.push(parseFloat(Object.values(item)[2]));
      pts[yr].push(pt);
    });
    // console.log(pts)

    options = {
      chart: {
        type: "scatter",
        zoom: {
          enabled: true,
          type: "xy",
        },
      },
      //dataLabels: { position: "top", enabled: false, offsetY: 30 },
      series: [
        {
          name: "2019",
          data: pts["2019"],
        },
        {
          name: "2020",
          data: pts["2020"],
        },
        {
          name: "2021",
          data: pts["2021"],
        },
      ],
      xaxis: {
        tickAmount: 10,
        title: {
          text: "km",
        },
      },
      yaxis: {
        tickAmount: 10,
        title: {
          text: "m",
        },
      },
    };
  }

  function doHeatmap() {
    let v = {};
    let firstMonth = true;
    let monthStart = 1;
    data.forEach((item) => {
      let dt = "." + Object.values(item)[0] + ".";
      let month = parseInt(dt.substr(6, 2));
      if (firstMonth) {
        firstMonth = false;
        monthStart = month;
      }
      let day = parseInt(dt.substr(9, 2));
      let km = parseFloat(Object.values(item)[1]);
      if (!v[month]) {
        v[month] = new Array(31).fill(0);
      }
      v[month][day - 1] = km;
    });

    // assumes sql query result is ascending (and only 11 months so get clear separation)
    let series = [];
    let i = monthStart - 1;
    for (let count = 0; count < 12; count++) {
      series.push({ name: i.toString(), data: v[i] });
      if (--i < 1) {
        i = 12;
      }
    }

    options = {
      series: series,
      chart: {
        height: 350,
        type: "heatmap",
      },
      dataLabels: {
        enabled: false,
      },
      colors: ["#008FFB"],
      title: {
        text: "Km HeatMap",
      },
    };
  }

  function doTreemap() {
    let series = [];
    data.forEach((row) => {
      series.push({
        x: Object.values(row)[0],
        y: parseFloat(Object.values(row)[1]),
      });
    });
    options = {
      series: [{data:series}],
      chart: {
        height: 500,
        type: "treemap",
      },
      legend: {
        show: false,
      },
      title: {
        text: "Treemap",
      },
    };
  }
</script>

<h4>Chart</h4>

{#if options}
  <div style="max-width: 1000px">
    <div use:chart={options} />
  </div>
{/if}
