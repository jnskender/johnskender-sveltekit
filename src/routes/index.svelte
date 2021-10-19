<script>
	import Avatar from '$lib/components/Avatar.svelte';
	import profilePicture from '$lib/assets/profile_picture.jpg';
</script>

<!-- <div class="hero-box-offset" /> -->
<section class="hero">
	<section class="about">
		<h1>John Skender</h1>
		<h2>Software Engineer</h2>
		<p>
			I'm currently a software engineer with 4 years experience. Focusing on the ServiceNow domain
			bringing modern web design and architecture to the platform.
		</p>
	</section>
	<Avatar />
</section>

<style>
	.hero {
		display: flex;
		position: relative;
		justify-content: center;
		align-items: center;
		padding: var(--padding-lg);
	}

	.hero p {
		max-width: 45ch;
	}

	.hero-box-offset {
		background-color: var(--xanadu-transparent);
		height: 400px;
		width: 60%;
		position: absolute;
		right: 0;
		top: 0;
		z-index: -2;
	}

	.about {
		margin: var(--margin-s);
	}

	.hero h1 {
		font-size: var(--font-xxl);
		color: var(--color-text);
	}
	.hero h2 {
		font-size: var(--font-xl);

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

	h1,
	h2 {
		line-height: 1.2;
	}
</style>
