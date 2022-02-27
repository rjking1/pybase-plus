<!-- <svelte:options accessors={true} /> -->
<script>
  import DataFrame from "dataframe-js";

  // maybe this should be given either // a view // or the sql statement // or the
  // data (that is what it does here)

  export let div;
  export let data;
  export let chartType;
  export let opts;

  // if charttype not set then does nothing (ie for addChartWidget)

  console.log("in chartWidget:" + div);
  console.log("chartType:" + chartType);

  let chartContainer = document.querySelector(div);
  chartContainer.innerHTML = ""; // prob better to while (el.hasChildElements()) { el.removeChild(el.lastChild)) }

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
            // const seriesName = series_col_name != "!s" ? series_value + " " + col : col; // todo -- need option as to whether we add col to series_value
            const seriesName = series_col_name != "!s" ? series_value : col; // todo -- for the moment do as in nempy - don't append col so colour lookup works
            const series_type =
              col.endsWith("_") || col.endsWith("$")
                ? "scatter"
                : series_value == undefined
                ? "bar"
                : series_value.endsWith("_") || series_value.endsWith("$")
                ? "scatter"
                : "bar"; // lookup in endsWith dictionary
            const line_type = col.endsWith(".") ? "dot" : "solid";
            traces.push({
              name: seriesName,
              x: x,
              y: df_filt.toArray(col),
              type: series_type,
              mode: "lines",
              line: { dash: line_type },
              marker: { color: colourFromName(seriesName, series_type) },
              yaxis: col.endsWith("$")
                ? "y2"
                : series_value == undefined
                ? "y"
                : series_value.endsWith("$")
                ? "y2"
                : "y",
            });
          }
        });
      }

      const layout = {
        title: charts_col_name == "!c" ? opts.datetime : chart_value, // todo: allow opts.title?
        xaxis: { title: opts.x },
        yaxis: { title: opts.y1, side: "left" },
        yaxis2: { title: opts.y2, side: "right", overlaying: "y" },
        barmode: stacked ? "relative" : "group", // todo support opts.barmode
        width: opts.width || 800,
        height: opts.height || 850,
      };

      let config = {
        modeBarButtonsToAdd: [
          {
            name: "downloadCsv",
            title: "Download data as csv",
            icon: Plotly.Icons.disk,
            click: saveChartToCSV,
          },
        ],
      };

      let plotDiv = document.createElement('div');
      plotDiv.setAttribute('id', div.slice(1) + "-" + chartIndex);
      console.log(plotDiv);
      chartContainer.appendChild(plotDiv);
      // let Plot = new
      Plotly.react(plotDiv, traces, layout, config);
      chartIndex++;
    }
  }

  if (chartType == "treemap" || chartType == "sunburst") {
    let parents = [];
    let labels = [];
    let values = [];
    // let text = [];
    let ids = [];
    let texttemplates = [];

    opts.rootName = opts.rootName || "NEM";
    opts.units = opts.units || "MW";

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
          par = opts.rootName;
        }
        if (lab) {
          if (i > 0) {
            ids.push(Object.values(row)[i - 1] + ":" + lab);
            labels.push(lab);
          } else {
            ids.push(lab);
            labels.push(lab);
          }
          if (i > 1) {
            parents.push(Object.values(row)[i - 2] + ":" + par);
          } else {
            parents.push(par);
          }
          values.push(val);
          // text.push(val + " " + opts.units);
          if (i == 0) {
            texttemplates.push(
              "%{label}<br>%{percentParent:.1%} of %{parent}<br>%{value} " +
                opts.units
            );
          } else {
            texttemplates.push(
              "%{label}<br>%{percentParent} of %{parent}<br>%{percentRoot:.1%} of " +
                opts.rootName +
                "<br>%{value} " +
                opts.units
            );
          }
          break;
        } else {
          if (i == 0) {
            // then add root with no parent
            ids.push(opts.rootName);
            labels.push(opts.rootName);
            parents.push(""); // root
            values.push(val + 1); // to avoid rounding summation error
            // text.push(val + " " + opts.units);
            texttemplates.push("%{label}<br>%{value} " + opts.units);
          }
        }
      }
    });

    let traces = [
      {
        type: chartType,
        branchvalues: "total",
        values: values,
        // text: text,
        labels: labels,
        parents: parents,
        ids: ids,
        // textinfo: "label+text+percent parent+percent root",
        texttemplate: texttemplates,
        hoverinfo: "label+value+percent parent+percent root",
      },
    ];

    const layout = {
      title: opts.datetime,
      margin: { l: 20, r: 20, b: 20, t: 40 },
      width: opts.width || 800,
      height: opts.height || 850,
    };

    const config = {
      modeBarButtonsToAdd: [
        {
          name: "downloadCsv",
          title: "Download data as csv",
          icon: Plotly.Icons.disk,
          click: saveChartToCSV,
        },
      ],
    };

    let plotDiv = document.createElement(div.slice(1) + "-" + "99"); //  chartIndex
    console.log(plotDiv);
    chartContainer.appendChild(plotDiv);

    Plotly.react(plotDiv, traces, layout, config);
  }

  function saveChartToCSV() {
    let fileName = "saved_chart";
    fileName = window.prompt("Save to file name?", fileName);
    if (fileName != null) {
      let csv = [];

      let col_names = Object.keys(data[0]);
      let row = [];
      col_names.forEach((col) => {
        row.push(col);
      });
      csv.push(row.join());

      data.forEach((dataRow) => {
        row = [];
        Object.values(dataRow).forEach((cell) => {
          row.push(cell);
        });
        csv.push(row.join(","));
      });
      const csvFile = csv.join("\n");

      // let csvFile = csv
      //   .map((e) =>
      //     e
      //       .map((a) => '"' + (a || "").toString().replace(/"/gi, '""') + '"')
      //       .join(",")
      //   )
      //   .join("\r\n"); //quote all fields, escape quotes by doubling them.

      let blob = new Blob([csvFile], { type: "text/csv;charset=utf-8;" });
      let link = document.createElement("a");
      let url = URL.createObjectURL(blob);
      link.setAttribute("href", url);
      link.setAttribute(
        "download",
        fileName.replace(/[^a-z0-9_.-]/gi, "_") + ".csv"
      );

      link.style.visibility = "hidden";
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    }
  }

  function colourFromName(n, typ) {
    const colourMap = {
      hydro: "#1f77b4", // muted blue
      gas: "#ff7f0e", // safety orange
      // xwind: "#2ca02c", // cooked asparagus green
      wind: "#8de5db", // lighter green
      "battery storage": "#d62728", // brick red
      "liquid fuel": "#9467bd", // muted purple
      "brown coal": "#8c564b", // chestnut brown
      biomass: "#e377c2", // raspberry yogurt pink
      "black coal": "#7f7f7f", // middle gray
      solar: "#bcbd22", // curry yellow-green
      // "xhydro storage": "#17becf", // blue-teal
      "hydro storage": "#62b2e6", // skyish blue
      "rooftop pv": "#ffbe7f", // corn silk like colour
      // '#d8696b'  // lesser brick red -- spare
      qld1: "#d62728", // brick red
      nsw1: "#1f77b4", // muted blue
      vic1: "#8de5db", // lighter green
      sa1: "#ff7f0e", // safety orange
      tas1: "#9467bd", // muted purple
    };
    return colourMap[n.toLowerCase()] || stringToColour(n, typ);
  }

  // https://stackoverflow.com/questions/5560248/programmatically-lighten-or-darken-a-hex-color-or-rgb-and-blend-colors -- one liner way down
  function adjustColour(color, amount) {
    return '#' + color.replace(/^#/, '').replace(/../g, color => ('0'+Math.min(255, Math.max(0, parseInt(color, 16) + amount)).toString(16)).slice(-2)); // need to do something here as well
  }

  function stringToColour(str, typ) {
    let hash = 0;
    for (let i = 0; i < str.length; i++) {
      hash = str.charCodeAt(i) + ((hash << 5) - hash);
    }
    let colour = "#";
    for (let i = 0; i < 3; i++) {
      let value = (hash >> (i * 8)) & 0xff;
      // if(typ=="bar" && value < 0xb0){
      //   value += 0x10; //  attempt to lighten bar colours
      // }
      // if(typ!="bar" && value > 0x10){
      //   value -= 0x10; //  attempt to darken line colours
      // }
      colour += ("00" + value.toString(16)).slice(-2); // was substr(-2)
    }
    // console.log(colour)
    colour = adjustColour(colour, typ == "bar" ? 40 : -40);
    console.log(colour)
    return colour
  }

  //  const crypto = require('crypto')

  // var txtToHash = "Hello¤World¤";
  // var md5sum = crypto.createHash('md5');
  // md5sum.update(new Buffer(txtToHash, 'binary')); -- new: md5sum.update(new Buffer(txtToHash, 'utf8'));
  // md5val = md5sum.digest('hex');

  // def colorhash(s):
  //     h = hashlib.md5(s.encode()).hexdigest()
  //     #print('colorhash({})={}'.format(s,h[:6]))
  //     return '#{}{}{}{}{}{}'.format(h[0],h[0], h[1],h[1], h[-2],h[-2])

  // #def colors_from_labels(labels):
  // #    return [color_map.get(x, colorhash(x)) for x in labels]

  // def color_from_name(x):
  //     t = x.replace('.', '')
  //     return color_map.get(t, colorhash(t))
</script>
