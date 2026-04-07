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
    libasound2t64 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL "https://us-central1-apt.pkg.dev/doc/repo-signing-key.gpg" | gpg --dearmor -o /etc/apt/keyrings/antigravity-repo-key.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/antigravity-repo-key.gpg] https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/ antigravity-debian main" | tee /etc/apt/sources.list.d/antigravity.list \
    && curl -fsSL "https://packages.mozilla.org/apt/repo-signing-key.gpg" | gpg --dearmor -o /etc/apt/keyrings/packages.mozilla.org.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.gpg] https://packages.mozilla.org/apt mozilla main" | tee /etc/apt/sources.list.d/mozilla.list \
    && echo "Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000" > /etc/apt/preferences.d/mozilla \
    && apt-get update \
    && apt-get install -y antigravity firefox \
    && rm -rf /var/lib/apt/lists/*

# Create the startup script with Electron CPU-rendering optimizations
# The 'exec' command ensures the container supervisor can track and restart the app
RUN echo "#!/bin/sh\nexport HOME=/config\nexport DONT_PROMPT_WSL_INSTALL=1\nexec /usr/share/antigravity/antigravity --no-sandbox --disable-dev-shm-usage --disable-gpu --user-data-dir=/config/antigravity" > /startapp.sh && \
    chmod +x /startapp.sh
