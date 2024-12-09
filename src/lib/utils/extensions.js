export const ARTICLE_EXTENSIONS = ['svelte.md', 'md', 'svx'];

export const ARTICLE_EXTENSION_REGEX = new RegExp(`\\.(${ARTICLE_EXTENSIONS.join('|')})$`, 'i');
