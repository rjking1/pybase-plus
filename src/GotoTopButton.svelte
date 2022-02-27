<script>
  function gotoTop() {
    document.body.scrollTop = 0; // For Safari
    document.documentElement.scrollTop = 0; // For Chrome, Firefox, IE and Opera
  }
</script>

<button id="gotoTopButton" on:click={gotoTop}>Top</button>

<style>
  #gotoTopButton {
    display: block; /* Hidden by default */
    position: fixed; /* Fixed/sticky position */
    bottom: 20px; /* Place the button at the bottom of the page */
    right: 30px; /* Place the button 30px from the right */
    z-index: 99; /* Make sure it does not overlap */
    background-color: transparent; /* Set a background color */
    color: blue; /* Text color */
    cursor: pointer; /* Add a mouse pointer on hover */
    padding: 15px; /* Some padding */
    border-radius: 10px; /* Rounded corners */
    font-size: 15px; /* Increase font size */
  }

  #gotoTopButton:hover {
    background-color: yellow; /* Add a dark-grey background on hover */
  }
</style>
