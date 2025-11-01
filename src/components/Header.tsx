import { Trophy, Zap } from "lucide-react";

interface HeaderProps {
  score: number;
  totalAttempts: number;
  difficulty: string;
}

export function Header({ score, totalAttempts, difficulty }: HeaderProps) {
  return (
    <header className="mb-6 md:mb-8">
      <div className="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4">
        <div className="flex items-center gap-3">
          <div className="p-2 rounded-lg flex items-center justify-center">
            <img
              src="/hoistspace.png"
              alt="HoistSpace Logo"
              className="w-14 h-14 object-contain"
            />
          </div>
          <div>
            <h1 className="text-xl sm:text-2xl font-bold text-gray-900">
              HoistSpace
            </h1>
            <p className="text-xs sm:text-sm text-gray-600">
              Master JavaScript Hoisting Concepts
            </p>
          </div>
        </div>
        <div className="flex items-center gap-2 sm:gap-4">
          <div className="bg-white px-3 sm:px-4 py-2 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-2">
              <Trophy className="w-4 h-4 text-yellow-500" />
              <span className="text-xs sm:text-sm font-semibold text-gray-700">
                {score} / {totalAttempts}
              </span>
            </div>
          </div>
          <div className="bg-white px-3 sm:px-4 py-2 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-2">
              <Zap className="w-4 h-4 text-orange-500" />
              <span className="text-xs sm:text-sm font-semibold text-gray-700 capitalize">
                {difficulty}
              </span>
            </div>
          </div>
        </div>
      </div>
    </header>
  );
}
