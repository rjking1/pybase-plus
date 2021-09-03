<script>
  import DataFrame from "dataframe-js";

  // maybe this should be given either // a view // or the sql statement // or the
  // data (that is what it does here)

  export let div;
  export let data;
  export let opts;

  // console.log(div);
  let chartContainer = document.querySelector(div);

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

  let chartIndex = 0;
  for (const chart_value of charts_values) {
    let traces = [];
    let stacked = false;
    for (const series_value of series_values) {
      // console.log(series_value);
      let df_filt = df.filter((row) => row.get(charts_col_name) == chart_value);
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
      title: charts_col_name == "!c" ? "title" : chart_value, // todo: allow opts.title?
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
    Plotly.newPlot(plotDiv, traces, layout, options);
    chartIndex++;
  }
</script>
