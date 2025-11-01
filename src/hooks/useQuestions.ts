import { useCallback, useEffect, useState } from "react";
import { type HoistingQuestion, supabase } from "../lib/supabase";

export function useQuestions() {
  const [currentQuestion, setCurrentQuestion] = useState<
    HoistingQuestion | null
  >(null);
  const [isLoading, setIsLoading] = useState(true);

  const loadRandomQuestion = useCallback(async () => {
    setIsLoading(true);
    try {
      const { data, error } = await supabase
        .from("hoisting_questions")
        .select("*")
        .order("id");

      if (error) throw error;

      if (data && data.length > 0) {
        const randomIndex = Math.floor(Math.random() * data.length);
        setCurrentQuestion(data[randomIndex]);
      }
    } catch (error) {
      console.error("Error loading question:", error);
    } finally {
      setIsLoading(false);
    }
  }, []);

  useEffect(() => {
    loadRandomQuestion();
  }, [loadRandomQuestion]);

  return {
    currentQuestion,
    isLoading,
    loadRandomQuestion,
  };
}
