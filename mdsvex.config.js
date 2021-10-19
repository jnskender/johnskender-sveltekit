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
  "rehypePlugins": []
};

export default config;