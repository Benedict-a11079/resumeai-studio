import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = { title: 'ResumeAI Studio — Your next chapter starts here', description: 'Create a polished, ATS-conscious resume with thoughtful AI assistance.' };
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) { return <html lang="en"><body>{children}</body></html>; }
