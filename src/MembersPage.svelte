<script>
  import { onMount } from "svelte";

  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
    writeAuditText,
  } from "./Common.js";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";

  let p;
  let v;
  let fields = [];
  let viewIsEditable = false;
  let viewName;
  let entityName;
  let qresult = null;
  let aresult = null;

  onMount(async () => {
    p = pageDetails();
    viewName = p.viewName;
    v = viewDetail($views, viewName);
    viewIsEditable =
      !!v.to_view && isAllowedTo($permissions, viewName + "_edit"); // handle v.to_view being null (=undefined?) or '' (empty string)
    entityName = titleCase(viewName) || "";
    doListMembers();
    doGetActions();
  });

  async function doListMembers() {
    fields = JSON.parse(v.fields);
    if (fields === null) {
      fields = [];
    }
    fields.push({ fieldName: "id", visibility: false });
    console.log(fields);
    let sql = v.get_sql.replace("%d", p.id);
    qresult = await doFetch($dbN, sql);
  }

  async function doGetActions() {
    aresult = await doFetch(
      $dbN,
      "select * from py_actions where view_id=" + v.id
    ); // optimization..load all actions at login time
  }

  function downloadCSV(csv, filename) {
    let csvFile = new Blob([csv], { type: "text/csv" });
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
      let row = [];
      let cols = rows[i].querySelectorAll("td, th");

      for (
        let j = 1;
        j < cols.length;
        j++ // skip first col to avoid writing checkbox and edit button
      )
        row.push(cols[j].innerText);

      csv.push(row.join());
    }

    downloadCSV(csv.join("\n"), filename);
  }

  var sanitizeName = function (name) {
    // to make valid filename
    name = name.replace(/\s+/gi, "-"); // Replace white space with dash
    return name.replace(/[^a-zA-Z0-9\-]/gi, ""); // Strip any special charactere
  };

  function saveToCsv() {
    exportTableToCSV(sanitizeName(entityName) + ".csv");
  }

  async function doAction(action_name, action_type, script) {
    let ids = [];
    let names = [];
    let emails = [];
    let cboxes = Array.from(document.getElementsByClassName("checkrow"));
    cboxes.forEach((cbox, index) => {
      if (cbox.checked) {
        // console.log(qresult[index])
        ids.push(qresult[index]["ID"]);
        names.push(qresult[index]["NAME"]);
        if (action_type == "email") {
          emails.push({
            NAME: qresult[index]["NAME"],
            EMAIL: qresult[index]["EMAIL"],
          }); // or just push undefined if col does not exist?
        }
      }
    });
    // console.log('ids=', ids)
    // console.log("names=", names);

    if (ids.length == 0) {
      window.alert("Please select one or more rows");
    } else {
      if (action_type == "exec_sql") {
        let audit_text =
          viewName +
          ": " +
          action_name +
          ": " +
          '"' +
          names.join() +
          '"' +
          " by " +
          $permissions.u_name;
        await doFetch($dbN, script.replace("%d", ids.join()), audit_text);
        doListMembers();
      }
      if (action_type == "email") {
        // writeAuditText($dbN, $permissions.u_id, $permissions.u_name, 'Emailed ' + names.join());
        // might not need above as emailing logs
        $emailDetails = emails;
        $page = "email";
      }
    }
  }

  function editId(anID) {
    $page = gotoPage("memberEdit", v.to_view, anID); // edit a record doesn't need to pass FK
  }

  function addRow() {
    const fkObj = {};
    if (viewName.includes("$")) {
      const fkName = viewName.replace(/\$.*/, "_id");
      fkObj[fkName] = p.id;
    }
    $page = gotoPage("memberEdit", v.to_view, 0, fkObj); // 0 => add.  parent id is passed as well. todo: extract field name from view if contains $ eg 'member' from member$receipts and append '_id'
  }

  function doCheckAll() {
    let cboxes = Array.from(document.getElementsByClassName("checkrow"));
    cboxes.forEach(
      (cbox) => (cbox.checked = document.getElementById("idCheckAll").checked)
    );
  }

  function includeField(columnName) {
    let f = fields.find(
      (field) => field.fieldName === columnName.toLowerCase()
    );
    return f === undefined
      ? true
      : f.visibility === undefined
      ? true
      : f.visibility;
  }
</script>

<main>
  <h3>{entityName}</h3>

  {#if viewIsEditable}
    <button on:click={addRow}>+ Add</button>
  {/if}
  {#if qresult && qresult.length > 0}
    <table>
      <tr>
        <th
          ><input
            id="idCheckAll"
            type="checkbox"
            unchecked
            on:click={doCheckAll}
          /></th
        >
        {#each Object.keys(qresult[0]) as column}
          {#if includeField(column)}
            <th>{titleCase(column)}</th>
          {/if}
        {/each}
      </tr>

      {#each qresult as row}
        <tr>
          <td>
            <input class="checkrow" type="checkbox" unchecked />
            {#if viewIsEditable}
              <button class="editrow" on:click={editId(Object.values(row)[0])}
                >✎</button
              >
            {/if}
          </td>
          {#each Object.values(row) as cell, index}
            {#if includeField(Object.keys(qresult[0])[index])}
              <td class="cell" contenteditable="false" bind:innerHTML={cell} />
            {/if}
          {/each}
        </tr>
      {/each}
    </table>

    <br />
    <button id="saveToCsv" on:click={saveToCsv}>Save to CSV file</button>
    <!-- {#if isAllowedTo($permissions, "email")}
      <button on:click={doEmail}>Email...</button>
    {/if} -->
    {#if aresult}
      {#each aresult as row}
        {#if isAllowedTo($permissions, "action_" + row.NAME)}
          <button on:click={doAction(row.NAME, row.ACTION_TYPE, row.SCRIPT)}
            >{row.NAME}</button
          >
        {/if}
      {/each}
    {/if}
  {/if}
</main>

<style>
  tr:nth-child(even) {
    background: rgb(229, 233, 218);
  }
  tr:nth-child(odd) {
    background: #fff;
  }

  .cell {
    padding-left: 5px;
    padding-right: 5px;
  }
</style>
