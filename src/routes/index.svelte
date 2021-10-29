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
	import Avatar from '$lib/components/Avatar.svelte';
	import ArticlesList from '$lib/components/ArticlesList.svelte';
	export let articles;
</script>

<section class="hero">
	<div class="about">
		<h1>John Skender</h1>
		<p id="job-title">Software Engineer</p>
		<p id="introduction">
			I'm currently a software engineer with 4 years experience. Focusing on the ServiceNow domain
			bringing modern web design and architecture to the platform.
		</p>
	</div>
	<Avatar />
</section>

<section class="recent-articles">
	<h2>Recent Articles</h2>

	<ArticlesList {articles} />

	<div class="bottom-controls">
		<a href="/articles">View all articles =></a>
	</div>
</section>

<style>
	.hero {
		display: flex;
		flex-direction: column;
		position: relative;
		justify-content: space-between;
		align-items: center;
		gap: var(--margin-xs);
	}

	#introduction {
		max-width: 45ch;
	}

	.hero h1 {
		font-size: var(--font-xxl);
		color: var(--color-text);
		margin: 0;
		line-height: 1.2;
	}

	#introduction {
		margin-top: var(--margin-xs);
	}

	/* float wrapper keepts floated elements in flow */
	.bottom-controls {
		display: flex;
		justify-content: end;
	}

	#job-title {
		font-size: var(--font-xl);
		font-weight: 700;
		margin: 0;
		background: -webkit-linear-gradient(to right, var(--xanadu) 0%, var(--deep-saffron) 100%);
		background: -moz-linear-gradient(to right, var(--color-tertiary) 0%, var(--color-bright) 70%);
		background: linear-gradient(
			to right,
			var(--color-secondary) 0%,
			var(--color-bright) 50%,
			var(--orange-yellow-crayola) 100%
		);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.recent-articles a {
		float: right;
	}
	.recent-articles h2 {
		font-size: var(--font-lg);
	}

	@media (min-width: 650px) {
		.hero {
			flex-direction: row;
			justify-content: flex-start;
		}
	}
</style>
