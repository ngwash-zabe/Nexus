import { defineConfig } from 'vite';

export default defineConfig({
  root: '.',
  server: {
    port: parseInt(process.env.PORT) || 3000,
    host: '0.0.0.0',
    middlewareMode: false
  },
  build: {
    outDir: 'dist',
    minify: 'terser',
    sourcemap: false
  },
  define: {
    __DEV__: JSON.stringify(process.env.NODE_ENV !== 'production')
  }
});
