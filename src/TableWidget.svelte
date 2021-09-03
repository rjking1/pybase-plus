<script>
  export let qresult;

  const includeField = (col) => {
    return true;
  };
  const titleCase = (col) => {
    return col;
  };
</script>

{#if qresult && qresult.length > 0}
  <table>
    <thead>
      <tr>
        {#each Object.keys(qresult[0]) as column}
          {#if includeField(column)}
            <th>{titleCase(column)}</th>
          {/if}
        {/each}
      </tr>
    </thead>
    <tbody>
      {#each qresult as row, index}
        <tr>
          {#each Object.values(row) as cell, index}
            {#if includeField(Object.keys(qresult[0])[index])}
              <td class="cell" contenteditable="false" bind:innerHTML={cell} />
            {/if}
          {/each}
        </tr>
      {/each}
    </tbody>
  </table>
{/if}

<style>
  tr:nth-child(even) {
    background-color: rgb(233, 235, 222);
  }

  tr:nth-child(odd) {
    background: rgb(250, 250, 250);
  }

  table tr td {
    border-bottom: 1px solid #cecece;
  }

  /* .cell {
    padding-left: 5px;
    padding-right: 5px;
  } */
</style>
