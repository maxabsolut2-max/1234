# 1234 — AI Video Generator

This repository tracks the first video-generation engine selected for the project: **Wan2.2**.

## Upstream project

- Official source: https://github.com/Wan-Video/Wan2.2
- Model hub: https://huggingface.co/Wan-AI/
- ComfyUI integration guide: https://docs.comfy.org/tutorials/video/wan/wan2_2

Wan2.2 supports:
- Text-to-Video (T2V)
- Image-to-Video (I2V)
- Text-Image-to-Video (TI2V)

The official project documents a 5B TI2V model for 720p/24fps and says it can run on consumer GPUs such as an RTX 4090. The larger 14B variants have substantially higher hardware requirements.

## Important hardware note

The target laptop in this project has an NVIDIA RTX 4050. Do **not** assume the full Wan2.2 models will run locally on this GPU. Check the exact VRAM capacity and current upstream memory requirements before downloading model weights. A cloud GPU or hosted inference endpoint may be necessary.

## Recommended integration path

1. Install ComfyUI using its official instructions: https://github.com/comfyanonymous/ComfyUI
2. Follow the official Wan2.2 ComfyUI workflow guide: https://docs.comfy.org/tutorials/video/wan/wan2_2
3. Download only the model variant and workflow required for the available GPU.
4. Keep model weights outside this repository; do not commit multi-gigabyte checkpoints.
5. Record the exact model, workflow, hardware, and output settings used for each render.

## Status

- [x] Selected official upstream generator: Wan2.2
- [x] Added integration notes
- [ ] Local installation tested
- [ ] GPU compatibility verified
- [ ] First test video rendered

This repository currently contains integration documentation only. The upstream generator and model weights are not vendored here.
