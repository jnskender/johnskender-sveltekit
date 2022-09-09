import { imagetools } from 'vite-imagetools';
import path from 'path';
import { sveltekit } from '@sveltejs/kit/vite';

/** @type {import('vite').UserConfig} */
const config = {
  resolve: {
    alias: {
      $static: path.resolve('src/static')
    }
  },
  plugins: [imagetools({ force: true }), sveltekit()]
}

export default config;