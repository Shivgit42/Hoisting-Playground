import { CheckCircle2, XCircle } from "lucide-react";

interface OutputDisplayProps {
  userAnswer: string;
  isCorrect: boolean | null;
  showResult: boolean;
  correctAnswer: string;
}

export function OutputDisplay({
  userAnswer,
  isCorrect,
  showResult,
  correctAnswer,
}: OutputDisplayProps) {
  return (
    <div className="bg-white border border-gray-200 rounded-lg overflow-hidden">
      <div className="bg-gray-50 border-b border-gray-200 px-4 py-2">
        <span className="text-gray-700 font-medium text-sm">Output</span>
      </div>
      <div className="p-4 min-h-[120px]">
        {!showResult ? (
          <div className="text-gray-400 text-sm">Run code to see output...</div>
        ) : (
          <div className="space-y-3">
            <div className="flex items-start gap-2">
              {isCorrect ? (
                <CheckCircle2 className="w-5 h-5 text-green-500 shrink-0 mt-0.5" />
              ) : (
                <XCircle className="w-5 h-5 text-red-500 shrink-0 mt-0.5" />
              )}
              <div className="flex-1">
                <div className="text-sm font-medium mb-1">
                  {isCorrect ? "Correct!" : "Incorrect"}
                </div>
                <div className="text-sm text-gray-600">
                  Your answer:{" "}
                  <span className="font-mono bg-gray-100 px-2 py-0.5 rounded">
                    {userAnswer || "(empty)"}
                  </span>
                </div>
                {!isCorrect && (
                  <div className="text-sm text-gray-600 mt-1">
                    Expected:{" "}
                    <span className="font-mono bg-gray-100 px-2 py-0.5 rounded">
                      {correctAnswer}
                    </span>
                  </div>
                )}
              </div>
            </div>
            {isCorrect && (
              <div className="bg-green-50 border border-green-200 rounded-lg p-3">
                <div className="text-sm text-green-800">
                  Great job! Click "Next Question" to continue.
                </div>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}
