<script>
	import ArticleCard from '$lib/components/ArticleCard.svelte';
	export let articles;
	console.log(articles);
</script>

{#if articles}
	<section class="articles">
		{#each articles as article}
			<ArticleCard {article} />
		{/each}
	</section>
{:else}
	<section>
		<p>Oops! Couldn't load articles right now.</p>
	</section>
{/if}

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
