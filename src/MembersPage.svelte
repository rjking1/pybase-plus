<script>
  import { onMount } from "svelte";

  import { doFetch, titleCase } from "./Common.js";
  import { dbN } from "./Stores.js";

  let columns = [];
  let views = [];
  let viewName = "Not Renewed";
  let qresult = null;
  let firstColIsID = true;

  onMount(async () => {
    views = await doFetch(
      $dbN,
      "select id, name from py_views where incl_in_index='Y' and not name like 'PY_%' order by name"
    );
  });

  async function doListMembers() {
    let rows = await doFetch(
      $dbN,
      "SELECT get_sql FROM py_views WHERE name = '" + viewName + "'"
    );
    let sql = rows[0]["get_sql"];
    qresult = await doFetch($dbN, sql);
    firstColIsID = (Object.keys(qresult[0])[0] == 'ID')
  }
</script>

<main>
  <!-- <label>View</label> -->
  <select id="id_view" bind:value={viewName} on:change={doListMembers}>
    {#each views as view}
      <option value={view.name}>{view.name}</option>
    {/each}
  </select>

  <button type="button" on:click={doListMembers}>List</button>

  {#if qresult}
    <table>
      <tr>
        <th />
        {#each Object.keys(qresult[0]) as column, index}
          {#if index > 0 || !firstColIsID}
            <th>{titleCase(column)}</th>
          {/if}
        {/each}
      </tr>

      {#each qresult as row}
        <tr>
          <th><input type="checkbox" unchecked /></th>
          {#each Object.values(row) as cell, index}
            {#if index > 0 || !firstColIsID}
              <td contenteditable="false" bind:innerHTML={cell} />
            {/if}
          {/each}
        </tr>
      {/each}

      <!-- <tr class="new">
		{#each newRow as column}
			<td contenteditable="true" bind:innerHTML={column} />
		{/each}
		<button on:click={addRow}>+</button>
	</tr> -->
    </table>
  {/if}
</main>

<style>
  tr:nth-child(even) {
    background: rgb(229, 233, 218);
  }
  tr:nth-child(odd) {
    background: #fff;
  }
</style>
