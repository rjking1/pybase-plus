<script>
	import { onMount } from 'svelte'

  import { doFetch } from './Common.js'
  import { dbN } from './Stores.js'

  let columns = ['1','2','3']

  let views = []
  let viewName = "Not Renewed"
  let qresult = null

  onMount(async () => {
    	views = await doFetch($dbN, "select id, name from py_views where incl_in_index='Y' and not name like 'PY_%' order by name")
  	})

	async function doListMembers() {
		let rows = await doFetch($dbN, "SELECT get_sql FROM py_views WHERE name = '" + viewName + "'")
		let sql = rows[0]["get_sql"]
		qresult = await doFetch($dbN, sql)
		console.log(qresult)
	}  
</script>

<main>

  <label>View</label>
  <select id="id_view" bind:value={viewName}>
    {#each views as view}
      <option value={view.name}>{view.name}</option>
    {/each}
  </select>

  <button type="button" on:click={doListMembers}>List</button>

  <!-- <pre>
    {#if qresult}
      <ul>
        {#each qresult as row}
          <li>
            {#each Object.values(row) as field}{field + ' '}{/each}
          </li>
        {/each}
      </ul>
    {/if}
  </pre> -->

    {#if qresult}

<table>
	<tr>
		{#each Object.keys(qresult[0]) as column}
			<th>{column}</th>
		{/each}
	</tr>
	
	{#each qresult as row}
		<tr>
			{#each Object.values(row) as cell}
			<td contenteditable="true" bind:innerHTML={cell} />
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
  tr:nth-child(even) {background: rgb(229, 233, 218)}
  tr:nth-child(odd) {background: #FFF}
</style>
