<script>
  import {
    doFetch,
    doBuRest,
    doRunpy,
    writeAuditText,
  } from "../../common/dbutils";

  import { dbN, dbName, permissions } from "./Stores.js";

  let [db, server_abbrev] = $dbName.split(":");
  let backupToFile = db;
  let backupFromDB = db;
  let restoreToDB = "test";
  let opts = "";
  let tables = "";
  let py_params = "2021 mm dd 12 00 load";
  let sql = "select * from py_logs order by date_time desc limit 50";
  let result;
  let text_result;
  let cmd = "";

  async function doBackup() {
    cmd = "Backing up...";
    await doBuRest($dbN.server, backupFromDB, backupToFile, "b", opts, tables);
    cmd = "Backed up";
  }

  async function doRestore() {
    cmd = "Restoring...";
    cmd = await doBuRest($dbN.server, restoreToDB, backupToFile, "r", "", "");
    cmd = "Restored";
  }

  async function doQuery() {
    result = await doFetch($dbN, sql);
    writeAuditText(
      $dbN,
      $permissions.u_id,
      $permissions.u_name,
      "sql query: " + sql
    );
  }

  async function doLoadHist() {
    cmd = "Loading...";
    text_result = await doRunpy($dbN.server, py_params);
    cmd = "Loaded";
  }
</script>

database <input id="bu_db" class="short" bind:value={backupFromDB} />
to file <input id="bu_file" class="short" bind:value={backupToFile} />
opts <input id="opts" class="short" bind:value={opts} />
tables <input id="tables" class="short" bind:value={tables} />
<button id="backup" on:click={doBackup}>Backup</button>
<br />
file <input id="rest_file" class="short" bind:value={backupToFile} />
to database <input id="rest_db" class="short" bind:value={restoreToDB} />
<button id="restore" on:click={doRestore}>Restore</button>
<hr />
params <input id="py_params" class="short" bind:value={py_params} />
<button id="run_py" on:click={doLoadHist}>Load Historical data</button>
<hr />
<div id="status">
  <span style="background-color: rgb(251, 243, 199);">{cmd}</span>
</div>
<hr />
SQL<br />
<textarea id="sql" rows="4" bind:value={sql} />
<button id="query" on:click={doQuery}>Query</button>

{#if text_result}
  <hr />
  {text_result}
  <hr />
{/if}

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
    width: 100%;
  }
</style>
