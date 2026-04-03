import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  site: 'https://gapta.com.ua',
  output: 'static',
  vite: {
    plugins: [tailwindcss()],
  },
});
