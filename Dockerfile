# Audio Separation App with Demucs
FROM node:18-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    ffmpeg \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create virtual environment and install Python dependencies
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir \
    demucs \
    torch \
    torchaudio \
    numpy \
    scipy

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./
COPY server/package*.json ./server/

# Install Node.js dependencies (including dev dependencies for build)
RUN rm -rf package-lock.json node_modules
RUN npm install
RUN cd server && npm ci --only=production

# Copy application code
COPY . .

# Create necessary directories
RUN mkdir -p uploads separated server/uploads server/separated

# Build the frontend using npx to ensure vite is found
RUN npx vite build

# Copy the built frontend to the server directory
RUN cp -r dist server/

# Remove dev dependencies after build to reduce image size
RUN npm prune --production

# Set permissions
RUN chmod +x server/demucs_separate.py

# Update the shebang to use the virtual environment
RUN sed -i '1s|^#!/usr/bin/env python3|#!/opt/venv/bin/python|' server/demucs_separate.py

# Expose port
EXPOSE 3001

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3001

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3001/api/health || exit 1

# Start the server
CMD ["node", "server/server.js"]
