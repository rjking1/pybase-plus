<script>
  import { doFetch } from './Common.js'
  import { dbN, loggedIn } from './Stores.js'

  import { onMount } from 'svelte'

  let db = "art25285_hut"
  let username= "RICHARD"
  let password = ""

  function doLogin() {
    $dbN = db
    $loggedIn= "true"
  }
</script>

<style>
  input {
    width: 200px;
  }
</style>

<main>
  <label>Database</label>
  <input bind:value={db} />

  <label>User name</label>
  <input bind:value={username} />

  <label>Password</label>
  <input bind:value={password} />

  <button type="button" on:click={doLogin}>Login</button>
</main>