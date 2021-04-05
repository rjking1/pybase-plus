<script>

import { onMount } from "svelte";
import { doFetch, isAllowedTo, titleCase, viewDetail } from "./Common.js";
import { goBack, gotoPage, pageDetails } from "./pageStack.js";
import { dbN, page, permissions, views } from "./Stores.js";

  let p;
  let v;
  let fields = [];
  let viewIsDeletable = false;
  let cols;
  let result;
  let qresult;
  let viewName;
  let entityName;
  let qsubviews;

  onMount(async () => {
    p = pageDetails()
    console.log(p)
    viewName = p.viewName
    v = viewDetail($views, viewName)

    fields = JSON.parse(v.fields)
    if (fields === null) {
      fields = []
    }
    fields.push({"fieldName":"id","visibility":false})
    console.log(fields)

    if (p.id == 0) { 
      result = await doFetch(
        $dbN,
        "select myQuery.* from (select 1) as ignoreMe left join (select * from " + p.viewName + "s where false ) as myQuery on true"  // note must have passed member and not member_add
      );
      console.log("orig ", result[0]) // all values will be null
      //update with fk passed in which will become the parent record for the new child
      //result[0][p.fk.keys[0]] = p.fk.values[0]
      Object.assign(result[0], p.fk)
      console.log("updated ", result[0])
    } else {
      result = await doFetch(
        $dbN,
        v.get_sql.replace('%d', p.id)
        // "select * from " + p.viewName + "s where id = " + p.id  // todo: fix - not real purpose of viewname --- query using <get_sql> 
      );
    }
    qresult = result[0];
    console.log(qresult)
    entityName = qresult.NAME || qresult.name || titleCase(viewName)

    viewIsDeletable = isAllowedTo($permissions, viewName + "_delete")

    cols = []
    Object.keys(qresult).forEach(col => { if (includeField(col)) { cols.push(col) } } )
    console.log(cols)

    qsubviews = JSON.parse(v.subviews);
    console.log(qsubviews)
  });

  function doCancel() {
    $page = goBack();
  }

  async function doDelete() {
    if(window.confirm('Delete ' + viewName + '?')) {
      result = await doFetch( $dbN, "delete from " + p.viewName + "s where id=" + p.id );
      console.log(result)
      $page = goBack();
    }
  }

  async function doUpdate() {
    let sql = "replace into " + p.viewName + "s (id," + cols.join() + ") values ("
    let vals = []
    vals.push(p.id)
    let fields = Array.from( document.getElementsByClassName("field") )
    fields.forEach(field => {
      if(field.value.trim() == '') {
        vals.push( "NULL" )
      } else {
        vals.push( "'" + field.value + "'" )
      }
    });
    sql = sql + vals.join() + ')'

    console.log(sql)
    result = await doFetch( $dbN, sql );
    console.log(result)
    if('error' in result[0]){
      window.alert(result[0].error)
    }

    $page = goBack();
  }

  function subviewClick(link) {
    console.log(link)
    $page = gotoPage('members', link, p.id)
  }

  function includeField(columnName) {
    let f = fields.find(field => field.fieldName === columnName.toLowerCase());
    return (f === undefined) ? true : (f.visibility === undefined ? true : f.visibility)
  }

  function fieldType(columnName) {
    let f = fields.find(field => field.fieldName === columnName.toLowerCase());
    return (f === undefined) ? "text" : (f.type === undefined ? "text" : f.type)
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
          <td><input type="{fieldType(column)}" name="{column}" class="field" value={Object.values(qresult)[index]} /> </td>
        {/if}
      </tr>
    {/each}
    </table>
    {#if qsubviews}
    {#each Object.keys(qsubviews) as subview, index}
      <div class="link" on:click="{subviewClick(Object.values(qsubviews)[index])}">{titleCase(subview)}</div><br>
    {/each}
    {/if}
  {/if}
  <button disabled={!viewIsDeletable} on:click={doDelete}>❌ Delete</button>&nbsp;&nbsp;
  <button on:click={doCancel}>❎ Cancel</button>&nbsp;&nbsp;
  <button on:click={doUpdate}>✅ Update</button>
</main>

<style>
  .label { padding-right: 15px;}
  input { font-weight: bold; width: 300px; }
  .link { text-decoration-line: underline; color: rgb(48, 48, 192); cursor: pointer;}
</style>
