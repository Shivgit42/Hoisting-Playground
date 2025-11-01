import { createClient } from "@supabase/supabase-js";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error("Missing Supabase environment variables");
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface HoistingQuestion {
  id: string;
  code: string;
  correct_output: string;
  explanation: string;
  difficulty: "easy" | "medium" | "hard";
  category: string;
  created_at: string;
}

export interface UserProgress {
  id: string;
  user_id: string;
  question_id: string;
  is_correct: boolean;
  attempts: number;
  created_at: string;
}
