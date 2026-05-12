import { getBossPrompt } from "../prompts/bossPrompt";
import { arrayBufferToBase64 } from "../utils/image";

export async function generateBossFromImage(imageFile, env) {
  console.log(
    "OPENROUTER KEY:",
    env.OPENROUTER_API_KEY
  );

  const arrayBuffer =
    await imageFile.arrayBuffer();

  const base64Image =
    arrayBufferToBase64(arrayBuffer);

  const imageUrl =
    `data:${imageFile.type};base64,${base64Image}`;

  const response = await fetch(
    "https://openrouter.ai/api/v1/chat/completions",
    {
      method: "POST",

      headers: {
        Authorization:
          `Bearer ${env.OPENROUTER_API_KEY}`,

        "Content-Type": "application/json",

        "HTTP-Referer":
          "http://localhost:5173",

        "X-Title":
          "Final Boss Meme",
      },

      body: JSON.stringify({
        model: "openrouter/free",
                        
        response_format: {
          type: "json_object",
        },

        messages: [
          {
            role: "system",
            content: getBossPrompt(),
          },

          {
            role: "user",

            content: [
              {
                type: "text",

                text:
                  "Analyze this image and create a funny Final Boss meme profile.",
              },

              {
                type: "image_url",

                image_url: {
                  url: imageUrl,
                },
              },
            ],
          },
        ],

        temperature: 1.2,
      }),
    }
  );

  const data = await response.json();

  console.log(data);

  if (!response.ok) {
    throw new Error(
      data.error?.message ||
      "OpenRouter API Error"
    );
  }

  const text =
    data.choices?.[0]?.message?.content;

  if (!text) {
    throw new Error("Empty AI response");
  }

  return JSON.parse(text);
}