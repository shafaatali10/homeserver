# Install ComfyUI on Ubuntu 26

This guide shows a simple way to install and run ComfyUI on Ubuntu 26 using the `/opt` directory.

> Best practice note: `/opt` is typically the right place for manually installed software that is not managed by the system package manager. In this repo layout, using `/opt/comfyui` keeps the software in a standard location for locally installed applications.

## Requirements

- Ubuntu 26
- Git
- Python 3.10+ recommended
- A working NVIDIA GPU is recommended for the best performance
- At least 8 GB RAM

## Step 1. Update the system

```bash
sudo apt update && sudo apt upgrade -y
```

## Step 2. Install system dependencies

```bash
sudo apt install -y git python3 python3-pip python3-venv build-essential
```

Verify versions:

```bash
python3 --version
pip3 --version
git --version
```

## Step 3. Create the install directory and virtual environment

```bash
sudo mkdir -p /opt/comfyui
sudo chown -R "$USER:$USER" /opt/comfyui
cd /opt/comfyui
# python3 -m venv .venv
# source .venv/bin/activate
# python --version
# pip --version
```

## Step 4. Clone ComfyUI

```bash
git clone https://github.com/comfyanonymous/ComfyUI.git .
```

If you prefer to keep the repository in a separate folder, use:

```bash
# cd /opt
# git clone https://github.com/comfyanonymous/ComfyUI.git comfyui
# cd comfyui
python3 -m venv .venv
source .venv/bin/activate
```

## Step 5. Install Python dependencies

Install the base requirements:

```bash
pip install -U pip setuptools wheel
pip install -r requirements.txt
```

If you have an NVIDIA GPU, install the CUDA-enabled PyTorch build:

```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
```

If you are using CPU-only mode, you can skip the CUDA-specific install and use the regular PyTorch package from PyPI.

## Step 6. Start ComfyUI

From the `/opt/comfyui` directory:

```bash
cd /opt/comfyui
source .venv/bin/activate
python main.py
```

By default, ComfyUI will start the web UI and print a local address such as:

```text
http://127.0.0.1:8188
```

## Optional: run in browser on another machine

If you want ComfyUI to be reachable from a remote host, start it with a public bind address:

```bash
python main.py --listen 0.0.0.0
```

## Optional: install custom nodes

Many users add custom nodes after the base install. Common practice is to place these inside the `custom_nodes` folder inside the ComfyUI project, then restart the app.

## Useful commands

Activate the virtual environment later:

```bash
cd /opt/comfyui
source .venv/bin/activate
```

Stop the server by pressing:

```text
Ctrl + C
```

## Notes

- If `pip install -r requirements.txt` fails, update `pip` first and retry.
- If you use a GPU, make sure your NVIDIA drivers and CUDA stack are compatible with the selected PyTorch wheel.
- For production-style deployments, you may want to run ComfyUI behind a reverse proxy or inside Docker.
