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
    let csvFile = new Blob([csv], {type: "text/csv"});
    let downloadLink = document.createElement("a");
    downloadLink.download = filename;
    // Create a link to the file
    downloadLink.href = window.URL.createObjectURL(csvFile);
    // Hide download link
    downloadLink.style.display = "none";
    document.body.appendChild(downloadLink);
    downloadLink.click();
}

function exportTableToCSV(filename) {
    let csv = [];
    let rows = document.querySelectorAll("table tr");
    
    for (let i = 0; i < rows.length; i++) {
        let row = []
        let cols = rows[i].querySelectorAll("td, th");
        
        for (let j = 0; j < cols.length; j++) 
            row.push(cols[j].innerText);
        
        csv.push(row.join(","));        
    }

    downloadCSV(csv.join("\n"), filename);
}

  function saveToXL() {
    exportTableToCSV("pybase.csv")  // can we gen a file name from selected list?
  }

  function gotoEmail() {
    $page = "email"
  }

  function gotoMemberEdit() {
    $page = "memberEdit"
  }

  function doCheckAll() {
    let cboxes = Array.from(document.getElementsByClassName("checkable"))
      cboxes.forEach((cbox) => cbox.checked = document.getElementById("idCheckAll").checked)
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
        <th><input id="idCheckAll" type="checkbox" unchecked on:click={doCheckAll} /></th>
        {#each Object.keys(qresult[0]) as column, index}
          {#if index > 0 || !firstColIsID}
            <th>{titleCase(column)}</th>
          {/if}
        {/each}
      </tr>

      {#each qresult as row}
        <tr>
          <td><input class="checkable" type="checkbox" unchecked /></td>
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
    <button on:click={gotoMemberEdit}>Member Edit...</button>
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
