<script>
  import { doFetch } from "./Common.js";
  import { society, page, dbN, loggedIn, permissions, views } from "./Stores.js";

  // import { onMount } from "svelte";

  let db = "art25285_hut";
  let username = "";
  let password = "";

  async function doLogin() {
    let qresult = await doFetch(
      db,
      "select u.id, u.user_name, def_capab, exceptions from py_roles r join py_users u on r.id=u.role_id where upper(u.user_name)='" +
        username.toUpperCase() +
        "' and u.password='" +
        password +
        "'"
    );

    if(qresult.length == 0) {
      alert("invalid user name or password")
    } else {
      $permissions = { u_id: qresult[0]["id"], u_name: qresult[0]["user_name"], cap: qresult[0]["def_capab"], ex: qresult[0]["exceptions"] };
      $dbN = db;
      $loggedIn = "true";
      $page = 'index'

      qresult = await doFetch(db, "select val from named_values where id like 'sys.society.%' order by id")
      $society = qresult[0]["val"] 
      $permissions["tables_prefix"] = qresult[1]["val"] 
      // console.log($permissions);

      $views = await doFetch(db, "select * from py_views where NAME not like 'py_%'")
      console.log($views)
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
