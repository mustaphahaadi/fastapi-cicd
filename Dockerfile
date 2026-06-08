
# Stage 1: Builder — install dependencies
FROM python:3.12-slim AS builder
 
WORKDIR /app

# Install deps into a separate folder so we can copy them cleanly
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

