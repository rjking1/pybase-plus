<script>
  function doSearch() {
    // Declare variables
    // var input, filter, table, tr, td, i, txtValue;
    const input = document.getElementById("searchBox");
    const filter = input.value.toUpperCase();

    const table = document.getElementsByClassName("filterable");
    const rows = table[0].getElementsByTagName("tr"); // todo: first table ??!!

    // Loop through all table rows, and hide those who don't match the search query
    for (let i = 1; i < rows.length; i++) {
      // skip header row
      let row = rows[i];
      let keep = false;
      let cols = row.getElementsByTagName("td");
      for (let c = 1; c < cols.length; c++) {
        // skip first col with checkbox/pencil
        let col = cols[c];
        if (col) {
          let txtValue = col.textContent || col.innerText;
          keep |= txtValue.toUpperCase().indexOf(filter) > -1;
        }
      }
      if (keep) {
        row.style.display = "";
      } else {
        row.style.display = "none"; // visibility = "collapse" no better for alt colours
      }
    }
  }
</script>

&nbsp;&nbsp;&nbsp;Filter/Search&nbsp;<input
  id="searchBox"
  type="search"
  on:input={doSearch}
/>
