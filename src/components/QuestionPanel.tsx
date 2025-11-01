import { Play, SkipForward } from "lucide-react";
import { CodeEditor } from "./CodeEditor";
import { AnswerInput } from "./AnswerInput";
import type { HoistingQuestion } from "../lib/supabase";

interface QuestionPanelProps {
  question: HoistingQuestion;
  userAnswer: string;
  onAnswerChange: (value: string) => void;
  onSubmit: () => void;
  onSkip: () => void;
  showResult: boolean;
  isCorrect: boolean | null;
}

export function QuestionPanel({
  question,
  userAnswer,
  onAnswerChange,
  onSubmit,
  onSkip,
  showResult,
  isCorrect,
}: QuestionPanelProps) {
  const isDisabled = showResult && isCorrect === true;

  const badgeStyle = "bg-orange-100 text-orange-700 border border-orange-200";

  return (
    <div className="space-y-4">
      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-lg font-semibold text-gray-900">Code Snippet</h2>
          <span
            className={`text-xs px-2 py-1 rounded-full font-medium ${badgeStyle}`}
          >
            {question.category.replace(/-/g, " ")}
          </span>
        </div>
        <CodeEditor code={question.code} />
      </div>

      <div className="bg-white rounded-lg shadow-sm border border-gray-200 p-4">
        <AnswerInput
          value={userAnswer}
          onChange={onAnswerChange}
          onSubmit={onSubmit}
          disabled={isDisabled}
        />

        <div className="flex gap-3 mt-4">
          <button
            onClick={onSubmit}
            disabled={!userAnswer.trim() || isDisabled}
            className="flex-1 cursor-pointer flex items-center justify-center gap-2 px-4 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors font-medium"
          >
            <Play className="w-4 h-4" />
            Run Code
          </button>

          <div className="relative group">
            <button
              onClick={onSkip}
              className="flex cursor-pointer items-center justify-center gap-2 px-4 py-3 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors"
              aria-label="Skip to next question"
            >
              <SkipForward className="w-4 h-4" />
              <span className="hidden sm:inline text-sm font-medium">Skip</span>
            </button>

            {/* Tooltip */}
            <div className="absolute bottom-full left-1/2 -translate-x-1/2 mb-2 px-3 py-1.5 bg-gray-900 text-white text-xs rounded-lg opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none whitespace-nowrap z-10">
              Skip to next question
              <div className="absolute top-full left-1/2 -translate-x-1/2 -mt-1 border-4 border-transparent border-t-gray-900"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
