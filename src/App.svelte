<script>
  import { dbName, society, page, permissions } from "./Stores.js";

  import NavButton from "./NavButton.svelte";
  import LoginPage from "./LoginPage.svelte";
  import IndexPage from "./IndexPage.svelte";
  import MembersPage from "./MembersPage.svelte";
  import MemberEditPage from "./MemberEditPage.svelte";
  import EmailPage from "./EmailPage.svelte";
  import QueryPage from "./QueryPage.svelte";
  import CalendarPage from "./CalendarPage.svelte";
  import ChartPage from "./ChartPage.svelte";
  import DashboardPage from "./DashboardPage.svelte";

  const pageMap = {
    login: LoginPage,
    index: IndexPage,
    members: MembersPage,
    memberEdit: MemberEditPage,
    calendar: CalendarPage,
    chart: ChartPage,
    email: EmailPage,
    query: QueryPage,
    dashboard: DashboardPage,
  };

  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.has("db")) {
    $dbName = urlParams.get("db");
  }

  // window.addEventListener("beforeunload", function (e) {
  //   if (window.confirm("Exit pybase?")) {
  //     // the absence of a returnValue property on the event will guarantee the browser unload happens
  //     delete e["returnValue"];
  //   } else {
  //     e.returnValue = "?";
  //   }
  // });
</script>

<svelte:head>
  <script
    src="https://cdn.plot.ly/plotly-latest.min.js"
    type="text/javascript"></script>
</svelte:head>

<!-- =============== HTML =============== -->

<h1>
  <span style="text-align:left;">
    {$society}
  </span>
  <span style="font-size: medium;">
    <NavButton name="login">Sign in</NavButton>
    <NavButton name="index">Home</NavButton>
    <NavButton name="back">Back</NavButton>
    <!-- <NavButton  name="members">Members</NavButton>
    <NavButton  name="memberEdit">Member Edit</NavButton> 
    <NavButton  name="calendar">Calendar</NavButton> 
    <NavButton  name="email">Email</NavButton> -->
    {#if $permissions.cap === "D"}
      <NavButton name="query">Database</NavButton>
      <!-- <NavButton name="dashboard">Dashboard</NavButton> -->
    {/if}
  </span>
  <span style="float:right; font-size: medium;">
    {#if $permissions.u_name}
      DB: {$dbName}<br />{$permissions.u_name}
    {/if}
  </span>
</h1>

<main>
  <!-- {#if $page == 'memberEdit' }
    <svelte:component this={ pageMap[$page] } /> 
  {:else}  -->
  <svelte:component this={pageMap[$page]} />
  <!-- {/if} -->
</main>

<style>
  main {
    padding: 5px;
  }

  h1 {
    color: aliceblue;
    padding-right: 10px;
    background-color: cornflowerblue;
    margin: 5px;
  }
</style>
