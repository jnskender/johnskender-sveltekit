<script>
	import ArticlesList from '$lib/components/ArticlesList.svelte';
	import { getArticles } from '$lib/utils/blog.js';

	const articles = getArticles();
	articles
		.filter((article) => article.isPublished)
		.sort((a, b) => new Date(b.createdOn) - new Date(a.createdOn)); // most recent on the top
</script>

<ArticlesList {articles} />
