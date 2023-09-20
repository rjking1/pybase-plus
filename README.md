# Charting

types

line, bar heatmap or sunburst

put a ine before the SQL as follows

-- {"option":"value", ...}

select sql follows

Options

"colours": "default"
"width: n
"height": n
"x": "x axis title"
"y1: "left y axis title"
"y2: "right y axis title"
"rangemode": "tozero"  // for y axes

select [chart_title as '$',] [series_title as '_',] [opt datetime], y1, y2, ...


Dashboards

Must have a x_widget (ie something not marked as a widget first - why?)

eg

      <div class="box c">
        <div
          data-id="x_widget"
          data-type="text"
          id="market_time"
          class="box z"
        ></div>
      </div>

      

