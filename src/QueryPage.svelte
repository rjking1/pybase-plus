<script>
  import { BUREST_PHP } from "./config.js";
  import { doFetch } from "./common.js";

  // import { onMount } from "svelte";
  import { dbN, dbName } from "./Stores.js";

  let backupToFile = $dbName;
  let backupFromDB = $dbName;
  let restoreToDB = "test";
  let sql = "select * from py_logs order by date_time desc limit 50";
  let result = undefined;
  let cmd = "";

  async function doBackup() {
    cmd = "Backing up...";
    await doBuRest(backupFromDB, backupToFile, "b");
    cmd = "Backed up";
  }

  async function doRestore() {
    cmd = "Restoring...";
    cmd = await doBuRest(restoreToDB, backupToFile, "r");
    cmd = "Restored";
  }

  async function doQuery() {
    result = await doFetch($dbN, sql);
  }

  async function doBuRest(db, filename, func) {
    let formData = new FormData();
    formData.append("db", db);
    formData.append("filename", filename);
    formData.append("func", func);

    return await fetch(BUREST_PHP, {
      method: "POST",
      body: formData,
    });
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
<div id=status>{cmd}</div>
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
