import { Trophy, Zap, Github, Star } from "lucide-react";

interface HeaderProps {
  score: number;
  totalAttempts: number;
  difficulty: string;
}

export function Header({ score, totalAttempts, difficulty }: HeaderProps) {
  const handleGitHubClick = () => {
    window.open("https://github.com/Shivgit42/Hoisting-Playground", "_blank");
  };

  return (
    <header className="mb-6 md:mb-8 relative">
      <div className="flex justify-end mb-3 pt-2">
        <button
          onClick={handleGitHubClick}
          className="group relative flex items-center gap-2 px-3 sm:px-4 py-2 bg-gray-900 hover:bg-gray-800 text-white rounded-lg transition-all shadow-sm hover:shadow-mdc cursor-pointer"
          aria-label="Star on GitHub"
        >
          <Github className="w-4 h-4" />
          <Star className="w-3 h-3 fill-yellow-400 text-yellow-400" />
          <span className="hidden sm:inline text-xs font-medium">
            Star on GitHub
          </span>
        </button>
      </div>

      {/* Main Header Content */}
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
          {/* Score Display */}
          <div className="bg-white px-3 sm:px-4 py-2 rounded-lg shadow-sm border border-gray-200">
            <div className="flex items-center gap-2">
              <Trophy className="w-4 h-4 text-yellow-500" />
              <span className="text-xs sm:text-sm font-semibold text-gray-700">
                {score} / {totalAttempts}
              </span>
            </div>
          </div>

          {/* Difficulty Badge */}
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
