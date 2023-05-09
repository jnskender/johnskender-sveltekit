<script>
	import SEO from '$lib/components/SEO.svelte';

	export let title;
	export let seoTitle;
	export let seoImage;
	export let slug;
</script>

<article class="article">
	<SEO
		{title}
		description={seoTitle}
		openGraph={{
			title,
			type: 'article',
			image: seoImage,
			description: seoTitle
		}}
		slug={'articles/' + slug}
	/>
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

	@media (max-width: 600px) {
		h1 {
			font-size: var(--font-xl);
		}
	}
	@media (max-width: 400px) {
		h1 {
			font-size: var(--font-lg);
		}
	}
</style>
