import { ARTICLE_EXTENSION_REGEX } from '$lib/utils/extensions';

export const getArticles = () => {
	//glob cannot be dynamic which I why I didn't use the glob pattern exported from extensions
	const articles = Object.entries(
		import.meta.glob('$lib/articles/*.{svelte.md,md,svx}', { eager: true })
	).map(([path, article]) => {
		const slug = path.split('/').pop().replace(ARTICLE_EXTENSION_REGEX, ''); //remove file extension
		return {
			...article.metadata,
			slug
		};
	});
	return articles;
};
