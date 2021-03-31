<svelte:head>
	<script src="https://smtpjs.com/v3/smtp.js"></script>
</svelte:head>
<script>
    import { doFetch, logToLogs } from './common.js'

	import { onMount } from 'svelte'
import { permissions } from './Stores.js';

	let db = 'art25285_hut'
	let sql = "select * from members where NAME = 'Richard' and News_Email = 'Y'"
	let viewName = "News Email"
	let templateName = 'Welcome email'

	let sender = "no-reply@ftgas.com.au"
	let subject = "SUBJECT"
	let template_contents = "<html>\nHi !name\nPASTE HERE\n...<a href=\"www.artspace7.com.au/pybase/plus/hut/news/test.pdf\">Newsletter.pdf</a>\n</html>"
	let attachments = "https://artspace7.com.au/pybase/hut/news/test.pdf"
	let encrypted = ""
	let atts = undefined

	let result = null

	let views = []
  	let templates = []

  	onMount(async () => {
    	views = await doFetch(db, "select id, name from py_views where incl_in_index='Y' and not name like 'PY_%' order by name")
    	templates = await doFetch(db, "select id, name from py_templates where class='email' order by name")
  	})
	
	//fetch('https://www.artspace7.com.au/dsql/json_helper_get.php?db=art25285_rides2&sql=select%20*%20from%20bikes')

	async function doQuery() {
		result = await doFetch(db, sql)
		// console.log(result)
	}

	async function doView() {
		let rows = await doFetch(db, "SELECT get_sql FROM py_views WHERE name = '" + viewName + "'")
		sql = rows[0]["get_sql"]
		result = await doFetch(db, sql)
		// console.log(result)
	}

	async function doLoadtemplate() {
		let rows = await doFetch(db, "SELECT contents FROM py_templates WHERE name = '" + templateName + "'")
		template_contents = rows[0]["contents"]
		// template_contents = await doFetch(db, sql)
	}

	async function doSend() {
		if (attachments != '') {
			atts = [
						{
							name : "newsletter.pdf",
							path : attachments
						}
					]
		}
		result.forEach(row => {
			let contents = template_contents.replace("!name", row["NAME"])

			if(row["EMAIL"]) {			
				Email.send({
					Host : "mail.artspace7.com.au",
					Username : "art25285",
					Password : "ear724gni",
					To : row["EMAIL"],
					From : sender,
					Subject : subject,
					Body : contents,
					Attachments : atts
				}).then(
					message => {
						console.log(row["EMAIL"], message)
						logToLogs(db, $permissions.u_id, $permissions.u_name, "emailed " + row["EMAIL"] + " subject " + subject + " response " + message) 
					}
				); 
			}
		});
	}

</script>

<style>
	input { width: 60% }
	textarea { width: 60%; height: 20% }
</style>


<label>db</label><input bind:value={db} />
<label>sql</label><input bind:value={sql} />
<button type="submit" on:click={doQuery}>SQL Query</button>

<label>View</label>
<select id="id_view" bind:value={viewName}>
  {#each views as view}
    <option value={view.name}>{view.name}</option>
  {/each}
</select>

<button type="submit" on:click={doView}>View Query</button>

<label>Template</label>
<select id="id_template" bind:value={templateName}>
  {#each templates as template}
    <option value={template.name}>{template.name}</option>
  {/each}
</select>

<button type="submit" on:click={doLoadtemplate}>Load</button>

<br>
<p><b>Email</b></p>
<label>From</label><input bind:value={sender} />
<label>Subject</label><input bind:value={subject} />
<label>Contents</label><textarea bind:value={template_contents} />
<label>Attachment</label><input bind:value={attachments} />
<br>

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

<button type="submit" on:click={doSend}>
	Send Emails
</button>