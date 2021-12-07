<script>
	import SEO from '$lib/components/SEO.svelte';

	export let title;
	export let seoTitle;
	export let isPublished;
	export let createdOn;
	export let updatedOn;

	export let article;
</script>

<article>
	<SEO {title} description={seoTitle} />
	<h1>{title}</h1>
	<slot />
</article>

<style>
	h1 {
		font-size: var(--font-xxl);
		line-height: 1;
		font-weight: 800;
		color: white;
		margin-bottom: var(--margin-m);
		text-align: center;
	}
</style>
