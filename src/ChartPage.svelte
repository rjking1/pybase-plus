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
  import Chart from 'svelte-frappe-charts'

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let data = null;
  let aresult = null;

    let heatmapDataKms = null
  let heatmapDataAlt = null
  let heatmapColorsKms
  let heatmapColorsAlt


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

    if(v.formDesc == "!chart bar") {
      doBarChart()
    }
    if(v.formDesc == "!heatmap") {
      doHeatmap()
    }
  }

  function doHeatmap() {
    // heatmap
    // let data = await doFetch(
    //   'select ride_date, sum(km) as sumkm, sum(alt_gain) as sumalt from rides where ride_date >= curdate() - interval 1 year group by 1 order by 1',
    // )
    let dateKms = {}
    let dateAlt = {}
    data.forEach((item) => (dateKms[item.ride_date] = item.sumkm))
    data.forEach((item) => (dateAlt[item.ride_date] = item.sumalt))
    // console.log(dateKms)
    let today = new Date() 
    today.setDate(today.getDate() + 1)
    let t365 = new Date()
    t365.setDate(t365.getDate() - 366)

    heatmapColorsKms = ['#ebedf0', '#c6e48b', '#7bc96f', '#239a3b', '#196127']
    heatmapDataKms = {
      dataPoints: dateKms,
      start: t365,
      end: today,
    }
    heatmapColorsAlt = ['#ebedf0', '#c0ddf9', '#73b3f3', '#3886e1', '#17459e']
    heatmapDataAlt = {
      dataPoints: dateAlt,
      start: t365,
      end: today,
    }
  }

</script>

<h4>Km</h4>
{#if heatmapDataKms}
  <Chart data={heatmapDataKms} type="heatmap" colors={heatmapColorsKms} height=150px />
{/if}

<h4>Alt (m)</h4>
{#if heatmapDataAlt}
  <Chart data={heatmapDataAlt} type="heatmap" colors={heatmapColorsAlt} height=160px />
{/if}
