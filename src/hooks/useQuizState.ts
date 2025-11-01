import { useCallback, useState } from "react";
import { type HoistingQuestion, supabase } from "../lib/supabase";

export function useQuizState(userId: string) {
  const [userAnswer, setUserAnswer] = useState("");
  const [isCorrect, setIsCorrect] = useState<boolean | null>(null);
  const [showResult, setShowResult] = useState(false);
  const [isExplanationOpen, setIsExplanationOpen] = useState(false);
  const [score, setScore] = useState(0);
  const [totalAttempts, setTotalAttempts] = useState(0);

  const normalizeAnswer = (answer: string): string => {
    return answer.toLowerCase().trim().replace(/\s+/g, " ");
  };

  const handleSubmit = useCallback(
    async (currentQuestion: HoistingQuestion) => {
      if (!currentQuestion || !userAnswer.trim()) return;

      const correct = normalizeAnswer(userAnswer) ===
        normalizeAnswer(currentQuestion.correct_output);

      setIsCorrect(correct);
      setShowResult(true);
      setTotalAttempts((prev) => prev + 1);

      if (correct) {
        setScore((prev) => prev + 1);
      }

      try {
        await supabase.from("user_progress").insert({
          user_id: userId,
          question_id: currentQuestion.id,
          is_correct: correct,
          attempts: 1,
        });
      } catch (error) {
        console.error("Error saving progress:", error);
      }
    },
    [userAnswer, userId],
  );

  const resetQuizState = useCallback(() => {
    setUserAnswer("");
    setIsCorrect(null);
    setShowResult(false);
  }, []);

  return {
    userAnswer,
    setUserAnswer,
    isCorrect,
    showResult,
    isExplanationOpen,
    setIsExplanationOpen,
    score,
    totalAttempts,
    handleSubmit,
    resetQuizState,
  };
}
