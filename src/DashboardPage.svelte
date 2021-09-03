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
    let sql = matches[0].dataset.sql // special function: reads data-sql attribute
    // console.log(sql); 
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

    sql = matches[1].dataset.sql // special function: reads data-sql attribute
    // console.log(sql); 

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

    result = await doGetResult('select settlementdate, rrp as "rrp_" from DISPATCH__PRICE where regionid = "VIC1" order by settlementdate desc limit 50');
    addChartWidget("#c1", result)
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
        opts: {}
      },
    });
  }

</script>

<main>
  {@html html}
</main>

<style>
</style>
