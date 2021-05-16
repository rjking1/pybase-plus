<script>
  import { onMount } from "svelte";
  import { doFetch, isAllowedTo, titleCase, viewDetail } from "./Common.js";
  import { goBack, gotoPage, pageDetails } from "./pageStack.js";
  import { dbN, page, permissions, views } from "./Stores.js";
  // https://github.com/fuzzthink/cl-editor
  import Editor from "cl-editor/src/Editor.svelte";

  let html;
  // let editor;

  let p;
  let v;
  let fields = []; // special cases of visibiity, type etc
  let viewIsDeletable = false;
  let cols; // all columns from the view that are going to be displayed
  let result;
  let qresult;
  let viewName;
  let entityName;
  let qsubviews;
  let fkeys; // eg member_id: qresult (id and name columns)

  onMount(async () => {
    p = pageDetails();
    console.log(p);
    viewName = p.viewName;
    v = viewDetail($views, viewName);

    fields = JSON.parse(v.fields);
    if (fields === null) {
      fields = [];
    }
    fields.push({ fieldName: "id", visibility: false });
    // console.log(fields)

    if (p.id == 0) {
      result = await doFetch(
        $dbN,
        "select myQuery.* from (select 1) as ignoreMe left join (select * from " +
          p.viewName +
          "s where false ) as myQuery on true" // note must have passed member and not member_add
      );
      // console.log("orig ", result[0]) // all values will be null
      //update with fk passed in which will become the parent record for the new child
      //result[0][p.fk.keys[0]] = p.fk.values[0]
      Object.assign(result[0], p.fk);
      // console.log("updated ", result[0])
    } else {
      result = await doFetch($dbN, v.get_sql.replace("%d", p.id));
    }
    qresult = result[0];
    // console.log(qresult)

    // console.log("audit_template=", v.audit_template)
    // console.log("audit_template value=", qresult[v.audit_template])
    entityName =
      qresult[v.audit_template] ||
      qresult.NAME ||
      qresult.name ||
      titleCase(viewName);

    viewIsDeletable = isAllowedTo($permissions, viewName + "_delete");

    // cols is all columns in view
    cols = [];
    Object.keys(qresult).forEach((col) => {
      if (includeField(col)) {
        cols.push(col);
      }
    });
    // console.log(cols)

    fkeys = {};
    Object.keys(qresult).forEach(async (col) => {
      if (fieldType(col) === "lookup") {
        fkeys[col] = await doFetch($dbN, lookupFieldSql(col));
      }
      if (fieldType(col) === "richtext") {
        html = qresult[col];
      }
    });
    // console.log(fkeys);

    qsubviews = JSON.parse(v.subviews);
    // console.log(qsubviews)
  });

  function doCancel() {
    $page = goBack();
  }

  async function doDelete() {
    if (window.confirm("Delete " + entityName + " from " + viewName + "s?")) {
      let audit_text =
        p.viewName + ' "' + entityName + '" deleted by ' + $permissions.u_name;
      result = await doFetch(
        $dbN,
        "delete from " + p.viewName + "s where id=" + p.id,
        audit_text
      );
      console.log(result);
      $page = goBack();
    }
  }

  async function doUpdate() {
    // // build dictionary of colName: value, ...
    // let labels = Array.from( document.getElementsByClassName("label") )
    // let fields = Array.from( document.getElementsByClassName("field") )
    // let dict = fields.reduce(function(dict, field, index) {
    //   dict[labels[index].value] = field.value;
    //   return dict;
    // }, {})
    // console.log("dict=", dict)

    let sql =
      (p.id == 0 ? "insert" : "replace") +
      " into " +
      p.viewName +
      "s (id," +
      cols.join() +
      ") values (";
    let vals = [p.id];
    let fields = Array.from(document.querySelectorAll(".field, .cl"));
    fields.forEach((field) => {
      if (field.classList.contains("cl")) {
        vals.push("'" + html.replaceAll("'", "''") + "'");
      } else if (field.value.trim() == "") {
        vals.push("NULL");
      } else {
        vals.push("'" + field.value.replaceAll("'", "''") + "'");
      }
    });
    sql = sql + vals.join() + ")";
    console.log(sql);

    // need to get entityName for Add case (but may  have changed in an update case as well)
    const entityCol = v.audit_template || "name" || "NAME" || "ID";
    cols.forEach((col, index) => {
      if (col.toLowerCase() == entityCol) {
        console.log(fields, index, fields[index], fields[index].value);
        entityName = fields[index].value;
      }
    });
    let audit_text =
      p.viewName +
      ' "' +
      entityName +
      '" ' +
      (p.id == 0 ? "added" : "updated") +
      " by " +
      $permissions.u_name;
    console.log(audit_text);

    result = await doFetch($dbN, sql, audit_text);
    console.log(result);

    if ("error" in result[0]) {
      window.alert(result[0].error);
    }

    $page = goBack();
  }

  function subviewClick(link) {
    console.log(link);
    $page = gotoPage("members", link, p.id);
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

  function fieldType(columnName) {
    let f = fields.find(
      (field) => field.fieldName === columnName.toLowerCase()
    );
    return f === undefined ? "text" : f.type === undefined ? "text" : f.type;
  }

  function lookupFieldSql(columnName) {
    let f = fields.find(
      (field) => field.fieldName === columnName.toLowerCase()
    );
    return f.sql;
  }
</script>

<main>
  <h3>{entityName}</h3>
  {#if qresult}
    <table>
      {#each Object.keys(qresult) as column, index}
        <tr>
          {#if includeField(column)}
            <td class="label">{titleCase(column)}</td>
            <td>
              {#if fieldType(column) === "richtext"}
                <!-- class = cl -->
                <Editor {html} on:change={(evt) => (html = evt.detail)} />
              {:else if fieldType(column) === "textarea"}
                <!-- keep next line on one line -->
                <textarea name={column} class="field">{Object.values(qresult)[index]}</textarea>
              {:else if fieldType(column) !== "lookup"}
                <input
                  type={fieldType(column)}
                  name={column}
                  class="field"
                  value={Object.values(qresult)[index]}
                />
              {:else}
                <select class="field" value={Object.values(qresult)[index]}>
                  {#if column in fkeys}
                    {#each fkeys[column] as fkey}
                      <option value={fkey.id}>{fkey.name}</option>
                    {/each}
                  {/if}
                </select>
              {/if}
            </td>
          {/if}
        </tr>
      {/each}
    </table>
    {#if qsubviews}
      {#if p.id != 0}
        {#each Object.keys(qsubviews) as subview, index}
          <div
            class="link"
            on:click={subviewClick(Object.values(qsubviews)[index])}
          >
            {titleCase(subview)}
          </div>
          <br />
        {/each}
      {/if}
    {/if}
  {/if}
  <button disabled={!viewIsDeletable} on:click={doDelete}>❌ Delete</button
  >&nbsp;&nbsp;
  <button on:click={doCancel}>❎ Cancel</button>&nbsp;&nbsp;
  <button on:click={doUpdate}>✅ Update</button>
</main>

<style>
  .label {
    padding-right: 15px;
  }
  input {
    font-weight: bold;
    width: 300px;
  }
  textarea {
    height: 100px;
    width: 300px;
  }
  .link {
    text-decoration-line: underline;
    color: rgb(48, 48, 192);
    cursor: pointer;
  }
</style>
