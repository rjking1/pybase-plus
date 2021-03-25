<script>
  import { onMount } from "svelte";
  // import { object_without_properties } from "svelte/internal";

  import { doFetch, titleCase } from "./Common.js";
  import { dbN, page, id } from "./Stores.js";

  // export let id
  let result;
  let qresult;

  onMount(async () => {
    if ($id == 0) {
      result = await doFetch(
        $dbN,
        "select myQuery.* from (select 1) as ignoreMe left join (select * from members where false ) as myQuery on true"
      );
    } else {
      result = await doFetch(
        $dbN,
        "select * from members where id = " + $id 
      );
    }
    qresult = result[0];
  });

  function doUpdate() {
    $page = "members";
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
