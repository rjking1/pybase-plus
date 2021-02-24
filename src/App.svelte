<svelte:head>
	<script src="https://smtpjs.com/v3/smtp.js"></script>
</svelte:head>
<script>
    import { doFetch } from './common.js'

	let db = 'art25285_hut'
	let sql = "select * from members limit 5" 

	let sender = "heather@artspace7.com.au"
	let subject = "Test"
	let contents = "Something to say"
	let encrypted = ""

	let result = null
	
	//fetch('https://www.artspace7.com.au/dsql/json_helper_get.php?db=art25285_rides2&sql=select%20*%20from%20bikes')

	async function doQuery() {
		result = await doFetch(db, sql)
		console.log(result)
	}

	async function doSend() {
		result.forEach(element => {
			
		Email.send({
			Host : "mail.artspace7.com.au",
			Username : "art25285",
			Password : "ear724gni",
			To : element["EMAIL"],
			From : sender,
			Subject : subject,
			Body : contents
		}).then(
		message => console.log(message)
		);
		});
	}

</script>

<style>
	input { width: 60% }
	textarea { width: 60%; height: 20% }
</style>


<label>db</label><input bind:value={db} />
<label>sql</label><input bind:value={sql} />
<br>
<button type="submit" on:click={doQuery}>
	Query
</button>
<p><b>Email</b></p>
<label>From</label><input bind:value={sender} />
<label>Subject</label><input bind:value={subject} />
<label>Contents</label><textarea bind:value={contents} />
<br>
<button type="submit" on:click={doSend}>
	Send Emails
</button>

<!-- <pre>
{#if result}
<ul>
	{#each result as row}
		<li>
			{#each Object.values(row) as field}
				{field + ' '}
			{/each}
		</li>
	{/each}
</ul> 
{/if}
</pre> -->

<pre>
{#if result}
<ul>
	{#each result as row}
		<li>
			{row["NAME"]} {row["LASTNAME"]} {row["EMAIL"]}
		</li>
	{/each}
</ul> 
{/if}
</pre>
