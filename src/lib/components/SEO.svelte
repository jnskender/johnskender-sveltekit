<script>
	import website from '$lib/config/website';

	const { siteLanguage, siteTitle } = website;
	export let title;
	export let description;
</script>

<svelte:head>
	<title>{title} | {siteTitle}</title>

	<meta name="description" content={description} />

	<meta
		name="robots"
		content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1"
	/>

	<html lang={siteLanguage} />
</svelte:head>
