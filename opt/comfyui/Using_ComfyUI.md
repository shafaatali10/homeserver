# Using ComfyUI

## Why the UI says models are missing

ComfyUI is just the interface and workflow engine. It does not include the large model weight files by default. You must download the checkpoint files yourself and place them in the correct model folders.

## Where to place downloaded models

Use these folders inside the ComfyUI install:

```bash

# z_image_turbo_bf16.safetensors
/opt/comfyui/models/diffusion_models


#ae.safetensors
/opt/comfyui/models/vae


#qwen_3_4b.safetensors
/opt/comfyui/models/clip
