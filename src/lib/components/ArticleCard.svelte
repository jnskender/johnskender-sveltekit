<script>
	import Icon from '$lib/components/Icon.svelte';
	export let article;
</script>

<!-- markup (zero or more items) goes here -->

<div class="article-card">
	<article>
		<a href={`articles/${article.url}`}>
			<h2>{article.title}</h2>
			<p class="preview">{article.preview}</p>
			<div class="read-more">
				<p>Read more</p>
				<Icon name="arrow-right" />
			</div>
		</a>
	</article>
</div>

<style>
	.article-card {
		padding: var(--padding-m);
		border: var(--border-light);
	}

	h2 {
		font-size: var(--font-lg);
	}

	.article-card > article:hover h2 {
		color: var(--color-tertiary);
	}

	a {
		text-decoration: none;
		color: var(--white);
	}
	a:hover {
		text-decoration: none;
		color: var(--white);
		box-shadow: none;
	}

	.read-more {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		gap: var(--margin-xs);
	}
</style>
