# Use the stable Ubuntu 24.04 LTS GUI base image
FROM jlesage/baseimage-gui:ubuntu-24.04-v4

# Set environment variables for the Web UI
ENV APP_NAME="Google Antigravity"

# Enable auto-restart if the app crashes or is accidentally closed
ENV KEEP_APP_RUNNING=1

# Install dependencies, setup the apt repository, and install Antigravity
RUN apt-get update && apt-get install -y \
    ca-certificates \
    apt-transport-https \
    curl \
    gnupg \
    libnss3 \
    libgbm1 \
    libasound2 \
    firefox \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL "https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg" | gpg --dearmor -o /etc/apt/keyrings/antigravity-repo-key.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev antigravity-apt main" | tee /etc/apt/sources.list.d/antigravity.list \
    && apt-get update \
    && apt-get install -y antigravity \
    && rm -rf /var/lib/apt/lists/*

# Create the startup script with Electron CPU-rendering optimizations
# The 'exec' command ensures the container supervisor can track and restart the app
RUN echo "#!/bin/sh\nexec /usr/bin/antigravity --no-sandbox --disable-gpu --disable-software-rasterizer" > /startapp.sh && \
    chmod +x /startapp.sh
