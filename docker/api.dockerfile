# Base image (stable for ML + FastAPI)
FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy API source code
COPY api/ api/

# Copy dependency list first (layer caching)
COPY docker/requirements.api.txt docker/requirements.api.txt

# Install only required dependencies
RUN pip install --no-cache-dir -r docker/requirements.api.txt

# Expose FastAPI port
EXPOSE 8000
EXPOSE 30080

# Start FastAPI server
CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
