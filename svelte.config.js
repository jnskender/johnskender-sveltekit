import { mdsvex } from "mdsvex";
import { imagetools } from "vite-imagetools";
import adapter from "@sveltejs/adapter-static"
import mdsvexConfig from "./mdsvex.config.js";
import path from "path"
/** @type {import('@sveltejs/kit').Config} */
const config = {
  "extensions": [".svelte", ...mdsvexConfig.extensions],
  kit: {
    files: {
      assets: "static"
    },
    adapter: adapter(),
    // hydrate the <div id="svelte"> element in src/app.html
    vite: {
      resolve: {
        alias: {
          $static: path.resolve('src/static')
        }
      },
      plugins: [imagetools({ force: true })]
    }
  },
  layout: "./src/components/ArticleLayout.svelte",
  preprocess: [mdsvex(mdsvexConfig)]
};

export default config;
