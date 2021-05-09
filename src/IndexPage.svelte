<script>
  import { onMount } from "svelte";

  import { doFetch, isAllowedTo, titleCase } from "./Common.js";
  import { gotoPage } from "./pageStack.js";
  import { dbN, page, permissions } from "./Stores.js";

  let views = null;

  onMount(async () => {
    views = await doFetch(
      $dbN,
      //todo: can't this use $views?
      "select id, name, formdesc from py_views where incl_in_index='Y' order by name" //  and not name like 'PY_%'
    );
  });

  function viewClick(name, formdesc) {
    switch (formdesc) {
      case "!calendar":
        $page = gotoPage("calendar", name, 0);
        break;
      case "!heatmap":
      case "!chart bar":
        $page = gotoPage("chart", name, 0);
        break;
      default:
        $page = gotoPage("members", name, 0);
    }
  }
</script>

<main>
  {#if views}
    {#each views as view}
      {#if isAllowedTo($permissions, view.name)}
        <button
          disabled={!isAllowedTo($permissions, view.name)}
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
