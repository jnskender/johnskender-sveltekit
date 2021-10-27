<script context="module">
	/**
	 * @type {import('@sveltejs/kit').Load}
	 */
	export async function load({ fetch }) {
		const url = `./articles.json`;
		const response = await fetch(url);

		if (response.ok) {
			return {
				props: { ...(await response.json()) }
			};
		}

		return {};
	}
</script>

<script>
	import ArticlesList from '$lib/components/ArticlesList.svelte';
	export let articles;
</script>

<ArticlesList {articles} />
