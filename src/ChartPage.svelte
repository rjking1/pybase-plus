<script>
  import { onMount } from "svelte";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { doFetch, titleCase, viewDetail } from "../../common/dbutils";
  import DataFrame from "dataframe-js";

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let options = null;

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
    let [opts, ...sql] = sql_text.split(/\r?\n/);;
    if (opts.startsWith("-- {")) {
      opts = JSON.parse(opts.slice(3));
      sql = sql.join("\n");
    } else {
      opts = {};
      sql = sql_text;
    }

    console.log(opts);
    console.log(sql);

    let data = await doFetch($dbN, sql);

    if (v.formDesc == "!chart bar") {
      doBarChart(opts, data);
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

  function doBarChart(opts, data) {
    let col_names = Object.keys(data[0]);
    let df = new DataFrame(data, col_names);

    if (!col_names[0].startsWith("$")) {
      col_names.splice(0, 0, "!c");
      // df = df.restructure(col_names);
      df = df.withColumn("!c");
    }

    if (!col_names[1].startsWith("_")) {
      col_names.splice(1, 0, "!s");
      // df = df.restructure(col_names);
      df = df.withColumn("!s");
    }

    // note col_names order is not nec same order as columns in df now
    // console.log(col_names);
    // df.show(5);

    const charts_col_name = col_names[0];
    const series_col_name = col_names[1];
    const charts_values = df.distinct(charts_col_name).toArray(charts_col_name);
    const series_values = df.distinct(series_col_name).toArray(series_col_name);

    let chartIndex = 0;
    for (const chart_value of charts_values) {
      let traces = [];
      let stacked = false;
      for (const series_value of series_values) {
        // console.log(series_value);
        let df_filt = df.filter(
          (row) => row.get(charts_col_name) == chart_value
        );
        df_filt = df_filt.filter(
          (row) => row.get(series_col_name) == series_value
        ); // combine into 1 using .chain or .filter({charts_col_name: chart_value, series_col_name: series_value})
        const x = df_filt.toArray(col_names[2]);
        col_names.forEach((col, index) => {
          if (index > 2) {
            // console.log(col);
            // console.log(df_filt.toArray(col));
            stacked = stacked || col.endsWith("#"); // any
            const series_type =
              col.endsWith("_") || col.endsWith("$") ? "scatter" : "bar";
            traces.push({
              name: series_col_name != "!s" ? series_value + " " + col : col,
              x: x,
              y: df_filt.toArray(col),
              type: series_type,
              mode: "lines",
              yaxis: col.endsWith("$") ? "y2" : "y",
            });
          }
        });
      }

      const layout = {
        title: charts_col_name == "!c" ? entityName : chart_value, // todo: allow opts.title?
        xaxis: { title: opts.x },
        yaxis: { title: opts.y1, side: "left" },
        yaxis2: { title: opts.y2, side: "right", overlaying: "y" },
        barmode: stacked ? "relative" : "group", // todo support opts.barmode
      };

      const options = {};

      let plotDiv = document.getElementById("plotDiv" + chartIndex);
      // let Plot = new
      Plotly.newPlot(plotDiv, traces, layout, options);
      chartIndex++;
    }
  }

  function doDotChart() {
    let pts = {};
    data.forEach((row) => {
      // console.log(row);
      // we don't care what the col names are
      // first is the series label - group by this
      // 2nd colis the x axis value,3rd col is y axis value
      let yr = Object.values(row)[0];
      let pt = new Array();
      pt.push(parseFloat(Object.values(row)[1]));
      pt.push(parseFloat(Object.values(row)[2]));
      if (!(yr in pts)) {
        pts[yr] = [];
      }
      pts[yr].push(pt);
    });
    // console.log(pts);

    let series = [];
    Object.keys(pts).forEach((yr) => {
      series.push({
        name: yr,
        data: pts[yr],
      });
    });

    options = {
      chart: {
        type: "scatter",
        zoom: {
          enabled: true,
          type: "xy",
        },
      },
      //dataLabels: { position: "top", enabled: false, offsetY: 30 },
      series: series,
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
    data.forEach((row) => {
      let dt = "." + Object.values(row)[0] + ".";
      let month = parseInt(dt.substr(6, 2));
      if (firstMonth) {
        firstMonth = false;
        monthStart = month;
      }
      let day = parseInt(dt.substr(9, 2));
      let km = parseFloat(Object.values(row)[1]);
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
      series: [{ data: series }],
      chart: {
        height: 500,
        type: "treemap",
      },
      legend: {
        show: false,
      },
    };
  }
</script>

<h3>{entityName}</h3>

<div id="plotly">
  <div id="plotDiv0" />
  <div id="plotDiv1" />
  <div id="plotDiv2" />
  <div id="plotDiv3" />
  <div id="plotDiv4" />
  <div id="plotDiv5" />
</div>
