# ------------------------------------------------------------
# Editor
# ------------------------------------------------------------

$env:EDITOR = "nvim"
$env:VISUAL = "nvim"


# ------------------------------------------------------------
# PSReadLine
# ------------------------------------------------------------

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# vi insert mode에서도 Ctrl+P / Ctrl+N으로 history 탐색
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -ViMode Insert -Chord Ctrl+n -Function NextHistory


# ------------------------------------------------------------
# Navigation
# ------------------------------------------------------------

function ..   { Set-Location .. }
function ...  { Set-Location ../.. }
function .... { Set-Location ../../.. }


# ------------------------------------------------------------
# Git
# ------------------------------------------------------------

function gs  { git status }
function ga  { git add @args }
function gaa { git add --all }
function gc  { git commit @args }
function gco { git checkout @args }
function gsw { git switch @args }
function gb  { git branch @args }
function gl  { git log --oneline --graph --decorate @args }
function gp  { git push @args }
function gpl { git pull @args }


# ------------------------------------------------------------
# Utilities
# ------------------------------------------------------------

function which($cmd) {
    Get-Command $cmd | Select-Object -ExpandProperty Source
}

function touch($file) {
    if (Test-Path $file) {
        (Get-Item $file).LastWriteTime = Get-Date
    }
    else {
        New-Item -ItemType File $file | Out-Null
    }
}
