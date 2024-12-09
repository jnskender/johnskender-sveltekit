import { ARTICLE_EXTENSIONS } from '$lib/utils/extensions';
export async function load({ params }) {
	for (const ext of ARTICLE_EXTENSIONS) {
		try {
			const article = await import(`$lib/articles/${params.slug}.${ext}`);
			return { article };
		} catch {
			// Continue to the next extension if this one fails
		}
	}

	// If no files were found, throw an error
	throw new Error('Article not found');
}
