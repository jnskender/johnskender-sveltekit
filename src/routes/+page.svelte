<script>
	import Avatar from '$lib/components/Avatar.svelte';
	import SEO from '$lib/components/SEO.svelte';
	import Icon from '$lib/components/Icon.svelte';
	import ArticlesList from '$lib/components/ArticlesList.svelte';
	import { getArticles } from '$lib/utils/blog.js';

	const articles = getArticles()
		.filter((article) => article.isPublished)
		.slice(0, 3) //top 3 articles
		.sort((a, b) => new Date(b.createdOn) - new Date(a.createdOn)); // most recent on the top
</script>

<SEO
	title="Home"
	description="John Skender creates tutorials and interactive articles focusing on ServiceNow, Javascript, and Web Development."
/>

<section class="hero">
	<div class="about">
		<h1>John Skender</h1>
		<p id="job-title">Software Engineer</p>
		<p id="introduction">
			Welcome! My name is John Skender. I’m a software engineer specializing in web technologies
			across the entire stack. I design and develop custom web applications focusing on creating
			great user experiences. Here you'll find articles and guides related to ServiceNow and it's
			surrounding technologies.
		</p>
	</div>
	<Avatar />
</section>

<section class="recent-articles">
	<h2>Recent Articles</h2>

	<ArticlesList {articles} />

	<div class="bottom-controls">
		<a href="/articles">View all articles <Icon name="arrow-right" /></a>
	</div>
</section>

<style>
	.hero {
		display: flex;
		flex-direction: column;
		position: relative;
		justify-content: space-between;
		align-items: center;
		gap: var(--margin-s);
	}

	#introduction {
		max-width: 45ch;
	}

	.hero h1 {
		font-size: var(--font-xxl);
		color: var(--color-text);
		margin: 0;
		line-height: 1;
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
		line-height: 1.2;
		margin: 0;
		background: -webkit-linear-gradient(to right, var(--xanadu) 0%, var(--deep-saffron) 100%);
		background: -moz-linear-gradient(to right, var(--color-tertiary) 0%, var(--color-bright) 70%);
		background: linear-gradient(
			to right,
			var(--color-secondary) 0%,
			var(--color-bright) 50%,
			var(--orange-yellow-crayola) 100%
		);
		background-clip: text;
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}

	.bottom-controls a {
		display: flex;
		align-items: center;
		gap: var(--margin-xs);
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
