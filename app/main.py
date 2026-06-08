from fastapi import FastAPI
from fastapi.responses import JSONResponse
import os

app = FastAPI(
    title="DevOps Portfolio API Project",
    description="A FastAPI service with a full CI/CD pipeline using Docker and GitHub Actions",
    version="1.0.0"
)


@app.get("/", response_class=JSONResponse)
def root():
    return {
        "message": "DevOps Portfolio API is running. This is to demonstrate a full CI/CD pipeline with FastAPI, Docker, and GitHub Actions.",
        "version": "1.0.0",
        "environment": os.getenv("APP_ENV", "development")
    }


@app.get("/health", response_class=JSONResponse)
def health_check():
    return {
        "status": "healthy",
        "service": "fastapi-cicd"
    }


@app.get("/info", response_class=JSONResponse)
def info():
    return {
        "author": "Mustapha Haadi",
        "stack": ["FastAPI", "Docker", "GitHub Actions", "EC2"],
        "pipeline_stages": [
            "lint & test",
            "docker build",
            "push to Docker Hub",
            "deploy to EC2"
        ]
    }