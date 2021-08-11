<script>
  import { doFetch, writeAuditText } from "./common.js";
  import { onMount } from "svelte";
  import { dbN, permissions, emailDetails } from "./Stores.js";

  import Editor from "cl-editor/src/Editor.svelte";
  import { BCC_EMAIL, INFO_EMAIL, MEMBERSHIP_EMAIL } from "./config.js";

  let editor; // needed to call setHtml()
  let templateName = "Welcome email";

  let sender = MEMBERSHIP_EMAIL;
  let replyTo = INFO_EMAIL; // todo make a drop down using list=id
  let subject = ""; // prevent email until filled in
  let bcc = BCC_EMAIL;
  let html = "Choose a template"; // todo: use placeholder and prevent email until loaded

  let result = null;
  let emailCount = 0;
  let sending = false;
  $: emailNumber = 0;

  let templates = [];
  let froms = [];
  let replyTos = [];

  onMount(async () => {
    result = $emailDetails; // todo: tidy
    emailCount = result.length;
    templates = await doFetch(
      $dbN,
      "select id, name from py_templates where class='email' order by name"
    );
    froms = await doFetch(
      $dbN,
      "select distinct value_ from py_logs where key_ = 'email.from' "
    );
    console.log(froms);
    replyTos = await doFetch(
      $dbN,
      "select distinct value_ from py_logs where key_ = 'email.replyTo' "
    );
    console.log(replyTos);
  });

  async function doLoadtemplate() {
    let rows = await doFetch(
      $dbN,
      "SELECT contents FROM py_templates WHERE name = '" + templateName + "'"
    );
    html = rows[0]["contents"];
    editor.setHtml(html);

    if (subject == "") {
      subject = templateName;
    }
  }

  // move this fn to utls
  async function sendEmail(from, to, replyTo, bcc, subject, message) {
    let formData = new FormData();
    formData.append("to", to);
    formData.append("from", from);
    formData.append("reply_to", replyTo);
    formData.append("bcc", bcc);
    formData.append("subject", subject);
    formData.append("message", message);

    return await fetch(`https://thehutgallery.com.au/dsql/emailer3.php`, {
      method: "POST",
      body: formData,
    });
  }

  async function doSendAll() {
    sending = true; // disable Email button
    writeAuditText(
      $dbN,
      $permissions.u_id,
      $permissions.u_name,
      "",
      "email.from",
      sender
    );
    writeAuditText(
      $dbN,
      $permissions.u_id,
      $permissions.u_name,
      "",
      "email.replyTo",
      replyTo
    );
    writeAuditText(
      $dbN,
      $permissions.u_id,
      $permissions.u_name,
      "",
      "email.subject",
      subject
    );
    for (let r = 0; r < result.length; r++) {
      await doSendEmail(result[r], r);
    }
  }

  async function doSendEmail(row, index) {
    const no = row["no"];
    const name = row["name"];
    const email = row["name"] + " <" + row["email"] + ">";
    if (email) {
      console.log("sending:" + email);
      const contents = html
        .replace("!number", no)
        .replace("!name", name)
        .replace("!index", index + 1);
      let resp = await sendEmail(
        sender,
        email,
        replyTo,
        bcc,
        subject,
        contents
      );
      console.log("sent to:" + email + " response: " + resp.statusText);
      writeAuditText(
        $dbN,
        $permissions.u_id,
        $permissions.u_name,
        "emailed: " + email + " subject: " + subject,
        "email.to",
        email
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
        <details open="true">
          <summary>{emailCount} recipients</summary>
          {#each $emailDetails as emailDetail}
            <span style="background-color: rgb(251, 213, 181);"
              >{emailDetail.name}</span
            >
            &nbsp
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
      <td>
        <select id="from" bind:value={sender}>
          {#each froms as from}
            <option value={from.value_}>{from.value_}</option>
          {/each}
        </select>
      </td>
    </tr>
    <tr>
      <td>Reply to:</td>
      <td>
        <select id="replyto" bind:value={replyTo}>
          {#each replyTos as replyto}
            <option value={replyto.value_}>{replyto.value_}</option>
          {/each}
        </select>
      </td>
    </tr>
    <tr>
      <td>Template:</td>
      <td>
        <select id="id_template" bind:value={templateName}>
          {#each templates as template}
            <option value={template.name}>{template.name}</option>
          {/each}
        </select>
        <button on:click={doLoadtemplate}>Load</button>
      </td>
    </tr>
    <tr>
      <td>Subject: </td>
      <td><input bind:value={subject} required /> </td>
    </tr>
  </table>
  <br />
  <Editor {html} bind:this={editor} on:change={(evt) => (html = evt.detail)} />
  <br />
  <button disabled={sending} on:click={doSendAll}> Send Emails </button>
  <br />
  Sent <span style="background-color: rgb(251, 213, 181);">{emailNumber}</span>
  of <span style="background-color: rgb(251, 243, 199);">{emailCount}</span>
  {#if emailCount > 0}
    <progress value={emailNumber / emailCount} />
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
