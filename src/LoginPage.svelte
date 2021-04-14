<script>
  import { doFetch } from "./Common.js";
import { gotoPage } from "./pageStack.js";
  import { society, page, dbN, loggedIn, permissions, views } from "./Stores.js";

  // import { onMount } from "svelte";

  const db_base = "art25285_"
  let db = "hut";
  let username = "";
  let password = "";

  async function doLogin() {
    let qresult = await doFetch(
      db_base + db,
      "select u.id, u.user_name, def_capab, exceptions from py_roles r join py_users u on r.id=u.role_id where upper(u.user_name)='" +
        username.toUpperCase() +
        "' and u.password='" +
        password +
        "'"
    );

    if(qresult.length == 0) {
      alert("Invalid user name or password")
    } else {
      $permissions = { u_id: qresult[0]["id"], u_name: qresult[0]["user_name"], cap: qresult[0]["def_capab"], ex: qresult[0]["exceptions"] };
      $dbN = db_base + db;
      $loggedIn = "true";
      // $page = 'index'

      qresult = await doFetch($dbN, "select val from py_named_values where id like 'sys.society.%' order by id")
      $society = qresult[0]["val"] 
      $permissions["tables_prefix"] = qresult[1]["val"] 
      console.log($permissions);

      $views = await doFetch($dbN, "select id, name, to_view, get_sql, put_sql, fields, subviews from py_views") //  where name not like 'py_%'
      console.log($views)

      $page = gotoPage("index")
    }
  }
</script>

<main>
  <form on:submit|preventDefault={doLogin}>
    <label>Database</label>
    <input id="db" bind:value={db} />

    <label>User name</label>
    <input id="user" bind:value={username} autofocus />

    <label>Password</label>
    <input id="password" type="password" bind:value={password} />

    <button type="submit">Login</button>
  </form>
</main>

<style>
  input {
    width: 200px;
  }
</style>
