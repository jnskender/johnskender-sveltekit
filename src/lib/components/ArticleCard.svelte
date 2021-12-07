<script>
	export let article;
</script>

<!-- markup (zero or more items) goes here -->

<div class="article-card">
	<article>
		<a href={`articles/${article.url}`}>
			<h2>{article.title}</h2>
			<p class="preview">{article.preview}</p>
			<span class="read-more">Read more =></span>
		</a>
	</article>
</div>

<style>
	.article-card {
		padding: var(--padding-m);
		border: 1px solid grey;
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
		float: right;
	}
</style>
