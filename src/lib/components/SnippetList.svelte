<script>
	import ArticleCard from '$lib/components/ArticleCard.svelte';
	export let snippets;
</script>

{#if snippets}
	<section class="snippets">
		{#each snippets as snippet}
			<Snippet {snippet} />
		{/each}
	</section>
{:else}
	<section>
		<p>Oops! Couldn't load snippets right now.</p>
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
