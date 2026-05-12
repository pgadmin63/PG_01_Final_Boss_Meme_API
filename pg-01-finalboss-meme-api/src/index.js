import { handleGenerate } from "./routes/generate";
import { handleCors, json } from "./utils/response";

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (request.method === "OPTIONS") {
      return handleCors();
    }

    if (url.pathname === "/" && request.method === "GET") {
      return json({
        success: true,
        message: "Final Boss API Running",
      });
    }

    if (url.pathname === "/api/generate" && request.method === "POST") {
      return handleGenerate(request, env);
    }

    return json({ error: "Not found" }, 404);
  },
};