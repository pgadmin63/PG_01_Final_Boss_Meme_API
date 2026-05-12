import { getBossPrompt } from "../prompts/bossPrompt";
import { arrayBufferToBase64 } from "../utils/image";

export async function generateBossFromImage(imageFile, env) {
  const arrayBuffer = await imageFile.arrayBuffer();
  const base64Image = arrayBufferToBase64(arrayBuffer);

  const response = await fetch(
    `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=${env.GEMINI_API_KEY}`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        contents: [
          {
            parts: [
              {
                text: getBossPrompt(),
              },
              {
                inline_data: {
                  mime_type: imageFile.type || "image/png",
                  data: base64Image,
                },
              },
            ],
          },
        ],
        generationConfig: {
          responseMimeType: "application/json",
        },
      }),
    }
  );

  const data = await response.json();

  if (!response.ok) {
    throw new Error(data.error?.message || "Gemini API error");
  }

  const text = data.candidates?.[0]?.content?.parts?.[0]?.text;

  if (!text) {
    throw new Error("Gemini response is empty");
  }

  return JSON.parse(text);
}