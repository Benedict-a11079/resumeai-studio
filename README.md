# ResumeAI Studio

A Vercel-oriented Next.js starter for an AI-assisted resume builder. The current implementation includes a responsive landing page, local dashboard, structured resume editor, five preview styles, browser autosave, print-to-PDF, a Supabase sign-up/sign-in screen, a server-side AI endpoint, and an initial Supabase schema with row-level security.

> **Important status note:** The editor currently saves drafts to the current browser's `localStorage`. Supabase authentication and the SQL schema are included, but the editor is not yet wired to load/save resume records in Supabase. Configure and test authentication before treating this as a production app. AI features work only after a valid model API key is configured. This starter has not been deployed or build-tested in your account.

## Requirements

- Node.js 20 or newer
- npm
- A Supabase project (optional for local editor; required for accounts/cloud persistence)
- An AI provider API key compatible with the configured OpenAI provider (optional until using AI)

## Run locally

1. Extract the project folder and open a terminal inside it.
2. Install packages:

   ```bash
   npm install
   ```

3. Copy `.env.example` to `.env.local`.
4. Add your Supabase URL and anon key if using authentication.
5. Add `OPENAI_API_KEY` to enable the AI assistant. Keep it server-side; do not use a `NEXT_PUBLIC_` prefix.
6. Start the development server:

   ```bash
   npm run dev
   ```

7. Open http://localhost:3000.

## Configure Supabase

1. Create a project at https://supabase.com/.
2. In Project Settings → API, copy the Project URL and anon/public key into `.env.local`.
3. Open SQL Editor and run `supabase/migrations/0001_initial.sql`.
4. In Authentication → URL Configuration, add your local URL (`http://localhost:3000`) and your eventual Vercel URL to the allowed redirect URLs.
5. Restart the local development server after changing environment variables.

The migration enables Row Level Security for profile and resume data. The current UI does not yet perform cloud resume CRUD; do not remove the RLS policies to work around that.

## Configure AI

The AI endpoint is `POST /api/ai/route` and accepts a task (`improve`, `bullet`, `review`, `match`, or `chat`), optional resume data, text, and a job description. It calls the configured model on the server. Set `OPENAI_API_KEY` and optionally `AI_MODEL` in `.env.local`. The default model is `gpt-4o-mini`; use a model name available to your provider account. Provider usage may incur charges.

## Deploy to Vercel

1. Create a private GitHub repository and push this project.
2. In Vercel, choose **Add New → Project** and import the repository.
3. Add the environment variables from `.env.example` in Vercel Project Settings → Environment Variables.
4. Deploy. Redeploy after changing environment variables.
5. Add the deployed domain to Supabase Authentication's allowed redirect URLs.
6. Test sign-up, sign-in, AI calls, and PDF export on the deployed site.

Vercel and Supabase free-plan quotas and features can change. AI API usage may be billed separately. Do not commit `.env.local` or any secrets.

## Features

- Landing page and workspace dashboard
- Structured personal details, education, experience, projects, skills, certifications
- Five template styles sharing the same resume data
- Browser autosave for a starter/demo workflow
- Live resume preview and print-to-PDF
- AI summary improvement, bullet generation, review, job matching, and career Q&A through a server-side route
- Supabase auth screen and SQL schema with row-level security

## Known limitations before production

- Resume drafts are browser-local and do not sync across devices yet.
- The dashboard and editor are demo-friendly and do not yet require an authenticated session.
- Account recovery, profile management, cloud resume CRUD, usage metering, and production-grade rate limiting remain to be implemented.
- PDF output uses the browser print dialog. Verify page breaks and formatting in the target browser.
- Run `npm run typecheck` and `npm run build` after installing dependencies; this generated project has not been run in your environment.
