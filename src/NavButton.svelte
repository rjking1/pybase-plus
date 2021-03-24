<script>
  import { loggedIn, page } from './Stores.js'

  export let name
  // export let page

  function doLoginCheck() {
    if($loggedIn == "false"){
      $page = "login"
    } else {
      $page = name
    }
  }

</script>

<style>
  button {
    --space: 0.5rem;
    background-color: white;
    border-radius: var(--space);
    height: 38px;
    margin-right: var(--space);
    padding: var(--space);
    display: none;
  }
  .active {
    background-color: yellow;
    display: inline;
  }
</style>

<button class:active={$page === name} on:click={doLoginCheck}>
  <slot />
</button>
