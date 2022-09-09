import { imagetools } from 'vite-imagetools';
import { sveltekit } from '@sveltejs/kit/vite';

/** @type {import('vite').UserConfig} */
const config = {
  plugins: [imagetools({ force: true }), sveltekit()]
}

export default config;