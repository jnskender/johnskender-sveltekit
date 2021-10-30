import path from 'path';
import { getArticles, getArticlesContent } from '$lib/utils/blog';


export async function get() {
  const articlesPath = "src/routes/articles"
  const __dirname = path.resolve();
  const location = path.join(__dirname, articlesPath)
  const postsContent = await getArticlesContent(location);
  const articles = await getArticles(postsContent);

  return {
    body: {
      articles
    }
  }
}