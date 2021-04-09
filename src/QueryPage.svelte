<script>
	import { doFetch } from "./Common.js";

	import { onMount } from "svelte";
	import { dbN, permissions } from "./Stores.js";

	let sql = "select * from members where lastname = 'King'";
	let result = undefined;

	//fetch('https://www.artspace7.com.au/dsql/json_helper_get.php?db=art25285_rides2&sql=select%20*%20from%20bikes')

	async function doQuery() {
		result = await doFetch($dbN, sql);
		// console.log(result)
	}

</script>

<label>SQL</label><input bind:value={sql} />
<button type="submit" on:click={doQuery}>Query</button>

{#if result}
	<table>
		<tr>
			{#each Object.keys(result[0]) as column}
				<th>{column}</th>
			{/each}
		</tr>

		{#each result as row}
			<tr>
				{#each Object.values(row) as cell, index}
					<td
						class="cell"
						contenteditable="false"
						bind:innerHTML={cell}
					/>
				{/each}
			</tr>
		{/each}
	</table>
{/if}

<style>
	input {
		width: 60%;
	}
	textarea {
		width: 60%;
		height: 20%;
	}
</style>
