<script>
  import { loggedIn, page } from './Stores.js'

  import NavButton from './NavButton.svelte'

  import LoginPage from './LoginPage.svelte'
  import MembersPage from './MembersPage.svelte'
  import EmailPage from './EmailPage.svelte'

  const pageMap = {
    login: LoginPage,
    members: MembersPage,
    email: EmailPage,
  }

// let page = 'login'

</script>

<!-- =============== HTML =============== -->

<h1>Pybase</h1>

<nav>
  <NavButton  name="login">Login</NavButton>
  <NavButton  name="members">Members</NavButton>
  <NavButton  name="email">Email</NavButton>
</nav>

<main>
  <svelte:component this={ pageMap[$page] } />
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
</style>

