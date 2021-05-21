<script>
  import { doFetch, writeAuditText } from "./common.js";
  import { onMount } from "svelte";
  // import { tweened } from "svelte/motion";
  // import { cubicOut } from "svelte/easing";
  import { dbN, permissions, emailDetails } from "./Stores.js";
  // import { gotoPage } from "./pageStack.js";

  import Editor from "cl-editor/src/Editor.svelte";

  let editor; // needed to call setHtml()
  let templateName = "Welcome email";

  let sender = "shirley.dougan@bigpond.com"; // "no-reply@ftgas.com.au"; // todo: nothing but keep in local storage; prevent emailing if empty
  let subject = ""; // prevent email until filled in
  let bcc = "heather@artspace7.com.au";
  let html = "Choose a template"; // todo: use placeholder and prevent email until loaded
  // let attachments = ""; // "https://artspace7.com.au/pybase/hut/news/test.pdf";
  // let atts = undefined;

  let result = null;
  let emailCount = 0;
  let sending = false;
  $: emailNumber = 0;

  let templates = [];

  onMount(async () => {
    result = $emailDetails; // todo: tidy
    emailCount = result.length;
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
    editor.setHtml(html);
  }

  // move this fn to utls
  async function sendEmail(from, to, bcc, subject, message) {
    let formData = new FormData();
    formData.append("from", from);
    formData.append("to", to);
    formData.append("bcc", bcc);
    formData.append("subject", subject);
    formData.append("message", message);
    // formData.append('attachments', func)

    return await fetch(`https://www.artspace7.com.au/dsql/emailer.php`, {
      method: "POST",
      body: formData,
    });
  }

  async function doSendAll() {
    sending = true; // disable Email button
    // if (attachments != "") {
    //   atts = [
    //     {
    //       name: attachments, // todo:fix
    //       path: attachments,
    //     },
    //   ];
    // }
    for (let r = 0; r < result.length; r++) {
      await doSendEmail(result[r], r);
    }
  }

  async function doSendEmail(row, index) {
    const no = row["no"];
    const name = row["name"];
    const email = row["email"];
    if (email) {
      console.log("sending:" + email);
      const contents =
        "<html>" +
        html
        .replace("!number", no)
        .replace("!name", name)
        .replace("!index", index + 1) +
        "</html>";
      let resp = await sendEmail(sender, email, bcc, subject, contents);
      console.log("sent to:" + email + " response: " + resp.statusText);
      writeAuditText(
        $dbN,
        $permissions.u_id,
        $permissions.u_name,
        "emailed " + email + " subject " + subject + " response " + resp.statusText
      );
      emailNumber = index + 1;
    }
  }

</script>

<main>
  <table>
    <tr>
      <td>To:</td>
      <td>
        <details>
          <summary>{emailCount} recipients</summary>
          {#each $emailDetails as emailDetail}
            <span style="background-color: rgb(251, 213, 181);"
              >{emailDetail.name}</span
            >
            <span style="background-color: rgb(251, 243, 199);"
              >{emailDetail.email}</span
            >
            <span> &nbsp; </span>
          {/each}
        </details>
      </td>
    </tr>
    <tr>
      <td>Bcc:</td>
      <td><input bind:value={bcc} /> </td>
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
  <!-- Attachment: <input bind:value={attachments} /> -->
  <br />
  <button disabled={sending} on:click={doSendAll}> Send Emails </button>
  <br />
  Sent <span style="background-color: rgb(251, 213, 181);">{emailNumber}</span>
  of <span style="background-color: rgb(251, 243, 199);">{emailCount}</span>
  {#if emailCount > 0}
  <progress value={emailNumber/emailCount} />
  {/if}
</main>

<style>
  input {
    width: 400px;
  }
  progress {
    display: block;
    width: 100%;
  }
</style>
