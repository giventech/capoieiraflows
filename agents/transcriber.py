from fastapi import FastAPI, File, UploadFile, HTTPException, Query
from fastapi.responses import JSONResponse
import whisper
import requests
import tempfile
import os

from typing import Optional

import logging
logging.basicConfig(level=logging.INFO)

# Load default config from environment variables
DEFAULT_OLLAMA_MODEL = os.getenv("OLLAMA_MODEL", "mistral")
DEFAULT_WHISPER_MODEL = os.getenv("WHISPER_MODEL", "base")

app = FastAPI()


def transcribe_audio(file_path: str, whisper_model: str) -> str:
    model = whisper.load_model(whisper_model)
    result = model.transcribe(file_path)
    return result["text"]


def summarize_with_ollama(transcript: str, model: str) -> str:
    prompt = f"""
             You are a skilled scribe and listener, trained to distill the essence of embodied practices like Capoeira Flow.

             Given the following audio transcription from a Capoeira training session, create a structured and insightful summary that:

             1. **Captures the spirit** and intention of the dialogue and movements.
             2. **Identifies key themes or topics** (e.g., technique, rhythm, music, philosophy, reflections).
             3. **Organizes content by theme**, weaving in direct insights and mood when relevant.
             4. **Highlights unique expressions**, metaphors, or guidance from the facilitator.
             5. **Avoids repetition**, and writes in a clean, poetic yet clear tone suitable for reflection or sharing with participants.

             ---

             ### Transcript:
             {transcript}

             ---

             ### Output Format:
             Write the summary grouped by themes. Use clear headers for each theme and include short, meaningful bullet points or fluid paragraphs under each.

             Example:

             **Theme: Connection to Ground**

             - The facilitator emphasized rooting each movement into the earth.
             - Participants reflected on how balance comes from presence, not tension.

             **Theme: Dialogue in Motion**

             - Capoeira was described as a language where listening comes before attack.
             - Movement exercises explored play, responsiveness, and expression.

             ---
             Be faithful to the tone of the session. If silence, laughter, or emotional moments arise in the transcript, include their meaning as context.
             """

    response = requests.post(
        "http://localhost:11434/api/generate",
        json={"model": model, "prompt": prompt, "stream": False}
    )

    if response.ok:
        return response.json().get("response", "").strip()
    else:
        raise HTTPException(status_code=500, detail=f"Ollama summarization failed: {response.text}")


@app.post("/transcribe-and-summarize")
async def transcribe_and_summarize(
    audio: UploadFile = File(...),
    ollama_model: Optional[str] = Query(default=DEFAULT_OLLAMA_MODEL),
    whisper_model: Optional[str] = Query(default=DEFAULT_WHISPER_MODEL),
):
    if not audio.filename.endswith((".mp3", ".wav", ".m4a")):
        raise HTTPException(status_code=400, detail="Unsupported file type")

    with tempfile.NamedTemporaryFile(delete=False, suffix=".mp3") as tmp:
        tmp.write(await audio.read())
        tmp_path = tmp.name

    try:
        transcript = transcribe_audio(tmp_path, whisper_model)
        summary = summarize_with_ollama(transcript, ollama_model)
        return JSONResponse(content={
            "transcript": transcript,
            "summary": summary,
            "config": {
                "ollama_model": ollama_model,
                "whisper_model": whisper_model
            }
        })
    finally:
        os.remove(tmp_path)
