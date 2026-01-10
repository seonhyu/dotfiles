# my-dotfiles

GNU Stow를 사용한 dotfiles 관리 저장소

## 패키지

- `wezterm/` - WezTerm 터미널 설정

## 사용법

```bash
# 저장소를 홈 디렉토리에 클론
cd ~
git clone <repo-url> my-dotfiles
cd my-dotfiles

# 특정 패키지 설치 (홈 디렉토리에 심볼릭 링크 생성)
stow wezterm

# 모든 패키지 설치
stow */

# 패키지 제거
stow -D wezterm

# 변경사항 미리보기 (dry-run)
stow -n -v wezterm
```

## 요구사항

- [GNU Stow](https://www.gnu.org/software/stow/)
