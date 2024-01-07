import { sveltekit } from '@sveltejs/kit/vite';
import { enhancedImages } from '@sveltejs/enhanced-img';
/** @type {import('vite').UserConfig} */
const config = {
	plugins: [enhancedImages(), sveltekit()]
};

export default config;
