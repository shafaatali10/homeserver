docker run -d \
 --name open-webui \
 -p 3000:8080 \
 -v open-webui:/app/backend/data \
 -e OLLAMA_BASE_URL=http://host.docker.internal:11434 \
 -e WEBUI_NAME="ChatGPT Dot" \
 --add-host=host.docker.internal:host-gateway \
 --restart always \
 ghcr.io/open-webui/open-webui:main
