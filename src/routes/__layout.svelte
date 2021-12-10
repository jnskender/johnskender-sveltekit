<script>
	import NavBar from '$lib/components/NavBar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import Page from '$lib/components/Page.svelte';
	import '../styles/prism.css';
	import '../styles/reset.css';
	import '../styles/app.css';
</script>

<svelte:head>
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link
		href="https://fonts.googleapis.com/css2?family=Fira+Code&family=Inter:wght@400;600;700;800&display=swap"
		rel="stylesheet"
	/>
</svelte:head>

<NavBar />
<Page>
	<slot />
</Page>
<Footer />
