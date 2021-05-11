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
      doDotChart();
    }
    if (v.formDesc == "!heatmap") {
      doHeatmap();
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
    data.forEach((item) => {
      let mo = '.'+ Object.values(item)[0] + '.';
      let month = mo.substr(6,2);
      let day = mo.substr(9,2);
      let km = parseFloat(Object.values(item)[1]);
      if(!v[month]) { v[month] = {} }
      v[month][day] = km;  // accum?
    });
    console.log(v);

    let series = [];
    for (let i = 12; i > 0; i--) {
      let mm = i.toString().padStart(2,0); 
      let days = []
      for(let d = 1; d < 32; d++ ) {
        let dd = d.toString().padStart(2,0);
        // console.log(mm, dd, v[mm])
        if(dd in v[mm]) { 
          days.push(v[mm][dd]);
        } else {
          days.push(0);
        }
      }
      series.push({ name: i, data: days });
    }
    // console.log(series)

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
        text: "HeatMap",
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
