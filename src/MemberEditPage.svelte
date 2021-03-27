<script>

import { onMount } from "svelte";
import { doFetch, titleCase } from "./Common.js";
import { goBack, pageDetails } from "./pageStack.js";
import { dbN, page } from "./Stores.js";

  let result;
  let qresult;
  let viewName;
  let p;
  let cols;

  onMount(async () => {
    p = pageDetails()
    if (p.id == 0) { 
      result = await doFetch(
        $dbN,
        "select myQuery.* from (select 1) as ignoreMe left join (select * from " + p.viewName + "s where false ) as myQuery on true"  // todo: fix ...
      );
    } else {
      result = await doFetch(
        $dbN,
        "select * from " + p.viewName + "s where id = " + p.id  // todo: fix - not real purpose of viewname --- query using <get_sql> 
      );
    }
    qresult = result[0];
    viewName = qresult.NAME || ''

    cols = Object.keys(qresult)
    // console.log(cols)
  });

  function doCancel() {
    $page = goBack();
  }

  async function doDelete() {
    await doFetch( $dbN, "delete from " + p.viewName + "s where id=" + p.id );
    $page = goBack();
  }

  async function doUpdate() {
    let sql = "replace into " + p.viewName + "s (" + cols.join() + ") values ("
    let vals = []
    let fields = Array.from( document.getElementsByClassName("field") )
    fields.forEach(field => {
      vals.push( "'" + field.value + "'" )
    });
    sql = sql + vals.join() + ')'

    // console.log(sql)
    await doFetch( $dbN, sql );

    $page = goBack();
  }
</script>

<main>
  <h3>{viewName}</h3>
  {#if qresult}
    {#each Object.keys(qresult) as column, index}
      <tr>
        <td class="label">{titleCase(column)}</td>
        <td><input type="text" name="{column}" class="field" value={Object.values(qresult)[index]} /> </td>
      </tr>
    {/each}
  {/if}
  <button on:click={doCancel}>Cancel</button>
  <button on:click={doDelete}>Delete</button>
  <button on:click={doUpdate}>Update</button>
</main>

<style>
  .label { padding-right: 15px;}
  input { font-weight: bold; width: 300px; }
</style>
