import { useUserId } from "../hooks/useUserId";
import { useQuestions } from "../hooks/useQuestions";
import { useQuizState } from "../hooks/useQuizState";
import { Header } from "./Header";
import { QuestionPanel } from "./QuestionPanel";
import { ResultPanel } from "./ResultPanel";
import { LoadingState } from "./LoadingState";
import { EmptyState } from "./EmptyState";
import { ExplanationModal } from "./ExplanationModal";

export function QuizContainer() {
  const userId = useUserId();
  const { currentQuestion, isLoading, loadRandomQuestion } = useQuestions();
  const {
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
  } = useQuizState(userId);

  const handleNextQuestion = () => {
    resetQuizState();
    loadRandomQuestion();
  };

  if (isLoading) return <LoadingState />;
  if (!currentQuestion) return <EmptyState />;

  return (
    <div className="min-h-screen bg-linear-to-br from-gray-50 to-gray-100">
      <div className="container mx-auto px-4 py-6 max-w-6xl">
        <Header
          score={score}
          totalAttempts={totalAttempts}
          difficulty={currentQuestion.difficulty}
        />

        <div className="grid lg:grid-cols-2 gap-6">
          <QuestionPanel
            question={currentQuestion}
            userAnswer={userAnswer}
            onAnswerChange={setUserAnswer}
            onSubmit={() => handleSubmit(currentQuestion)}
            onSkip={handleNextQuestion}
            showResult={showResult}
            isCorrect={isCorrect}
          />

          <ResultPanel
            userAnswer={userAnswer}
            isCorrect={isCorrect}
            showResult={showResult}
            correctAnswer={currentQuestion.correct_output}
            onExplanationClick={() => setIsExplanationOpen(true)}
            onNextQuestion={handleNextQuestion}
          />
        </div>
      </div>

      <ExplanationModal
        isOpen={isExplanationOpen}
        onClose={() => setIsExplanationOpen(false)}
        explanation={currentQuestion.explanation}
        code={currentQuestion.code}
        correctOutput={currentQuestion.correct_output}
      />
    </div>
  );
}
