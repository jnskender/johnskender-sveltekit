<script>
	import SEO from '$lib/components/SEO.svelte';
	import config from '$lib/config/website';
</script>

<SEO title={config.website.siteTitle} description={config.website.siteDescription} />

<main>
	<slot />
</main>

<style>
	main {
		max-width: 65ch;
		margin: 0 auto;
	}
</style>
