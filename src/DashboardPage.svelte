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
    let result = await doGetPrices();
    // console.log(result);
    for (let reg of regionNames) {
      addWidget("#" + reg + "_price", reg);
      addWidget("#" + reg + "_price", lookup(result, reg + "_price"));
      addWidget("#" + reg + "_price", "x");
    }

    result = await doGetResult(
      `select concat(p.regionid, "_price") as "key", rrp as "value" from DISPATCH__PRICE p 
      where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE)`
    );
    addTableWidget("#t1", result);
  }

  function lookup(rows, key) {
    return rows.find((row) => row.key === key)["value"];
  }

  async function doGetPrices() {
    const sql = `select concat(p.regionid, "_price") as "key", rrp as "value" from DISPATCH__PRICE p 
      where p.settlementdate >= (select max(settlementdate) from DISPATCH__PRICE)
    `;
    return await doFetch($dbN, sql);
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
</script>

<main>
  {@html html}
</main>

<style>
</style>
