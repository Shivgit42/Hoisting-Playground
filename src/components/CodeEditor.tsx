interface CodeEditorProps {
  code: string;
}

export function CodeEditor({ code }: CodeEditorProps) {
  const lines = code.split("\n");

  return (
    <div className="bg-gray-50 border border-gray-200 rounded-lg overflow-hidden font-mono text-sm">
      <div className="flex bg-white border-b border-gray-200 px-4 py-2 items-center gap-2">
        <div className="flex gap-1.5">
          <div className="w-3 h-3 rounded-full bg-red-400"></div>
          <div className="w-3 h-3 rounded-full bg-yellow-400"></div>
          <div className="w-3 h-3 rounded-full bg-green-400"></div>
        </div>
        <span className="text-gray-600 text-xs ml-2">main.js</span>
      </div>
      <div className="p-4 bg-white text-gray-900">
        {lines.map((line, index) => (
          <div key={index} className="flex">
            <span className="text-gray-400 select-none w-8 text-right mr-4">
              {index + 1}
            </span>
            <pre className="flex-1 whitespace-pre-wrap wrap-break-word">
              {line || "\u00A0"}
            </pre>
          </div>
        ))}
      </div>
    </div>
  );
}
