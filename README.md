# Docker Antigravity

Containerized deployment of the Google Antigravity application using Docker.

## Setup & Run

1. Ensure Docker and Docker Compose are installed on your machine.
2. Clone this repository:
   ```sh
   git clone https://github.com/pat-e/docker-antigravity.git
   cd docker-antigravity
   ```
3. Start the application:
   ```sh
   docker-compose up -d
   ```
4. Access the application in your browser at `http://localhost:5800`.

## Configuration

Volume mappings are pre-configured inside `docker-compose.yaml`. You might want to adjust them based on your host paths:
- Host path for config: `/volume1/docker/antigravity/config` -> Container path: `/config`
- Host path for workspace: `/volume1/docker/antigravity/workspace` -> Container path: `/workspace`

Custom Environment Variables:
- `TZ`: Set your timezone (default is `Europe/Berlin`).
- `KEEP_APP_RUNNING`: Ensures the application stays running (default is `1`).

## License

This project is licensed under the [MIT License](LICENSE).
