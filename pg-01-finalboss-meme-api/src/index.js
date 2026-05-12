/**
 * Welcome to Cloudflare Workers! This is your first worker.
 *
 * - Run `npm run dev` in your terminal to start a development server
 * - Open a browser tab at http://localhost:8787/ to see your worker in action
 * - Run `npm run deploy` to publish your worker
 *
 * Learn more at https://developers.cloudflare.com/workers/
 */

import { handleGenerate } from "./routes/generate";
import { handleCors, json } from "./utils/response";

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (request.method === "OPTIONS") {
      return handleCors();
    }

    if (url.pathname === "/api/generate" && request.method === "POST") {
      return handleGenerate(request, env);
    }

    return json({ error: "Not found" }, 404);
  },
};