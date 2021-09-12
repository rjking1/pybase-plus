<script>
  export let caption;
  export let fn;
</script>

<button on:click={fn}>{caption}</button>

<style>
  button {
    color: white;
    background-color: #839fe6;
    width: 200px;
  }
</style>
