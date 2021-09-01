<script>
  import { onMount } from "svelte";
  import { doFetch, isAllowedTo, titleCase, viewDetail } from "../../common/dbutils";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { dbN, page, permissions, views } from "./Stores.js";
  //import Widget from "./Widget.svelte";

  let p
  let viewName
  let v
  let html;
  let Widget;

  onMount(async () => {
    Widget = (await import('./Widget.svelte')).default;
    await doGetContents() 
  });

  async function doGetContents() {
    p = pageDetails();
    viewName ="dashboard"; //p.viewName;  // "dashboard" first time
    v = viewDetail($views, viewName);
    console.log(v);

    html = v.formDesc;
  }

  function bclick() {
    html = html.replace("!widget", '<svelte:component this={Widget} txt={33.33}></svelte:component>')
    //html = html.replace("!widget", '45.66')

    // let w3 = document.getElementById("w3");
    // w3.innerText = "222.22";
    
  }

  async function doQuery() {
    result = await doFetch($dbN, sql);
  }
</script>

<main>
  {@html html}
  <svelte:component this={Widget} txt={42}></svelte:component>
  <button on:click={bclick}>Update</button> 
</main>

<style>
</style>
