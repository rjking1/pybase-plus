<script>

import { onMount } from "svelte";
import { doFetch, isAllowedTo, titleCase, viewDetail } from "./Common.js";
import { goBack, pageDetails } from "./pageStack.js";
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

  onMount(async () => {
    p = pageDetails()
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
    } else {
      result = await doFetch(
        $dbN,
        v.get_sql.replace('%d', p.id)
        // "select * from " + p.viewName + "s where id = " + p.id  // todo: fix - not real purpose of viewname --- query using <get_sql> 
      );
    }
    qresult = result[0];
    entityName = qresult.NAME || qresult.name || ''

    viewIsDeletable = isAllowedTo($permissions, viewName + "_delete")

    cols = []
    Object.keys(qresult).forEach(col => { if (includeField(col)) { cols.push(col) } } )
    console.log(cols)
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
    {#each Object.keys(qresult) as column, index}
      <tr>
        {#if includeField(column)} 
          <td class="label">{titleCase(column)}</td>
          <td><input type="{fieldType(column)}" name="{column}" class="field" value={Object.values(qresult)[index]} /> </td>
        {/if}
      </tr>
    {/each}
  {/if}
  <button disabled={!viewIsDeletable} on:click={doDelete}>❌ Delete</button>&nbsp;&nbsp;
  <button on:click={doCancel}>❎ Cancel</button>&nbsp;&nbsp;
  <button on:click={doUpdate}>✅ Update</button>
</main>

<style>
  .label { padding-right: 15px;}
  input { font-weight: bold; width: 300px; }
</style>
