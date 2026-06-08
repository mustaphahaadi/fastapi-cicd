
# Stage 1: Builder — install dependencies

FROM python:3.12-slim AS builder

WORKDIR /app

# Create a venv so packages land in a known, copyable location
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt



# Stage 2: Runtime — lean production image

FROM python:3.12-slim AS runtime

WORKDIR /app

# Copy the entire venv from builder — no build tools included
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy application code
COPY app/ ./app/

# Non-root user for security
RUN useradd --no-create-home --shell /bin/false appuser
USER appuser

ENV APP_ENV=production

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]