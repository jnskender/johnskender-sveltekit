<nav>
	<ul>
		<li><a href="/">Home</a></li>
		<li><a href="/articles">Articles</a></li>
		<li><a href="/snippets">Snippets</a></li>
	</ul>
</nav>

<style>
	nav {
		margin: 0 auto;
		max-width: calc(var(--container-max-width));
		display: flex;
		justify-content: center;
	}

	ul {
		display: flex;
		justify-content: space-between;
	}
	li {
		margin: var(--margin-xs);
		padding: var(--padding-s);
		font-size: var(--font-lg);
	}

	@media (max-width: 750px) {
		ul {
			display: none;
		}
	}
</style>
