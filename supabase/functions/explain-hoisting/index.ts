const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers":
    "Content-Type, Authorization, X-Client-Info, Apikey",
};

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 200,
      headers: corsHeaders,
    });
  }

  try {
    const { code, correctOutput } = await req.json();

    const GROQ_API_KEY = Deno.env.get("GROQ_API_KEY");

    if (!GROQ_API_KEY) {
      throw new Error("GROQ_API_KEY not configured");
    }

    const response = await fetch(
      "https://api.groq.com/openai/v1/chat/completions",
      {
        method: "POST",
        headers: {
          "Authorization": `Bearer ${GROQ_API_KEY}`,
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          model: "llama-3.3-70b-versatile",
          messages: [
            {
              role: "system",
              content:
                `You are an expert JavaScript teacher specializing in explaining hoisting concepts. 
Your job is to analyze code snippets and explain WHY they produce specific outputs, focusing on:
- How hoisting works in this specific code
- Step-by-step execution flow
- Why variables/functions behave the way they do
- Common pitfalls and misconceptions

Be detailed but clear. Use examples from the actual code provided.`,
            },
            {
              role: "user",
              content:
                `Analyze this JavaScript code and explain why it produces the output "${correctOutput}":

\`\`\`javascript
${code}
\`\`\`

Provide a detailed, step-by-step explanation of:
1. What gets hoisted and how
2. The execution order after hoisting
3. Why the output is specifically "${correctOutput}"
4. Key learning points about hoisting from this example

Keep it educational and easy to understand.`,
            },
          ],
          temperature: 0.7,
          max_tokens: 800,
        }),
      },
    );

    const data = await response.json();

    if (!response.ok) {
      throw new Error(data.error?.message || "OpenAI API error");
    }

    const explanation = data.choices[0].message.content;

    return new Response(
      JSON.stringify({ explanation }),
      {
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  } catch (error) {
    console.error("Handled Error:", error);
    return new Response(
      JSON.stringify({
        error: "Failed to generate explanation",
        details: error instanceof Error ? error.message : String(error),
      }),
      {
        status: 500,
        headers: {
          ...corsHeaders,
          "Content-Type": "application/json",
        },
      },
    );
  }
});
