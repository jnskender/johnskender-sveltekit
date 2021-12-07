import { mdsvex } from "mdsvex";
import vercel from '@sveltejs/adapter-vercel';
import mdsvexConfig from "./mdsvex.config.js";
/** @type {import('@sveltejs/kit').Config} */
const config = {
  "extensions": [".svelte", ...mdsvexConfig.extensions],
  kit: {
    adapter: vercel(),
    // hydrate the <div id="svelte"> element in src/app.html
    target: '#svelte'
  },
  layout: "./src/components/ArticleLayout.svelte",
  preprocess: [mdsvex(mdsvexConfig)]
};

export default config;
