<script>
  import { society, page } from './Stores.js'

  import NavButton from './NavButton.svelte'

  import LoginPage from './LoginPage.svelte'
  import IndexPage from './IndexPage.svelte'
  import MembersPage from './MembersPage.svelte'
  import MemberEditPage from './MemberEditPage.svelte'
  import EmailPage from './EmailPage.svelte'

  const pageMap = {
    login: LoginPage,
    index: IndexPage,
    members: MembersPage,
    memberEdit: MemberEditPage,
    email: EmailPage,
  }

</script>

<!-- =============== HTML =============== -->

<nav>
  <h1>{$society}</h1>
  <NavButton  name="login">Login</NavButton>
  <NavButton  name="index">Home</NavButton>
  <NavButton  name="members">Members</NavButton>
  <NavButton  name="memberEdit">Member Edit</NavButton>
  <NavButton  name="email">Email</NavButton>
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
    display: flex;
    align-items: center;
    background-color: cornflowerblue;
    padding: 10px;
  }

  h1 {color:aliceblue; padding-right: 10px;}
</style>

