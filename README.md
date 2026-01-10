# my-dotfiles

GNU Stow를 사용한 dotfiles 관리 저장소

## 패키지

- `wezterm/` - WezTerm 터미널 설정
- `zsh/` - Zsh 설정 (Zinit, Starship, FZF 등)

## 사용법

```bash
# 저장소 클론
git clone <repo-url> ~/repos/personal/dotfiles
cd ~/repos/personal/dotfiles

# 특정 패키지 설치 (홈 디렉토리에 심볼릭 링크 생성)
stow -t ~ wezterm

# 모든 패키지 설치
stow -t ~ */

# 패키지 제거
stow -t ~ -D wezterm

# 변경사항 미리보기 (dry-run)
stow -t ~ -n -v wezterm
```

## 의존성 설치

```bash
# Homebrew 패키지 설치
brew bundle
```

## 요구사항

- [Homebrew](https://brew.sh/)
- [GNU Stow](https://www.gnu.org/software/stow/)
