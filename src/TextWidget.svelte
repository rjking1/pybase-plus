<!-- <svelte:options accessors={true} /> -->
<script>
  // options above help wen debugging

  export let txt = "";
</script>

<textarea readonly>{txt}</textarea>

<style>
  textarea {
    width: 100%;
    height: 100%;
  }
</style>
