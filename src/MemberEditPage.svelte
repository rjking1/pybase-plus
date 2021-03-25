<script>
  import { onMount } from "svelte";
import { object_without_properties } from "svelte/internal";

  import { doFetch } from './Common.js'
  import { dbN } from './Stores.js'

  export let id
  let qresult = null
  let items

  onMount(async () => {
    qresult = await doFetch(
      $dbN,
      "select * from members limit 1" //where id = " + id
    );
    console.log(qresult[0])
    items = []
    let keys = Object.keys(qresult[0])
    let vals = Object.values(qresult[0])
    for(let i = 0; i < keys.length; i++) {
      let k = keys[i]
      let v = vals[i]
      let o = {}
      o[k]= v 
      items.push(o)
    }
    console.log(items)
  });

  function requery() {
  }

</script>

<main>
  <button on:click={requery}>Requery</button>
  {#if qresult}
    {#each Object.keys(qresult[0]) as column, index}
      <tr>
        <td>{column}</td> 
        <td><input type="text" value={Object.values(qresult[0])[index]} /> </td> 
      </tr>
    {/each}
  {/if}
</main>

<style>
  input { width: 200px}
</style>
