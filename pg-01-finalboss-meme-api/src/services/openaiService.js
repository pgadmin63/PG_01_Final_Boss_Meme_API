import { getBossPrompt } from "../prompts/bossPrompt";
import { arrayBufferToBase64 } from "../utils/image";

export async function generateBossFromImage(imageFile, env) {
    console.log(env.OPENAI_API_KEY);
    
  const arrayBuffer = await imageFile.arrayBuffer();

  const base64Image = arrayBufferToBase64(arrayBuffer);

  const imageUrl = `data:${imageFile.type};base64,${base64Image}`;

  const response = await fetch(
    "https://api.openai.com/v1/chat/completions",
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${env.OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-4.1-mini",

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
                text: "Analyze this image and generate a Final Boss meme profile.",
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

  if (!response.ok) {
    console.error(data);

    throw new Error(
      data.error?.message || "OpenAI API error"
    );
  }

  const text =
    data.choices?.[0]?.message?.content;

  if (!text) {
    throw new Error("OpenAI response empty");
  }

  return JSON.parse(text);
}