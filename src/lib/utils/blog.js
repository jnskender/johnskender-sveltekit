import fs from 'fs';
import path from 'path';
import { compile } from 'mdsvex';
import { ARTICLE_EXTENSION_REGEX } from '$lib/utils/extensions';

export const getArticlesForRender = () => {
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

/**
 *
 * @param {string} location the path where the articles are stored
 * @returns {String[]} raw file system content for article content;
 */
export const getArticlesContent = (location) => {
	return fs
		.readdirSync(location)
		.filter((file) => file.match(/.*\.(svx?)/gi)) //get all markdown files
		.map((file) => {
			return {
				fileName: path.parse(file).name,
				content: fs.readFileSync(path.join(location, file), { encoding: 'utf-8' })
			};
		});
};

export const getArticles = async () => {
	const location = 'src/routes/articles';
	const rawArticlesContent = fs
		.readdirSync(location)
		.filter((file) => file.match(/.*\.(svx?)/gi)) //get all markdown files
		.map((file) => {
			return {
				fileName: path.parse(file).name,
				content: fs.readFileSync(path.join(location, file), { encoding: 'utf-8' })
			};
		});

	return await Promise.all(
		rawArticlesContent.map(async (article) => {
			const compiledContent = await compile(article.content);
			const { title, seoTitle, image, shortDescription, isPublished } = compiledContent.data.fm; //grab frontmatter properties
			return {
				title,
				slug: article.fileName,
				preview: shortDescription || seoTitle,
				image,
				shortDescription,
				isPublished
			};
		})
	);
};
