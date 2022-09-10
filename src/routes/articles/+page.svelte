<script>
	import ArticlesList from '$lib/components/ArticlesList.svelte';
	const articles = Object.values(import.meta.glob('../articles/*.svx', { eager: true }))
		.map((article) => article.metadata)
		.sort((a, b) => new Date(b.createdOn) - new Date(a.createdOn)); // most recent on the top
</script>

<ArticlesList {articles} />
