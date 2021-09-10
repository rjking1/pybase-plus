<script>
  import DataFrame from "dataframe-js";

  // maybe this should be given either // a view // or the sql statement // or the
  // data (that is what it does here)

  export let div;
  export let data;
  export let chartType;
  export let opts;

  // if charttype not set then does nothing (ie for addChartWidget)

  // console.log(div);
  const chartContainer = document.querySelector(div);

  if (chartType == "bar") {
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
    console.log(col_names);
    df.show(5);

    const charts_col_name = col_names[0];
    const series_col_name = col_names[1];
    const charts_values = df.distinct(charts_col_name).toArray(charts_col_name);
    const series_values = df.distinct(series_col_name).toArray(series_col_name);

    // general problem with tables and charts -- they are appending on each "refresh"
    // need a clear or rebuild page from scratch

    let chartIndex = 0;
    // chartContainer.innerHTML = ""; // prob better to while (el.hasChildElements()) { el.removeChild(el.lastChild)) }
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
        title: charts_col_name == "!c" ? "" : chart_value, // todo: allow opts.title?
        xaxis: { title: opts.x },
        yaxis: { title: opts.y1, side: "left" },
        yaxis2: { title: opts.y2, side: "right", overlaying: "y" },
        barmode: stacked ? "relative" : "group", // todo support opts.barmode
      };

      const options = {};

      let plotDiv = document.createElement(div.slice(1) + "-" + chartIndex);
      console.log(plotDiv);
      chartContainer.appendChild(plotDiv);
      // let Plot = new
      Plotly.react(plotDiv, traces, layout, options);
      chartIndex++;
    }
  }

  if (chartType == "treemap" || chartType == "sunburst") {
    let parents = [];
    let labels = [];
    let values = [];

    const col_names = Object.keys(data[0]);
    const col_count = col_names.length;

    data.forEach((row) => {
      let val = Math.floor(parseFloat(Object.values(row)[col_count - 1]));
      let par;
      for (let i = col_count - 2; i >= 0; i--) {
        let lab = Object.values(row)[i];
        if (i > 0) {
          par = Object.values(row)[i - 1];
        } else {
          par = "NEM"; // opts.rootName
        }
        if (lab) {
          if (i > 0 && i < col_count - 2) {
            labels.push(Object.values(row)[i - 1] + ":" + lab);
          } else {
            labels.push(lab);
          }
          if (i > 1) {
            parents.push(Object.values(row)[i - 2] + ":" + par);
          } else {
            parents.push(par);
          }
          values.push(val);
          break;
        } else {
          if (i == 0) {
            // then add root with no parent
            labels.push("NEM"); // opts.rootName
            parents.push(""); // root
            values.push(val + 10); // to avoid rounding summation error
          }
        }
      }
    });

    let traces = [
      {
        type: chartType,
        branchvalues: "total",
        values: values,
        labels: labels,
        parents: parents,
        // text: [] of text if we want to change some
        textinfo: "label+value+percent parent+percent entry+percent root",
      },
    ];

    let layout = {
      margin: { l: 20, r: 20, b: 20, t: 20 },
      width: 1000,
      height: 1000,
    };

    const options = {};

    let plotDiv = document.createElement(div.slice(1) + "-" + "99"); //  chartIndex
    console.log(plotDiv);
    chartContainer.appendChild(plotDiv);

    Plotly.react(plotDiv, traces, layout, options);
  }
</script>
