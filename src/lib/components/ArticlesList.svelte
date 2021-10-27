<script>
	export let articles;
</script>

<h1>Articles</h1>

<section class="articles">
	{#each articles as article}
		<section class="article-card">
			<article>
				<a href={`articles/${article.url}`}>
					<h3>{article.title}</h3>
					<p class="preview">{article.preview}</p>
					<section>Read more =></section>
				</a>
			</article>
		</section>
	{/each}
</section>

<style>
	.articles {
		display: grid;
		grid-template-columns: 1fr;
		gap: 32px;
	}

	.article-card {
		padding: var(--padding-m);
		border: 1px solid grey;
	}
	a {
		text-decoration: none;
	}
	a:hover {
		text-decoration: none;
	}

	@media (min-width: 650px) {
		.articles {
			grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
		}
	}
</style>
