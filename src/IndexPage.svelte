<script>
import { onMount } from "svelte";

import { doFetch, titleCase } from "./Common.js";
import { gotoPage } from "./pageStack.js";
import { dbN, page, viewName } from "./Stores.js";

  let views = null;

  onMount(async () => {
    views = await doFetch(
      $dbN,
      "select id, name from py_views where incl_in_index='Y' and not name like 'PY_%' order by name"
    );
  });

  function viewClick(name) {
    $viewName = name
    // $page = 'members'
    $page = gotoPage('members', name, 0)  // todo: get rid of $viewName as at top of stack
  }

</script>

<main>
  {#if views}
    <ul>
      {#each views as view}
        <button on:click={viewClick(view.name)}> ▶ {view.name}</button>
        <br>
      {/each}
    </ul>
  {/if}
</main>

<style>
</style>
