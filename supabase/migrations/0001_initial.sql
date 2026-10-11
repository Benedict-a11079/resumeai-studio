-- Run in Supabase SQL Editor. Resume records are private to their owner.
create extension if not exists pgcrypto;
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create table if not exists public.resumes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null default 'Untitled resume' check (char_length(title) <= 120),
  content jsonb not null default '{}'::jsonb,
  template text not null default 'classic' check (template in ('classic','modern','minimal','developer','fresher')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists resumes_user_updated_idx on public.resumes(user_id, updated_at desc);
alter table public.profiles enable row level security;
alter table public.resumes enable row level security;
create policy "Users can read own profile" on public.profiles for select using (auth.uid() = id);
create policy "Users can insert own profile" on public.profiles for insert with check (auth.uid() = id);
create policy "Users can update own profile" on public.profiles for update using (auth.uid() = id) with check (auth.uid() = id);
create policy "Users can read own resumes" on public.resumes for select using (auth.uid() = user_id);
create policy "Users can create own resumes" on public.resumes for insert with check (auth.uid() = user_id);
create policy "Users can update own resumes" on public.resumes for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "Users can delete own resumes" on public.resumes for delete using (auth.uid() = user_id);
create or replace function public.set_updated_at() returns trigger language plpgsql as $$ begin new.updated_at = now(); return new; end; $$;
drop trigger if exists resumes_set_updated_at on public.resumes;
create trigger resumes_set_updated_at before update on public.resumes for each row execute function public.set_updated_at();
