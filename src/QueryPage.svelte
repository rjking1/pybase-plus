<script>
  import { doFetch, doBuRest } from "../../common/dbutils";

  import { dbN, dbName } from "./Stores.js";

  let [db, server_abbrev] = $dbName.split(":");
  let backupToFile = db;
  let backupFromDB = db;
  let restoreToDB = "test";
  let sql = "select * from py_logs order by date_time desc limit 50";
  let result = undefined;
  let cmd = "";

  async function doBackup() {
    cmd = "Backing up...";
    await doBuRest($dbN.server, backupFromDB, backupToFile, "b");
    cmd = "Backed up";
  }

  async function doRestore() {
    cmd = "Restoring...";
    cmd = await doBuRest($dbN.server, restoreToDB, backupToFile, "r");
    cmd = "Restored";
  }

  async function doQuery() {
    result = await doFetch($dbN, sql);
  }
</script>

database <input id="bu_db" class="short" bind:value={backupFromDB} />
to file <input id="bu_file" class="short" bind:value={backupToFile} />
<button id="backup" on:click={doBackup}>Backup</button>
<br />
file <input id="rest_file" class="short" bind:value={backupToFile} />
to database <input id="rest_db" class="short" bind:value={restoreToDB} />
<button id="restore" on:click={doRestore}>Restore</button>
<hr />
<div id="status">
  <span style="background-color: rgb(251, 243, 199);">{cmd}</span>
</div>
<hr />
SQL<br />
<textarea id="sql" bind:value={sql} />
<button id="query" on:click={doQuery}>Query</button>

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
          <td class="cell" contenteditable="false" bind:innerHTML={cell} />
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
