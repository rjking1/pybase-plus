<script>
  import { onMount } from "svelte";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
  } from "../../common/dbutils";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { dbN, page, permissions, views } from "./Stores.js";
  import Widget from "./Widget.svelte";
  import TableWidget from "./TableWidget.svelte";
  import ChartWidget from "./ChartWidget.svelte";

  let p;
  let viewName;
  let v;
  let html = undefined;
  // let Widget;

  const regionNames = ["QLD1", "NSW1", "VIC1", "SA1", "TAS1"];

  onMount(async () => {
    // Widget = (await import('./Widget.svelte')).default;
    await doGetHTML();
    await doUpdateAll();

    // this updates on each character.  on:change does the same
    //do I need to do the "debouncing"? ie wait for Enter?
    document.getElementById("market-time").addEventListener("input", () => {
      doUpdateAll();
    });
  });

  async function doGetHTML() {
    p = pageDetails();
    viewName = "dashboard"; //p.viewName;  // "dashboard" first time
    v = viewDetail($views, viewName);
    // console.log(v);
    html = v.formDesc;
  }

  async function doUpdateAll() {
    const matches = document.querySelectorAll("[id^='sql']");
    let sql = matches[0].dataset.sql; // special function: reads data-sql attribute
    // console.log(sql);

    // should the sql matches result drive what we populate in the dashboard?
    // do the fields need to be prefixed with the sql id/number?

    let result = await doGetResult(sql);
    //   `select concat(p.regionid, "_price") as "key", rrp as "value" from DISPATCH__PRICE p
    //   where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE)`
    // );
    // console.log(result);
    for (let reg of regionNames) {
      addWidget("#" + reg + "_price", reg);
      addWidget("#" + reg + "_price", lookup(result, reg + "_price"));
      addWidget("#" + reg + "_price", "x");
    }

    sql = matches[1].dataset.sql; // special function: reads data-sql attribute
    // console.log(sql);

    /// we already have all the sql in memory in the $views store
    // so should allow a view name to be used
    // which avoids needing to have a copy in the html
    // but having sql in the html as an option allows for max flexibility

    result = await doGetResult(sql);
    //   `select p.regionid as "Region", format(rrp, 2) as "RRP", format(clearedsupply,0) as "Demand",
    //   format(dispatchablegeneration,0) as "Generation" ,
    //   format(availablegeneration,0) as "Available"
    //   from DISPATCH__PRICE p join DISPATCH__REGIONSUM r
    //   on p.settlementdate = r.settlementdate and p.regionid = r.regionid
    //   where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE) - interval 1 minute
    //   and r.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE) - interval 1 minute
    //   order by 1`
    // );
    addTableWidget("#t1", result);

    // an advantage of not passing a view into the table or chart widgets is that we can share the result
    // tho I'm not doing that here !

    let dt;
    let el = document.getElementById("market-time");
    if (el) {
      dt = el.value;
    } else {
      dt = new Date().toISOString();
    }
    // console.log(dt);
    if (dt != "") {
      let sql = 
      'select regionid as "_", settlementdate, rrp as "rrp_" from DISPATCH__PRICE where settlementdate >= "' +
      dt + '" - interval 30 minute and settlementdate <= "' + dt + '" + interval 30 minute';
      console.log(sql);
      result = await doGetResult(sql);
      addChartWidget("#c1", result);
    }

    // need a way of specifying a view name in the html id="view-1"?

    sql = viewDetail($views, "09 Current gen").get_sql;
    console.log(sql);
    result = await doGetResult(sql);
    addChartWidget("#c2", result);
  }

  function lookup(rows, key) {
    return rows.find((row) => row.key === key)["value"];
  }

  async function doGetResult(sql) {
    return await doFetch($dbN, sql);
  }

  function addWidget(s, v) {
    new Widget({
      target: document.querySelector(s),
      props: {
        txt: v,
      },
    });
  }

  function addTableWidget(s, v) {
    new TableWidget({
      target: document.querySelector(s),
      props: {
        qresult: v,
      },
    });
  }

  function addChartWidget(s, data, opts) {
    new ChartWidget({
      target: document.querySelector(s),
      props: {
        div: s,
        data: data,
        opts: {},
      },
    });
  }
</script>

<main>
  {@html html}
</main>

<style>
</style>
