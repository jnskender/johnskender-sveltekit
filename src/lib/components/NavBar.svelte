<script>
	import HR from '$lib/components/HR.svelte';
</script>

<section class="header-nav">
	<nav>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/articles">Articles</a></li>
			<li><a href="/uses">Uses</a></li>
		</ul>
	</nav>
	<HR />
</section>

<style>
	nav {
		margin: 0 auto;
		width: 100%;
		display: flex;
		justify-content: center;
		padding: 0 var(--padding-s);
	}

	.header-nav {
		margin-bottom: var(--margin-xs);
	}

	ul {
		display: flex;
		justify-content: space-between;
	}
	li {
		padding: var(--padding-s);
		font-size: var(--font-lg);
		font-weight: var(--bold);
	}

	@media (min-width: 650px) {
		.header-nav {
			margin-bottom: var(--margin-xl);
		}
	}
</style>
