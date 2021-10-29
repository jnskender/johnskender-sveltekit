<script>
	import ArticleCard from '$lib/components/ArticleCard.svelte';
	export let articles;
</script>

<section class="articles">
	{#each articles as article}
		<ArticleCard {article} />
	{/each}
</section>

<style>
	.articles {
		display: grid;
		grid-template-columns: 1fr;
		gap: 32px;
	}

	@media (min-width: 1000px) {
		.articles {
			grid-template-columns: repeat(auto-fill, 1fr);
		}
	}
</style>
