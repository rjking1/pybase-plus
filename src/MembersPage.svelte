<script>
  import { onMount } from "svelte";
  import Filter from "./Filter.svelte";
  import {
    doFetch,
    isAllowedTo,
    titleCase,
    viewDetail,
    writeAuditText,
  } from "../../common/dbutils";
  import { dbN, page, permissions, views, emailDetails } from "./Stores.js";
  import { gotoPage, pageDetails } from "./pageStack.js";
  import { clickHook } from "./sortable.js";
  import { roundedDateTimeToISO } from "./utilFuncs";

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
    const datetime = roundedDateTimeToISO();
    sql = sql.replaceAll(":datetime:", datetime); // maybe this should also quote the datetime string
    console.log(sql);

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
    cboxes.forEach((cbox) => {
      if (cbox.checked) {
        let index = cbox.getAttribute("data-index");
        console.log(qresult[index]);
        ids.push(qresult[index]["ID"]);
        names.push(qresult[index]["NAME"]);
        if (action_type == "email" && qresult[index]["EMAIL"]) {
          emails.push({
            no: qresult[index]["No"],
            name: qresult[index]["NAME"],
            email: qresult[index]["EMAIL"],
          }); // todo: or just push undefined if col does not exist?
        }
      }
    });
    console.log("ids=", ids);
    console.log("names=", names);
    console.log("emails=", emails);

    if (ids.length == 0) {
      window.alert("Please select one or more rows"); //  if no %id in script then don't need to check !
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
        console.log(script.replace("%d", ids.join()));
        await doFetch($dbN, script.replace("%d", ids.join()), audit_text); // todo: doco: unlike before use in (%d) rather than =%d
        doListMembers();
      }
      if (action_type == "email") {
        // writeAuditText($dbN, $permissions.u_id, $permissions.u_name, 'Emailed ' + names.join());
        // might not need above as emailing logs
        $emailDetails = emails;
        $page = gotoPage("email");
      }
      if (action_type == "open_url") {
        window.open(script, "_blank"); // script = url
      }
    }
  }

  function editId(anID) {
    if (v.to_view == "dashboard") {
      $page = gotoPage("dashboard", "dashboard", anID); // pass extra info in an object?
    } else {
      $page = gotoPage("memberEdit", v.to_view, anID); // edit a record doesn't need to pass FK
    }
  }

  function addRow() {
    const fkObj = {};
    if (viewName.includes("$")) {
      const fkName = viewName.replace(/\$.*/, "_id");
      fkObj[fkName] = p.id;
    }
    $page = gotoPage("memberEdit", v.to_view, 0, fkObj); // 0 => add.  parent id is passed as well. todo: extract field name from view if contains $ eg 'member' from member$receipts and append '_id'
  }

  function doCheckAll2() {
    let cboxes = Array.from(document.getElementsByClassName("checkrow"));
    cboxes.forEach((cbox) => {
      cbox.checked = document.getElementById("idCheckAll").checked;
    });
  }

  function doCheckAll() {
    const table = document.getElementsByClassName("filterable");
    const rows = table[0].getElementsByTagName("tr"); // todo: first table ??!!

    // Loop through all table rows, and check/uncheck only those that are visible
    for (let i = 1; i < rows.length; i++) {
      // skip header row
      let row = rows[i];
      if (row.style.display != "none") {
        let firstCell = row.getElementsByTagName("td")[0]; // get first cell on row
        firstCell.getElementsByClassName("checkrow")[0].checked =
          document.getElementById("idCheckAll").checked;
      }
    }
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

<!-- <svelte:head>
  <script src="./sortable.js"></script>
</svelte:head> -->

<main>
  <h3>{entityName}</h3>

  {#if viewIsEditable}
    <button on:click={addRow}>+ Add</button>
  {/if}
  {#if qresult && qresult.length > 0}
    <Filter />
    <table class="sortable filterable">
      <thead>
        <tr>
          <th class="sticky">
            <input
              id="idCheckAll"
              type="checkbox"
              unchecked
              on:click={doCheckAll}
            />
          </th>
          {#each Object.keys(qresult[0]) as column}
            {#if includeField(column)}
              <th class="sticky" on:click={clickHook}>{titleCase(column)}</th>
            {/if}
          {/each}
        </tr>
      </thead>
      <tbody>
        {#each qresult as row, index}
          <tr>
            <td>
              <input
                class="checkrow"
                type="checkbox"
                unchecked
                data-index={index}
              />
              {#if viewIsEditable}
                <button
                  class="editrow"
                  on:click={editId(Object.values(row)[0])}
                >
                  ✎
                </button>
              {/if}
            </td>
            {#each Object.values(row) as cell, index}
              {#if includeField(Object.keys(qresult[0])[index])}
                <td
                  class="cell"
                  contenteditable="false"
                  bind:innerHTML={cell}
                />
              {/if}
            {/each}
          </tr>
        {/each}
      </tbody>
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
            >{row.NAME}
          </button>
        {/if}
      {/each}
    {/if}
  {/if}
</main>

<style>
  tr:nth-child(even) {
    background-color: rgb(233, 235, 222);
  }

  tr:nth-child(odd) {
    background: rgb(250, 250, 250);
  }

  table tr td {
    border-bottom: 1px solid #cecece;
  }

  /* .cell {
    padding-left: 5px;
    padding-right: 5px;
  } */

  .sortable {
    border-spacing: 0;
    /* background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAyCAIAAAASmSbdAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH3wQbATAssXhCIwAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAAAYSURBVAjXY/j8/joTAwMDTfGXDzdpbQcATuQF2Ze0VigAAAAASUVORK5CYII=);
  border-collapse: collapse; */
  }

  /* .sortable tbody tr:nth-child(odd) {
  background: #e4e4e4;
}  */

  .sortable td,
  .sortable th {
    padding: 5px;
    /* white-space: nowrap; */
  }

  /* .sortable td:first-child,
.sortable th:first-child {
  border-top-left-radius: 4px;
}

.sortable td:last-child,
.sortable th:last-child {
  border-top-right-radius: 4px;
} */

  .sortable th {
    background: #5c4dff;
    color: rgb(255, 255, 255);
    cursor: pointer;
    font-weight: normal;
    text-align: left;
    text-transform: capitalize;
    vertical-align: baseline;
    /* white-space: nowrap; */
  }

  .sortable th:hover {
    color: rgb(255, 255, 0);
  }

  /* .sortable th:hover::after {
  color: inherit;
  font-size: 1.2em;
  content: ' \025B8';
}

.sortable th::after {
  font-size: 1.2em;
  color: transparent;
  content: ' \025B8';
} */

  /* .sortable th.dir-d {
  color: #000;
} */

  /* .sortable th.dir-d::after {
  color: inherit;
  content: ' \025BE';
} */

  /* .sortable th.dir-u {
  color: #000;
} */

  /* .sortable th.dir-u::after {
  color: inherit;
  content: ' \025B4';
} */

  .sticky {
    position: sticky;
    top: 0;
  }
</style>
