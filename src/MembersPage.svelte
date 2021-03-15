<script>
  import { doFetch } from './Common.js'
  import { dbN } from './Stores.js'

  let sql = "select * from members"
  let qresult = null

  async function doQuery() {
    qresult = await doFetch($dbN, sql)
  }
</script>

<style>
  input { width: 90%}
  li {
    list-style: none;
  }
</style>

<label>SQL</label>
<input bind:value={sql} />

<button type="button" on:click={doQuery}>Query</button>

<label>Result:</label>
<pre>
  {#if qresult}
    Rides
    <ul>
      {#each qresult as row}
        <li>
          {#each Object.values(row) as field}{field + ' '}{/each}
        </li>
      {/each}
    </ul>
  {/if}
</pre>
