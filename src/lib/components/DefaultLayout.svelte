<script>
	import SEO from '$lib/components/SEO.svelte';
	import website from '$lib/config/website';
</script>

<SEO title={website.siteTitle} description={website.siteDescription} />

<main>
	<slot />
</main>

<style>
	main {
		max-width: 65ch;
		margin: 0 auto;
	}
</style>
