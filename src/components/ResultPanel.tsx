import { HelpCircle, SkipForward } from "lucide-react";
import { OutputDisplay } from "./OutputDisplay";

interface ResultPanelProps {
  userAnswer: string;
  isCorrect: boolean | null;
  showResult: boolean;
  correctAnswer: string;
  onExplanationClick: () => void;
  onNextQuestion: () => void;
}

export function ResultPanel({
  userAnswer,
  isCorrect,
  showResult,
  correctAnswer,
  onExplanationClick,
  onNextQuestion,
}: ResultPanelProps) {
  return (
    <div className="space-y-4">
      <OutputDisplay
        userAnswer={userAnswer}
        isCorrect={isCorrect}
        showResult={showResult}
        correctAnswer={correctAnswer}
      />

      {showResult && (
        <div className="space-y-3">
          <button
            onClick={onExplanationClick}
            className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-white border-2 border-blue-200 text-blue-700 rounded-lg hover:bg-blue-50 transition-colors font-medium cursor-pointer"
          >
            <HelpCircle className="w-4 h-4" />
            Why is this the output?
          </button>

          {isCorrect && (
            <button
              onClick={onNextQuestion}
              className="w-full flex items-center justify-center gap-2 px-4 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors font-medium cursor-pointer"
            >
              Next Question
              <SkipForward className="w-4 h-4" />
            </button>
          )}
        </div>
      )}

      <div className="relative bg-linear-to-br from-blue-50/70 to-blue-100/60 backdrop-blur-md border border-blue-200/50 rounded-xl p-4 shadow-sm hover:shadow-md transition-all duration-300">
        <h3 className="font-semibold text-gray-900 mb-2 text-sm flex items-center gap-2">
          💡 Quick Tips
        </h3>
        <ul className="text-xs text-gray-700 space-y-1">
          <li>
            • Variable declarations (<code>var</code>) are hoisted but not
            initialized
          </li>
          <li>• Function declarations are fully hoisted</li>
          <li>
            • <code>let</code>/<code>const</code> are hoisted but in the
            temporal dead zone
          </li>
          <li>• Function expressions are not hoisted</li>
        </ul>
      </div>
    </div>
  );
}
