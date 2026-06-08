I will be learning and building a portfolio docker project with FastAPI and CICD with github actions

The Dockerfile uses a multi-stage build:

Stage 1 (builder): Installs all Python dependencies
Stage 2 (runtime): Copies only the installed packages + app code — no build tools in the final image