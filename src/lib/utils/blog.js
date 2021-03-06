import fs from 'fs';
import path from 'path';
import { compile } from 'mdsvex';
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
