from fastapi import FastAPI
from fastapi.responses import JSONResponse
import os

app = FastAPI(
    title="DevOps Portfolio API",
    description="A FastAPI service with a full CI/CD pipeline using Docker and GitHub Actions",
    version="1.0.0"
)


