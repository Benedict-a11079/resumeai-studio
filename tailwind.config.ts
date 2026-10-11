import type { Config } from 'tailwindcss';
const config: Config = { content: ['./app/**/*.{js,ts,jsx,tsx,mdx}','./components/**/*.{js,ts,jsx,tsx,mdx}'], theme: { extend: { colors: { ink:'#10213b', brand:'#315efb', mist:'#f5f7fb' }, boxShadow: { soft:'0 18px 60px rgba(20,38,75,.08)' } } }, plugins: [] };
export default config;
