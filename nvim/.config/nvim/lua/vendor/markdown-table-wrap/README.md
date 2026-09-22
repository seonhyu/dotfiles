# markdown-table-wrap 파서 수정

기록일: 2026-09-23. 상태: **로컬 수정 적용 중**. upstream 반영은 수행하지 않았다.

원래 증상은 표 안의 `sif_rpt_type`에서 `_rpt_`가 강조 구문으로 해석되어
밑줄이 사라지고 `rpt`가 기울임으로 표시되는 것이었다.

`markdown.lua`는 `ice345/markdown-table-wrap.nvim`의
`176e9a72c71d48d969463525a1670c41fa2de972` 커밋에서 가져왔다. 라이선스는 함께 보관한 MIT LICENSE를 따른다.

단어 내부의 `_`와 `__`를 강조로 오인하지 않도록 구분자 경계를 검사한다.
유효하지 않은 후보 뒤에 있는 정상 강조도 계속 탐색한다.
`lua/plugins/markdown-table-wrap.lua`의 `init`에서 원래 모듈 이름으로 preload하므로
Reader와 Inline 모두 이 파서를 사용하며, 플러그인 설치 캐시는 수정하지 않는다.

호환성을 위해 플러그인 커밋도 같은 버전으로 고정했다.
플러그인 업데이트 시에는 이 로컬 수정도 함께 검토해야 한다.

upstream 수정으로 전환하는 절차:

1. 새 버전의 원본 파서에서 식별자 보존과 정상 강조 처리가 모두 해결되었는지 확인한다.
2. [플러그인 설정](../../plugins/markdown-table-wrap.lua)의 `commit` 고정과 `init`의 preload를 제거한다.
3. 이 디렉터리를 제거하고, `nvim/tests/markdown-table-wrap.lua`가 upstream 파서를 검증하도록
   vendor 참조와 preload 관련 검증을 정리한다.
4. 플러그인을 업데이트하고 `lazy-lock.json`을 갱신한 뒤 회귀 테스트와 Reader 표 정렬을 확인한다.
5. 저장소 루트 README의 로컬 수정 상태를 해제 완료로 갱신한다.

적용 당시 검증: 회귀 사례 11개, upstream 기존 테스트 122개,
Reader 식별자 보존·표 정렬·원본 보존, 실제 Neovim 설정에서 수정 파서 로딩 확인.

dotfiles 루트에서 회귀 테스트 실행 (플러그인이 lazy 기본 경로에 설치되어 있어야 함):

```sh
nvim --headless -u NONE -i NONE -l nvim/tests/markdown-table-wrap.lua
```
