<script>
	import SEO from '$lib/components/SEO.svelte';
	export let title;
	export let seoTitle;
	export let isPublished;
	export let createdOn;
	export let updatedOn;
</script>

<SEO {title} description={seoTitle} />
<section class="article-header">
	<h1>{title}</h1>
</section>
<main>
	<article>
		<slot />
	</article>
</main>

<style>
	.article-header {
		margin: var(--margin-xl);
	}
	h1 {
		text-align: center;
		font-size: var(--font-xl);
	}
	article {
		max-width: 65ch;
		margin: 0 auto;
	}
</style>
