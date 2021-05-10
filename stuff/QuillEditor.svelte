<script>
	import { quill } from "svelte-quill";

	export let value;
	
	let options = { placeholder: "Write something from outside..." };
</script>

<svelte:head>
	<link href="//cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet" />
</svelte:head>

<div
	class="editor"
	use:quill={options}
	on:text-change={(e) => (value = e.detail.html)}
/>

<style>
	.editor { height: 300px; }
</style>
