# John Skender | Personal Website

https://www.johnskender.com

My personal website for sharing information and playing with new technology.


## Built With
- [SvelteKit](https://kit.svelte.dev/)
- [mdsvex](https://kit.svelte.dev/)
  - For rendering markdown articles with the ability to include svelte components in the markup
- [vite imagetools](https://github.com/JonasKruckenberg/imagetools)
  - Crazy fast and easy image processing and optimization


## Deployed with Netlify
[![Netlify Status](https://api.netlify.com/api/v1/badges/e3a84d5e-7cde-4de6-9041-4d5e7d4e83ec/deploy-status)](https://app.netlify.com/sites/johnskender/deploys)

  - [@sveltjs/adapter-static](https://github.com/sveltejs/kit/tree/master/packages/adapter-static)
    - SSG using adapter static
- [netlify sitemap plugin](https://github.com/netlify-labs/netlify-plugin-sitemap)
  - generating a sitemap automatically on each build

## Developing

Once you've created a project and installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

Before creating a production version of your app, install an [adapter](https://kit.svelte.dev/docs#adapters) for your target environment. Then:

```bash
npm run build
```

> You can preview the built app with `npm run preview`, regardless of whether you installed an adapter. This should _not_ be used to serve your app in production.
