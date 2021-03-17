<script>
  import { doFetch } from "./Common.js";
  import { page, dbN, loggedIn, permissions } from "./Stores.js";

  import { onMount } from "svelte";

  let db = "art25285_hut";
  let username = "";
  let password = "";

  async function doLogin() {
    let qresult = await doFetch(
      db,
      "select u.user_name,def_capab,exceptions from py_roles r join py_users u on r.id=u.role_id where upper(u.user_name)='" +
        username.toUpperCase() +
        "' and u.password='" +
        password +
        "'"
    );

    if(qresult.length == 0) {
      alert("invalid user name or password")
    } else {
      $permissions = { c: qresult[0]["def_capab"], e: qresult[0]["exceptions"] };
      console.log($permissions);
      $dbN = db;
      $loggedIn = "true";
      $page = 'members'
    }
  }
</script>

<main>
  <label>Database</label>
  <input bind:value={db} />

  <label>User name</label>
  <input bind:value={username} />

  <label>Password</label>
  <input type="password" bind:value={password} />

  <button type="button" on:click={doLogin}>Login</button>
</main>

<style>
  input {
    width: 200px;
  }
</style>
