# 1234 — локальный AI-видеогенератор

Целевая машина: Windows, NVIDIA RTX 4050 Laptop 6 GB VRAM, 16 GB RAM, Python 3.12.

## Что устанавливается

- ComfyUI из официального репозитория Comfy-Org
- отдельное виртуальное окружение Python
- PyTorch с CUDA 13.0 wheel index
- зависимости ComfyUI
- запуск в режиме low-VRAM / FP16

## Перед запуском

1. Установи Git for Windows: https://git-scm.com/download/win
2. Убедись, что Python 3.12 x64 доступен командой \`python --version\`.
3. Скачай репозиторий и распакуй его, либо клонируй:
   \`git clone https://github.com/maxabsolut2-max/1234.git\`
4. Запусти \`INSTALL.bat\`.

Установщик создаёт \`C:\AI\ComfyUI\` и \`C:\AI\START_COMFYUI.bat\`.
После установки открой \`C:\AI\install-check.txt\`. В отчёте \`cuda_available\` должно быть \`True\`, а GPU — NVIDIA GeForce RTX 4050 Laptop GPU.

## GGUF

После успешной базовой установки можно запустить:
\`powershell -NoProfile -ExecutionPolicy Bypass -File .\install_gguf.ps1\`

Это добавляет custom node ComfyUI-GGUF. Сам GGUF файл модели не скачивается.

## Ограничения

- Установка ComfyUI не означает, что Wan2.2 уже установлен.
- Официальный Wan2.2 TI2V-5B workflow требует значительно больше видеопамяти в стандартном режиме. 6 GB — экспериментальная конфигурация; квантование и offloading могут помочь, но не гарантируют успешную генерацию.
- Не скачивай случайные модели или BAT-файлы из непроверенных источников.
- Не запускай установщик от администратора без необходимости.
- Не вводи токены Hugging Face в публичные файлы репозитория.

## Официальные источники

- ComfyUI: https://github.com/Comfy-Org/ComfyUI
- PyTorch CUDA wheels: https://download.pytorch.org/whl/cu130
- ComfyUI-GGUF: https://github.com/city96/ComfyUI-GGUF
- Wan2.2: https://github.com/Wan-Video/Wan2.2
