import rehypeExternalLinks from "rehype-external-links";
import rehypeSlug from "rehype-slug";

const config = {
  "extensions": [".svelte.md", ".md", ".svx"],

  "smartypants": {
    "dashes": "oldschool"
  },
  layout:{
   article: "src/lib/components/ArticleLayout.svelte",
   _: "src/lib/components/DefaultLayout.svelte"
  },
  "remarkPlugins": [],
  "rehypePlugins": [rehypeExternalLinks, rehypeSlug]
};

export default config;