<script>
	import config from '$lib/config/website.js';
	import HR from '$lib/components/HR.svelte';
</script>

<HR />

<section class="footer">
	<div class="seperator">
		<span class="title">Main</span>
		<ul>
			<li><a href="/">Home</a></li>
			<li><a href="/articles">Articles</a></li>
			<li><a href="/uses">Uses</a></li>
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
	.seperator {
		margin: 0 var(--margin-xl);
	}
	.footer {
		display: flex;
		justify-content: center;
		width: 100%;
		padding: var(--padding-m) 0;
	}

	.title {
		font-size: var(--font-lg);
	}
</style>
