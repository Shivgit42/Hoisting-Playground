interface AnswerInputProps {
  value: string;
  onChange: (value: string) => void;
  onSubmit: () => void;
  disabled?: boolean;
}

export function AnswerInput({
  value,
  onChange,
  onSubmit,
  disabled,
}: AnswerInputProps) {
  const handleKeyPress = (e: React.KeyboardEvent) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      onSubmit();
    }
  };

  return (
    <div className="space-y-2">
      <label className="block text-sm font-medium text-gray-700">
        What will be the output?
      </label>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onKeyPress={handleKeyPress}
        disabled={disabled}
        placeholder="Enter the expected output (e.g., undefined undefined)"
        className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none font-mono text-sm disabled:bg-gray-50 disabled:text-gray-500"
      />
      <div className="text-xs text-gray-500">
        Tip: For multiple values, separate with spaces (e.g., "undefined 10")
      </div>
    </div>
  );
}
