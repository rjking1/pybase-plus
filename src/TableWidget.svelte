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
            <th contenteditable="false" bind:innerHTML={column} />
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
    color: #000;
  }

  tr:nth-child(odd) {
    background: rgb(250, 250, 250);
    color: #000;
  }

  table tr td {
    border-bottom: 1px solid #cecece;
  }
  table th {
    padding-left: 5px;
    padding-right: 5px;
    background: #5c4dff;
    color: rgb(255, 255, 255);
    text-align: center;
    font-weight: normal;
  }

  .cell {
    padding: 5px;
    text-align: center;
  }
</style>
