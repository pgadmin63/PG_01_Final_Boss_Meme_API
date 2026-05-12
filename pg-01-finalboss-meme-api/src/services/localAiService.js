import { getBossPrompt } from "../prompts/bossPrompt";
import { arrayBufferToBase64 } from "../utils/image";

export async function generateBossFromImage(imageFile) {

  console.log("===== LOCAL AI DEBUG =====");

  const arrayBuffer =
    await imageFile.arrayBuffer();

  const base64Image =
    arrayBufferToBase64(arrayBuffer);

  const response = await fetch(
    "http://localhost:11434/api/chat",
    {
      method: "POST",

      headers: {
        "Content-Type": "application/json",
      },

      body: JSON.stringify({
        model: "llava",

        stream: false,

        format: "json",

        messages: [
          {
            role: "system",

            content: getBossPrompt(),
          },

          {
            role: "user",

            content:
              "Analyze this image and create a funny Vietnamese Final Boss profile.",

            images: [base64Image],
          },
        ],
      }),
    }
  );

  const data = await response.json();

  console.log(data);

  if (!response.ok) {
    throw new Error(
      data.error || "Local AI error"
    );
  }

  const text =
    data.message?.content;

  if (!text) {
    throw new Error(
      "Local AI response is empty"
    );
  }

  return JSON.parse(text);
}