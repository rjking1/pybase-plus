<script>
  import { dbName, society, page, permissions } from './Stores.js'

  import NavButton from './NavButton.svelte'
  import LoginPage from './LoginPage.svelte'
  import IndexPage from './IndexPage.svelte'
  import MembersPage from './MembersPage.svelte'
  import MemberEditPage from './MemberEditPage.svelte'
  import EmailPage from './EmailPage.svelte'
  import QueryPage from './QueryPage.svelte'

  const pageMap = {
    login: LoginPage,
    index: IndexPage,
    members: MembersPage,
    memberEdit: MemberEditPage,
    email: EmailPage,
    query: QueryPage,
  }

</script>

<!-- =============== HTML =============== -->

<nav class=xsticky>
  <h1>
    <span style="text-align:left;">
      {$society}
    </span>
    <span style="float:right; font-size: medium;">
      {#if $permissions.u_name}
      DB: {$dbName}<br>{$permissions.u_name} 
      {/if}
    </span>
</h1>
  <NavButton  name="login">Sign in</NavButton>
  <NavButton  name="index">Home</NavButton>
  <NavButton  name="back">Back</NavButton>
  <!-- <NavButton  name="members">Members</NavButton>
  <NavButton  name="memberEdit">Member Edit</NavButton> --> 
  {#if $permissions.cap === 'D'}
  <NavButton  name="email">Email</NavButton> 
  <NavButton  name="query">Database</NavButton>
  {/if}
</nav>

<main>
  <!-- {#if $page == 'memberEdit' }
    <svelte:component this={ pageMap[$page] } /> 
  {:else}  -->
    <svelte:component this={ pageMap[$page] } /> 
  <!-- {/if} -->
</main>

<style>
  main {
    padding: 10px;
  }

  nav {
    /* display: flex; */
    align-items: center;
    background-color: cornflowerblue;
    padding: 10px;
  }

  .sticky {
  position: sticky;
  top: 0;
  /* width: 100%; */
  }

  h1 {color:aliceblue; padding-right: 10px;}

  h4 {text-align: right; font-size: 70%;}
</style>

