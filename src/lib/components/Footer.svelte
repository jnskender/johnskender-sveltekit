<script>
	import config from '$lib/config/website.js';
</script>

<section class="break" />

<section class="footer">
	<div class="seperator">
		<span class="title">Main</span>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/articles">Articles</a></li>
		</ul>
	</div>
	<div class="seperator">
		<span class="title">Social</span>
		<ul>
			{#each config.social as item}
				<li>
					<a href={item.href} target="blank" rel="noopener">{item.label}</a>
				</li>
			{/each}
		</ul>
	</div>
</section>

<style>
	.break {
		margin: var(--margin-xl) auto;
		min-width: 50%;
		max-width: 75%;
		border-bottom: 1px solid var(--color-secondary);
	}

	.seperator {
		margin: 0 var(--margin-xl);
	}
	.footer {
		display: flex;
		justify-content: center;
		width: 100%;
		margin: var(--margin-m) 0;
	}

	.title {
		font-size: var(--font-lg);
	}
</style>
