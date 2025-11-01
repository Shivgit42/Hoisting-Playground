import { X, Lightbulb, Sparkles } from "lucide-react";
import { useState } from "react";

interface ExplanationModalProps {
  isOpen: boolean;
  onClose: () => void;
  explanation: string;
  code: string;
  correctOutput: string;
}

export function ExplanationModal({
  isOpen,
  onClose,
  explanation,
  code,
  correctOutput,
}: ExplanationModalProps) {
  const [aiExplanation, setAiExplanation] = useState<string>("");
  const [isLoadingAi, setIsLoadingAi] = useState(false);

  const getAiExplanation = async () => {
    setIsLoadingAi(true);
    try {
      const response = await fetch(
        `${import.meta.env.VITE_SUPABASE_URL}/functions/v1/explain-hoisting`,
        {
          method: "POST",
          headers: {
            Authorization: `Bearer ${import.meta.env.VITE_SUPABASE_ANON_KEY}`,
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ code, correctOutput }),
        }
      );

      const data = await response.json();
      setAiExplanation(data.explanation);
    } catch (error) {
      console.error(error);
      setAiExplanation(
        "AI explanation is currently unavailable. Please refer to the standard explanation above."
      );
    } finally {
      setIsLoadingAi(false);
    }
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-xl max-w-2xl w-full max-h-[80vh] overflow-hidden shadow-2xl">
        <div className="flex items-center justify-between p-6 border-b border-gray-200">
          <div className="flex items-center gap-2">
            <Lightbulb className="w-5 h-5 text-yellow-500" />
            <h2 className="text-xl font-semibold text-gray-900">Explanation</h2>
          </div>
          <button
            onClick={onClose}
            className="text-gray-400 hover:text-gray-600 transition-colors cursor-pointer"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 overflow-y-auto max-h-[calc(80vh-180px)]">
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
            <p className="text-sm text-gray-800 leading-relaxed">
              {explanation}
            </p>
          </div>

          {!aiExplanation && !isLoadingAi && (
            <button
              onClick={getAiExplanation}
              className="relative w-full flex items-center justify-center gap-2 px-5 py-3 
                bg-linear-to-r from-blue-500 via-blue-600 to-blue-700 
                text-white font-semibold rounded-xl 
                shadow-md hover:shadow-blue-500/30 
                hover:from-blue-600 hover:via-blue-700 hover:to-blue-800 
                transition-all duration-300 ease-in-out 
                group overflow-hidden cursor-pointer"
            >
              <span className="absolute inset-0 bg-linear-to-r from-blue-400 to-blue-600 opacity-0 group-hover:opacity-20 blur-lg transition-all duration-500" />

              <Sparkles className="w-5 h-5 animate-pulse group-hover:rotate-6 transition-transform" />
              <span className="relative z-10">
                Get AI-Powered Detailed Explanation
              </span>
            </button>
          )}

          {isLoadingAi && (
            <div className="flex items-center justify-center py-8">
              <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
            </div>
          )}

          {aiExplanation && (
            <div className="bg-linear-to-br from-blue-50 to-purple-50 border border-blue-200 rounded-lg p-4">
              <div className="flex items-center gap-2 mb-3">
                <Sparkles className="w-4 h-4 text-blue-600" />
                <span className="text-sm font-semibold text-gray-700">
                  AI Explanation
                </span>
              </div>
              <p className="text-sm text-gray-700 leading-relaxed whitespace-pre-wrap">
                {aiExplanation}
              </p>
            </div>
          )}
        </div>

        <div className="p-6 border-t border-gray-200">
          <button
            onClick={onClose}
            className="relative w-full flex items-center justify-center px-5 py-2.5 
            bg-linear-to-r from-gray-100 to-gray-200 
            text-gray-700 font-medium rounded-xl 
            border border-gray-300 
            shadow-sm hover:shadow-md hover:from-gray-200 hover:to-gray-300 
            transition-all duration-300 ease-in-out 
            active:scale-95 group overflow-hidden cursor-pointer"
          >
            <span className="absolute inset-0 bg-linear-to-r from-white/20 to-transparent opacity-0 group-hover:opacity-100 transition-all duration-500 blur-sm" />

            <span className="relative z-10">Close</span>
          </button>
        </div>
      </div>
    </div>
  );
}
