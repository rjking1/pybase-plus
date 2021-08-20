<script>
  import { onMount } from "svelte";

  import { doFetch, isAllowedTo, titleCase, viewDetail } from "../../common/dbutils";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { dbN, page, permissions, views } from "./Stores.js";

  let p
  let viewName
  let v
  let links = null;

  onMount(async () => {
    await doGetLinks() 
  });

  async function doGetLinks() {
    p = pageDetails();
    viewName = p.viewName;  // "index" first time
    v = viewDetail($views, viewName);
    console.log(v);

    let sql = v.get_sql.replace("%d", p.id); // prob no need for replacing %d
    links = await doFetch($dbN, sql);
  }

  async function viewClick(name, formdesc) {
    switch (formdesc) {
      case "!index":
        $page = gotoPage("index", name, 0);
        await doGetLinks();
        break;
      case "!calendar":
        $page = gotoPage("calendar", name, 0);
        break;
      case "!chart bar":
      case "!chart dots":
      case "!chart heatmap":
      case "!chart treemap":
      case "!chart pie":
        $page = gotoPage("chart", name, 0);
        break;
      default:
        $page = gotoPage("members", name, 0);
    }
  }
</script>

<main>
  {#if links}
    {#each links as view}
      {#if isAllowedTo($permissions, view.name) && !view.name.startsWith("py_")}
        <button
          on:click={viewClick(view.name, view.formdesc)}
        >
          ▸ {view.name}</button
        >
        <br />
      {/if}
    {/each}
    {#each links as view}
      {#if isAllowedTo($permissions, view.name) && view.name.startsWith("py_")}
        <button
          on:click={viewClick(view.name, view.formdesc)}
        >
          ▸ {view.name}</button
        >
        <br />
      {/if}
    {/each}
  {/if}
</main>

<style>

</style>
