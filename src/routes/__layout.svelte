<script>
	import NavBar from '$lib/components/NavBar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import Page from '$lib/components/Page.svelte';
	import '../styles/prism.css';
	import '../styles/reset.css';
	import '../styles/app.css';
</script>

<NavBar />
<Page>
	<slot />
</Page>
<Footer />
