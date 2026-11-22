$ErrorActionPreference = "Stop"
$App = "C:\AI\ComfyUI"
$Python = Join-Path $App ".venv\Scripts\python.exe"
$Nodes = Join-Path $App "custom_nodes"
if (-not (Test-Path $Python)) { throw "ComfyUI base install not found. Run install.ps1 first." }
New-Item -ItemType Directory -Force -Path $Nodes | Out-Null
$Repo = Join-Path $Nodes "ComfyUI-GGUF"
if (-not (Test-Path (Join-Path $Repo ".git"))) {
  git clone https://github.com/city96/ComfyUI-GGUF.git $Repo
  if ($LASTEXITCODE -ne 0) { throw "GGUF node clone failed." }
} else {
  git -C $Repo pull --ff-only
  if ($LASTEXITCODE -ne 0) { throw "GGUF node update failed." }
}
$Req = Join-Path $Repo "requirements.txt"
if (Test-Path $Req) {
  & $Python -m pip install -r $Req
  if ($LASTEXITCODE -ne 0) { throw "GGUF node requirements failed." }
}
Write-Host "GGUF node installed. Restart ComfyUI." -ForegroundColor Green
Write-Host "This does not download Wan model weights."
