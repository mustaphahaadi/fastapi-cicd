# ─────────────────────────────────────────────
# Stage 1: Builder — install dependencies
# ─────────────────────────────────────────────
FROM python:3.12-slim AS builder

# Create venv BEFORE setting WORKDIR
RUN python -m venv /opt/venv

WORKDIR /app

COPY requirements.txt .
RUN /opt/venv/bin/pip install --no-cache-dir -r requirements.txt


# ─────────────────────────────────────────────
# Stage 2: Runtime — lean production image
# ─────────────────────────────────────────────
FROM python:3.12-slim AS runtime

# Copy the entire venv from builder
COPY --from=builder /opt/venv /opt/venv

# Verify the copy worked (fails build loudly if not)
RUN ls /opt/venv/bin/uvicorn

WORKDIR /app

# Copy application code
COPY app/ ./app/

# Non-root user for security
RUN useradd --no-create-home --shell /bin/false appuser
USER appuser

ENV APP_ENV=production
ENV PATH="/opt/venv/bin:$PATH"

EXPOSE 8000

CMD ["/opt/venv/bin/uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]