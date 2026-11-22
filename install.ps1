$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"
$Root = "C:\AI"
$App = Join-Path $Root "ComfyUI"
$Python = "python"
Write-Host "=== EPICENTER / ComfyUI installer ===" -ForegroundColor Cyan
Write-Host "Target: RTX 4050 6GB VRAM, 16GB RAM"
New-Item -ItemType Directory -Force -Path $Root | Out-Null
& $Python --version
if ($LASTEXITCODE -ne 0) { throw "Python was not found. Install Python 3.12 x64 and enable Add Python to PATH." }
$pyVersion = & $Python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
if ($pyVersion -ne "3.12") { throw "This setup expects Python 3.12; detected $pyVersion." }
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "Git is required. Install Git for Windows from https://git-scm.com/download/win and rerun." }
if (-not (Test-Path (Join-Path $App ".git"))) {
  if (Test-Path $App) { throw "$App exists but is not a Git repository. Rename it and rerun." }
  git clone https://github.com/Comfy-Org/ComfyUI.git $App
  if ($LASTEXITCODE -ne 0) { throw "ComfyUI clone failed." }
} else {
  git -C $App pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw "ComfyUI update failed; resolve Git state before continuing." }
}
$Venv = Join-Path $App ".venv"
if (-not (Test-Path (Join-Path $Venv "Scripts\python.exe"))) {
  & $Python -m venv $Venv
  if ($LASTEXITCODE -ne 0) { throw "Could not create Python virtual environment." }
}
$VPython = Join-Path $Venv "Scripts\python.exe"
& $VPython -m pip install --upgrade pip
if ($LASTEXITCODE -ne 0) { throw "pip upgrade failed." }
# Official ComfyUI NVIDIA guidance currently uses the CUDA 13.0 PyTorch wheel index.
& $VPython -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu130
if ($LASTEXITCODE -ne 0) { throw "CUDA PyTorch installation failed." }
& $VPython -m pip install -r (Join-Path $App "requirements.txt")
if ($LASTEXITCODE -ne 0) { throw "ComfyUI requirements installation failed." }
$Models = Join-Path $App "models"
@("checkpoints","diffusion_models","text_encoders","vae","loras","clip_vision") | ForEach-Object { New-Item -ItemType Directory -Force -Path (Join-Path $Models $_) | Out-Null }
$Check = & $VPython -c "import torch; print('torch',torch.__version__); print('cuda_available',torch.cuda.is_available()); print('gpu',torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'NONE'); print('vram_gb',round(torch.cuda.get_device_properties(0).total_memory/1024**3,2) if torch.cuda.is_available() else 0)"
$Check | Tee-Object -FilePath (Join-Path $Root "install-check.txt")
if ($LASTEXITCODE -ne 0) { throw "PyTorch GPU check failed." }
@"
@echo off
cd /d "$App"
call ".venv\Scripts\activate.bat"
python main.py --lowvram --force-fp16 --preview-method none
pause
"@ | Set-Content -Encoding ASCII (Join-Path $Root "START_COMFYUI.bat")
Write-Host "Base installation finished. Report: $Root\install-check.txt" -ForegroundColor Green
Write-Host "Launch with: $Root\START_COMFYUI.bat"
Write-Host "No video model weights have been downloaded yet."
