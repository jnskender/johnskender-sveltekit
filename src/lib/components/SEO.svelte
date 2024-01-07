<script>
	import config from '$lib/config/website';

	export let title;
	export let description;
	export let slug;
	export let openGraph;

	const { siteLanguage, siteTitle, url } = config.website;
</script>

<svelte:head>
	{#if title}
		<title>{title} | {siteTitle}</title>
	{:else}
		<title>{siteTitle}</title>
	{/if}

	{#if description}
		<meta name="description" content={description} />
	{/if}

	{#if openGraph}
		<meta property="og:title" content={openGraph.title} />

		<meta property="og:description" content={openGraph.description} />

		<meta property="og:type" content={openGraph.type || 'website'} />

		<meta property="og:url" content={url + '/' + slug} />
		<meta property="og:image" content={url + '/' + openGraph.image} />
	{/if}

	<meta
		name="robots"
		content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1"
	/>
</svelte:head>
