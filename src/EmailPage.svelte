<script>
  import { doFetch, writeAuditText } from "./common.js";
  import { onMount } from "svelte";
  import { dbN, permissions, emailDetails } from "./Stores.js";
  import Editor from "cl-editor/src/Editor.svelte";

  let editor;  // needed to call setHtml()
  let templateName = "Welcome email";

  let sender = "no-reply@ftgas.com.au";
  let subject = '';
  let html = "Choose a template";
    // '<html>\nHi !name\nPASTE HERE\n...<a href="www.artspace7.com.au/pybase/plus/hut/news/test.pdf">Newsletter.pdf</a>\n</html>';
  let attachments = ""; // "https://artspace7.com.au/pybase/hut/news/test.pdf";
  // let encrypted = "";  // should use this to avoid having artspace login details in here
  let atts = undefined;

  let result = null;

  let templates = [];

  onMount(async () => {
    result = $emailDetails;  // todo: tidy
    templates = await doFetch(
      $dbN,
      "select id, name from py_templates where class='email' order by name"
    );
  });

  async function doLoadtemplate() {
    let rows = await doFetch(
      $dbN,
      "SELECT contents FROM py_templates WHERE name = '" + templateName + "'"
    );
    html = rows[0]["contents"];
    editor.setHtml(html)
  }

  async function doSend() {
    if (attachments != "") {
      atts = [
        {
          name: "newsletter.pdf",
          path: attachments,
        },
      ];
    }
    result.forEach((row) => {
      let contents =
        "<html>" + html.replace("!name", row["NAME"]) + "</html>";

      if (row["EMAIL"]) {
        Email.send({
          Host: "mail.artspace7.com.au",
          Username: "art25285",
          Password: "ear724gni",
          To: row["EMAIL"],
          From: sender,
          Subject: subject,
          Body: contents,
          Attachments: atts,
        }).then((message) => {
          console.log(row["EMAIL"], message);
          writeAuditText(
            $dbN,
            $permissions.u_id,
            $permissions.u_name,
            "emailed " +
              row["EMAIL"] +
              " subject " +
              subject +
              " response " +
              message
          );
        });
        // todo: add delay
      }
    });
  }
</script>

<svelte:head>
  <script src="https://smtpjs.com/v3/smtp.js"></script>
</svelte:head>

<main>
  <p><b>Email</b></p>
  <table>
    <tr>
      <td>To:</td>
      <td min-width="300px">
        {#each $emailDetails as emailDetail}
          <span style="background-color: rgb(251, 213, 181);">{emailDetail.NAME}</span>
          <span style="background-color: rgb(251, 243, 199);">{emailDetail.EMAIL}</span>
          <span> &nbsp; </span>
        {/each}
      </td>
    </tr>
    <tr>
      <td>From:</td>
      <td><input bind:value={sender} required /> </td>
    </tr>
    <tr>
      <td>Subject: </td>
      <td><input bind:value={subject} required /> </td>
    </tr>
  </table>
  Template
  <select id="id_template" bind:value={templateName}>
    {#each templates as template}
      <option value={template.name}>{template.name}</option>
    {/each}
  </select>
  <button on:click={doLoadtemplate}>Load</button>
  <br />
  <Editor {html} bind:this={editor} on:change={(evt) => (html = evt.detail)} />
  <label>Attachment</label><input bind:value={attachments} />
  <br />
  <button type="submit" on:click={doSend}> Send Emails </button>
</main>

<style>
  input {
    width: 60%;
  }
  textarea {
    width: 60%;
    height: 20%;
  }
</style>
