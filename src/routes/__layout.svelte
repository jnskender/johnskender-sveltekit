<script>
	import NavBar from '$lib/components/NavBar.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import Page from '$lib/components/Page.svelte';
	import '../styles/reset.css';
	import '../styles/app.css';
	import '../styles/prism.css';
</script>

<svelte:head>
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
	<link
		href="https://fonts.googleapis.com/css2?family=Fira+Code&family=Inter:wght@400;600;700;800&display=swap"
		rel="stylesheet"
	/>
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
