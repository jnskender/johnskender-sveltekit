<script>
	export let article;
</script>

<!-- markup (zero or more items) goes here -->

<div class="article-card">
	<section>
		<a href={`articles/${article.url}`}>
			<h2>{article.title}</h2>
			<p class="preview">{article.preview}</p>
			<span class="read-more">Read more =></span>
		</a>
	</section>
</div>

<style>
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

	.read-more {
		float: right;
	}
</style>
