# FastAPI CI/CD Portfolio Project

I will be learning and building a portfolio docker project with FastAPI and CICD with github actions


A production-grade FastAPI service with a fully automated CI/CD pipeline using **Docker** and **GitHub Actions**, deployed to AWS EC2.

---

## 🏗️ Architecture

```
Developer pushes to main
        │
        ▼
┌───────────────────┐
│  GitHub Actions   │
│                   │
│  1. Run Tests     │  ← pytest
│  2. Build Image   │  ← docker buildx
│  3. Push to Hub   │  ← Docker Hub registry
│  4. Deploy to EC2 │  ← SSH + docker run
└───────────────────┘
        │
        ▼
  AWS EC2 Instance
  (container running)
```

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Application | FastAPI + Uvicorn |
| Containerization | Docker (multi-stage build) |
| Registry | Docker Hub |
| CI/CD | GitHub Actions |
| Deployment | AWS EC2 (Ubuntu) |
| Testing | Pytest |

---

## 🚀 Running Locally

**With Docker Compose:**
```bash
docker compose up --build
```

**Without Docker:**
```bash
pip install -r requirements.txt
uvicorn app.main:app --reload
```

API available at: `http://localhost:8000`
Docs at: `http://localhost:8000/docs`

---

## 🧪 Running Tests

```bash
pytest tests/ -v
```

---

## 🔄 CI/CD Pipeline

The pipeline triggers automatically on every push to `main`.

### Pipeline Stages

| Stage | Trigger | What happens |
|---|---|---|
| **Test** | Every push & PR | Installs deps, runs pytest |
| **Build & Push** | Push to main only | Builds multi-stage Docker image, pushes to Docker Hub with `latest` + SHA tag |
| **Deploy** | After successful push | SSHs into EC2, pulls new image, restarts container |

### GitHub Secrets Required

Set these in **Settings → Secrets and Variables → Actions:**

| Secret | Description |
|---|---|
| `DOCKERHUB_USERNAME` | Your Docker Hub username |
| `DOCKERHUB_TOKEN` | Docker Hub access token (not password) |
| `EC2_HOST` | Public IP of your EC2 instance |
| `EC2_USER` | SSH username (e.g. `ubuntu`) |
| `EC2_SSH_KEY` | Private key for SSH access (`.pem` contents) |

---

## 🐳 Docker Image

The Dockerfile uses a **multi-stage build**:
- **Stage 1 (builder):** Installs all Python dependencies
- **Stage 2 (runtime):** Copies only the installed packages + app code — no build tools in the final image

This keeps the production image lean and secure. A non-root user (`appuser`) runs the process.

---

## 📡 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| GET | `/` | Root — service info |
| GET | `/health` | Health check |
| GET | `/info` | Stack & pipeline info |
| GET | `/docs` | Swagger UI |

---

## 👨‍💻 Author

**Mustapha Haadi**