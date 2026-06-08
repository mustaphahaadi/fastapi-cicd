
# Stage 1: Builder — install dependencies
FROM python:3.12-slim AS builder
 
WORKDIR /app

# Install deps into a separate folder so we can copy them cleanly
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt


# Stage 2: Runtime — lean production image
FROM python:3.12-slim AS runtime
 
WORKDIR /app
 
# Copy installed packages from builder
COPY --from=builder /install /usr/local
 
# Copy application code
COPY app/ ./app/
 
# Non-root user for security
RUN useradd --no-create-home --shell /bin/false appuser
USER appuser
 
ENV APP_ENV=production
 
EXPOSE 8000
 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]