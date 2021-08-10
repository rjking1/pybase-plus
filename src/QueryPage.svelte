<script>
	import { doFetch } from "./Common.js";

	// import { onMount } from "svelte";
	import { dbN, dbName } from "./Stores.js";

	let backupToFile = $dbName;
	let backupFromDB = $dbName;
	let restoreToDB = 'test';
	let sql = "select * from py_logs order by date_time desc limit 50";
	let result = undefined;
	let cmd = "";

	// the following will work but is a post frm within pybase now
	//fetch('https://www.artspace7.com.au/dsql/json_helper_get.php?db=art25285_rides2&sql=select%20*%20from%20bikes')

	async function doBackup() {
		cmd = await doBuRest(backupFromDB, backupToFile, 'b');
	}

	async function doRestore() {
		cmd = await doBuRest(restoreToDB, backupToFile, 'r');
	}

	async function doQuery() {
		result = await doFetch($dbN, sql);
	}

	async function doBuRest(db, filename, func) {
		let formData = new FormData()
		formData.append('db', db)
		formData.append('filename', filename) 
		formData.append('func', func)

		return await fetch(
			`https://www.artspace7.com.au/dsql/burest.php`,
			{
			method: 'POST',
			body: formData,
			},
		)
	}


</script>

database <input id="bu_db" class="short" bind:value={backupFromDB} /> 
to file <input id="bu_file" class="short" bind:value={backupToFile} /> 
<button id="backup" on:click="{doBackup}">Backup</button>
<br>
file <input id="rest_file" class="short" bind:value={backupToFile} /> 
to database <input id="rest_db" class="short" bind:value={restoreToDB} /> 
<button id="restore" on:click="{doRestore}">Restore</button>
<hr>
{cmd}
<hr>
SQL<br>
<textarea id="sql" bind:value={sql}></textarea>
<button id="query" on:click="{doQuery}">Query</button>

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
	.short {
		width: 300px;
	}
	input {
		width: 60%;
	}
	textarea {
		width: 90%;
		height: 20%;
	}
</style>
