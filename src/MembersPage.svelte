<script>
  import { onMount } from "svelte";

  import { doFetch, isAllowedTo, titleCase, viewDetail } from "./Common.js";
  import { dbN, page, permissions, views } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";

  let p
  let v
  let viewName
  // let columns = [];
  let qresult = null;
  let viewIsEditable = false;
  let hideCols
  // let fieldTypes   // not needed for lists atm

  onMount(async () => {
    p = pageDetails()
    viewName = p.viewName
    v = viewDetail($views, viewName)
    viewIsEditable = isAllowedTo($permissions, viewName + "_edit")
    doListMembers()
  });

  async function doListMembers() {
    let sql = v.get_sql
    let ff = JSON.parse(v.form_fields)
    hideCols = (ff === null) ? [] : ff.hidden
    // console.log(hideCols)
    //fieldTypes = JSON.parse(v.field_types)
    //console.log(fieldTypes)
    qresult = await doFetch($dbN, sql);
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
    $page = "email"   // tooo: make an action
  }

  function editId(anID) {
    $page = gotoPage("memberEdit", v.to_view, anID)
  }

  function addRow() {
    $page = gotoPage("memberEdit", v.to_view, 0)  // should this be .to_view + '_add'
  }

  function doCheckAll() {
    let cboxes = Array.from(document.getElementsByClassName("checkable"))
      cboxes.forEach((cbox) => cbox.checked = document.getElementById("idCheckAll").checked)
  }

</script>

<main>
  <h3>{viewName}</h3>
  <!-- <select id="id_view" bind:value={viewName} on:change={doListMembers}>
    {#each $views as view}
      <option value={view.name}>{view.name}</option>
    {/each}
  </select>
  <button type="button" on:click={doListMembers}>List</button> -->

  {#if qresult}
    <table>
      <tr>
        <th><input id="idCheckAll" type="checkbox" unchecked on:click={doCheckAll} /></th>
        {#each Object.keys(qresult[0]) as column, index}
          {#if !(hideCols.includes(column.toLowerCase()))}
            <th>{titleCase(column)}</th>
          {/if}
        {/each}
      </tr>

      {#each qresult as row}
        <tr>
          <td>
            <input class="checkable" type="checkbox" unchecked /> 
            {#if viewIsEditable}
              <button on:click={editId(Object.values(row)[0])}>✎</button>
            {/if}
          </td>
          {#each Object.values(row) as cell, index}
            {#if !(hideCols.includes(Object.keys(qresult[0])[index].toLowerCase()))}
              <td class="cell" contenteditable="false" bind:innerHTML={cell} />
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
      {#if viewIsEditable}
        <button on:click={addRow}>+ Add</button>
      {/if}
    </table>

    <br>
    <button on:click={saveToXL}>Save as CSV file</button>
    <!-- <button on:click={gotoEmail}>Email...</button> -->
  {/if}
</main>

<style>
  tr:nth-child(even) {
    background: rgb(229, 233, 218);
  }
  tr:nth-child(odd) {
    background: #fff;
  }

  .cell { padding-left: 5px; padding-right: 5px;}
</style>
