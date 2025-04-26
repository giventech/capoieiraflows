
## 🧠 CapoeiraFlows

CapoeiraFlows is a local-first, privacy-respecting AI-powered automation platform designed to:

- 🎤 Record and transcribe live meetings (using Meetily + Fast-Whisper)
- 🧠 Summarize and enrich conversations using a local LLM (Mistral via Ollama)
- 📂 Combine meeting data with reference materials (PDF, DOCX, PPTX, RTF, Markdown, Images)
- 📧 Generate Newsletters
- 📚 Create Portuguese class content
- 💬 Deliver structured updates via WhatsApp using n8n

All processing happens locally via Docker containers for OpenWebUI, ChromaDB, n8n, and Mistral. Mistral is run using [Ollama](https://ollama.com/) locally for fast LLM-based tasks.

## High level Architecture

![image](https://github.com/user-attachments/assets/e6b9920c-caa3-48fc-ae67-e787869662ca)



## Component architecture
![image](https://github.com/user-attachments/assets/0f5fc1b4-14a7-4747-ae55-75dc372ffe61)

---

## 📦 Components

| Component          | Description |
|--------------------|-------------|
| **Meetily**        | UI for live meeting capture and summaries |
| **Fast-Whisper**   | Local, efficient transcription engine |
| **Ollama + Mistral** | Local LLM for summarization and enrichment |
| **ChromaDB**       | Vector store to store meeting and reference embeddings |
| **Open WebUI**     | Simple UI to interact with LLM |
| **n8n**            | Automation engine for WhatsApp delivery and workflow management |

---

##⚙️ Setup Requirements

Make sure your system has the following:

- Windows 11
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (with WSL2 backend)
- WSL2 (Ubuntu recommended)
- [Ollama](https://ollama.com/download) (Mistral installed locally)
- Git
- Python 3.10+ (optional for scripting)

---

## 🚀 Quick Start (Docker Compose)

```bash
git clone https://github.com/giventech/capoeiraflows.git
cd capoeiraflows
docker compose up -d
```

Included Docker services:

- ChromaDB (`http://localhost:8000`)
- Open WebUI (`http://localhost:3000`)
- n8n Automation (`http://localhost:5678`)
- Meetily (`http://localhost:5173` if built from source)

> Note: Mistral runs via Ollama outside Docker. Run `ollama run mistral` before using the LLM features.

---

## 🧪 End-to-End Flow

1. Record meeting using **Meetily** in-browser
2. Audio transcription with **Fast-Whisper**
3. Summarize using **Mistral** via **Ollama**
4. Use **ChromaDB** to integrate past documents for context
5. Generate newsletter or learning material
6. Deliver content using **n8n** via WhatsApp automation

---

## 📂 Reference Document Support

Upload documents to a `/reference` folder. Supported file formats:

- `.pdf`
- `.doc`, `.docx`
- `.rtf`
- `.ppt`, `.pptx`
- `.md`, `.txt`
- `.jpg`, `.png`, `.jpeg` (OCR for image text)

Documents are processed and embedded into **ChromaDB** for semantic search and retrieval.

---

## ✉️ Output Options

- Markdown and HTML summaries
- Newsletter generation
- Portuguese language learning content
- WhatsApp delivery using n8n + Twilio or WhatsApp Cloud API

---

## 🧱 Tech Stack

- **Python 3.10+** for scripting and preprocessing
- **Docker Compose**
- **ChromaDB**
- **Ollama** with **Mistral**
- **Open WebUI**
- **n8n.io**
- **Meetily** (React-based transcription UI)
- **LangChain** for chaining document and LLM steps
- `pdfplumber`, `python-docx`, `pypptx`, `pytesseract` for file parsing and OCR

---

## 📌 Roadmap

- [ ] Upload & manage reference files from GUI
- [ ] Real-time summarization post-meeting
- [ ] WhatsApp group segmentation by topic
- [ ] Add Spanish & French language module
- [ ] Optional cloud sync (encrypted)

---

## 💡 Naming

> “CapoeiraFlows” merges the fluidity of Capoeira with intelligent automation flows.

---

## 📬 Contact

For support or collaboration, reach out: [your-email@example.com]
```

Let me know if you'd like the `docker-compose.yml`, `Dockerfile`, or automation flows to go along with it!
