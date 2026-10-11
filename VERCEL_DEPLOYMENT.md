# Vercel deployment checklist

- [ ] `npm install` succeeds locally
- [ ] `npm run typecheck` succeeds
- [ ] `npm run build` succeeds
- [ ] `.env.local` is not committed
- [ ] Supabase migration applied
- [ ] Supabase auth redirect URLs include the deployed domain
- [ ] `NEXT_PUBLIC_SUPABASE_URL` configured in Vercel
- [ ] `NEXT_PUBLIC_SUPABASE_ANON_KEY` configured in Vercel
- [ ] `OPENAI_API_KEY` configured in Vercel if AI is enabled
- [ ] Smoke test sign-in, editor, AI endpoint, and print-to-PDF after deployment
