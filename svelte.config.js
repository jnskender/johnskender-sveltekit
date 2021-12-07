import { mdsvex } from "mdsvex";
import adapter from '@sveltejs/adapter-netlify';
import mdsvexConfig from "./mdsvex.config.js";
/** @type {import('@sveltejs/kit').Config} */
const config = {
  "extensions": [".svelte", ...mdsvexConfig.extensions],
  kit: {
    adapter: adapter(),
    // hydrate the <div id="svelte"> element in src/app.html
    target: '#svelte'
  },
  layout: "./src/components/ArticleLayout.svelte",
  preprocess: [mdsvex(mdsvexConfig)]
};

export default config;
