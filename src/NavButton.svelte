<script>
  export let name
  export let page
</script>

<style>
  button {
    --space: 0.5rem;
    background-color: white;
    border-radius: var(--space);
    height: 38px;
    margin-right: var(--space);
    padding: var(--space);
  }
  .active {
    background-color: yellow;
  }
</style>

<button class:active={page === name} on:click={() => (page = name)}>
  <slot />
</button>
