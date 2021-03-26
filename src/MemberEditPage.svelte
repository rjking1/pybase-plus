<script>

import { onMount } from "svelte";
import { doFetch, titleCase } from "./Common.js";
import { goBack, pageDetails } from "./pageStack.js";
import { dbN, page, id } from "./Stores.js";

  let result;
  let qresult;

  onMount(async () => {
    let p = pageDetails()
    if ($id == 0) {
      result = await doFetch(
        $dbN,
        "select myQuery.* from (select 1) as ignoreMe left join (select * from " + p.viewName + "s where false ) as myQuery on true"  // todo: fix ...
      );
    } else {
      result = await doFetch(
        $dbN,
        "select * from " + p.viewName + "s where id = " + p.id  // todo: fix - not real purpose of viewname
      );
    }
    qresult = result[0];
  });

  function doUpdate() {
    $page = goBack(); // "members";
  }
</script>

<main>
  {#if qresult}
    {#each Object.keys(qresult) as column, index}
      <tr>
        <td>{titleCase(column)}</td>
        <td><input type="text" value={Object.values(qresult)[index]} /> </td>
      </tr>
    {/each}
  {/if}
  <button on:click={doUpdate}>Update</button>
</main>

<style>
  input {
    width: 300px;
  }
</style>
