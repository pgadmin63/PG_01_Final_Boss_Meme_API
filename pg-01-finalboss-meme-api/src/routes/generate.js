import { generateBossFromImage } from "../services/geminiService";
import { json } from "../utils/response";

export async function handleGenerate(request, env) {
  try {
    const formData = await request.formData();
    const image = formData.get("image");

    if (!image) {
      return json({ error: "Image is required" }, 400);
    }

    if (!image.type?.startsWith("image/")) {
      return json({ error: "File must be an image" }, 400);
    }

    if (image.size > 8 * 1024 * 1024) {
      return json({ error: "Image too large. Max 8MB for MVP." }, 400);
    }

    const boss = await generateBossFromImage(image, env);

    return json({
      success: true,
      boss,
    });
  } catch (error) {
    return json(
      {
        success: false,
        error: error.message || "Generate failed",
      },
      500
    );
  }
}