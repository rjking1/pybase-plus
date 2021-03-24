<script>
  import { onMount } from "svelte";

  import { doFetch, titleCase } from "./Common.js";
  import { dbN, page } from "./Stores.js";

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


function downloadCSV(csv, filename) {
    var csvFile;
    var downloadLink;

    // CSV file
    csvFile = new Blob([csv], {type: "text/csv"});

    // Download link
    downloadLink = document.createElement("a");

    // File name
    downloadLink.download = filename;

    // Create a link to the file
    downloadLink.href = window.URL.createObjectURL(csvFile);

    // Hide download link
    downloadLink.style.display = "none";

    // Add the link to DOM
    document.body.appendChild(downloadLink);

    // Click download link
    downloadLink.click();
}

function exportTableToCSV(filename) {
    var csv = [];
    var rows = document.querySelectorAll("table tr");
    
    for (var i = 0; i < rows.length; i++) {
        var row = [], cols = rows[i].querySelectorAll("td, th");
        
        for (var j = 0; j < cols.length; j++) 
            row.push(cols[j].innerText);
        
        csv.push(row.join(","));        
    }

    // Download CSV file
    downloadCSV(csv.join("\n"), filename);
}

  function saveToXL() {
    exportTableToCSV("pybase.csv")  
  }

  function gotoEmail() {
    $page = "email"
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

    <br>
    <button on:click={saveToXL}>Save as CSV file</button>
    <button on:click={gotoEmail}>Email...</button>
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
