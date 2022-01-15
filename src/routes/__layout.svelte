<script>
	import NavBar from '$lib/components/NavBar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import Page from '$lib/components/Page.svelte';
	import '@fontsource/inter';
	import '@fontsource/fira-code';
	import '../styles/normalize.css';
	import '../styles/app.css';
	import '../styles/prism.css';
</script>

<svelte:head>
	<!-- Global site tag (gtag.js) - Google Analytics -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=G-SVLYV7EXZM"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag() {
			dataLayer.push(arguments);
		}
		gtag('js', new Date());

		gtag('config', 'G-SVLYV7EXZM');
	</script>
</svelte:head>

<NavBar />
<Page>
	<slot />
</Page>
<Footer />
