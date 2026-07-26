Install Ollama:

The below command installs in `/usr/local` directory

```
curl -fsSL https://ollama.com/install.sh | sh
```

Start the service:
```
systemctl --user start ollama
```

Verify it's running:
```
ollama --version
```

Run a model:

```
ollama run qwen3:8b
# or
ollama run llama3.1:8b
```

