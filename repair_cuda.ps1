$ErrorActionPreference = "Stop"
$App = "C:\AI\ComfyUI"
$Python = Join-Path $App ".venv\Scripts\python.exe"
if (-not (Test-Path $Python)) { throw "ComfyUI virtual environment not found at $Python" }
Write-Host "Removing CPU-only PyTorch and installing official CUDA 13.0 wheels..." -ForegroundColor Cyan
& $Python -m pip uninstall -y torch torchvision torchaudio
if ($LASTEXITCODE -ne 0) { throw "Could not remove old PyTorch packages." }
& $Python -m pip install torch==2.14.1 torchvision==0.29.1 --index-url https://download.pytorch.org/whl/cu130
if ($LASTEXITCODE -ne 0) { throw "CUDA PyTorch install failed." }
& $Python -c "import torch; print('torch=',torch.__version__); print('cuda=',torch.version.cuda); print('cuda_available=',torch.cuda.is_available()); print('gpu=',torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'NONE'); assert torch.cuda.is_available(), 'CUDA NOT AVAILABLE'"
if ($LASTEXITCODE -ne 0) { throw "CUDA validation failed. Send the full error output." }
Write-Host "CUDA PyTorch is installed and GPU is visible." -ForegroundColor Green
