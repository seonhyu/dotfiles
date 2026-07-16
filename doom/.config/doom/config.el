;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; -------------------------------------------------------------------------------
;; 기본 설정
;; -------------------------------------------------------------------------------

(setq-default delete-by-moving-to-trash t            ; Delete files to trash
              history-length 1000                    ; better company
              prescient-history-length 1000
              blink-cursor-mode 1
              indent-tabs-mode nil
              tab-width 2
              evil-shift-width 2)

;; js2-mode
(setq js2-basic-offset 2
      js2-strict-trailing-comma-warning nil
      js2-strict-missing-semi-warning nil)
;; web-mode
(setq web-mode-attr-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-markup-indent-offset 2
      web-mode-script-padding 2
      css-indent-offset 2
      js-indent-level 2
      typescript-indent-level 2)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

;; -------------------------------------------------------------------------------
;; UI
;; -------------------------------------------------------------------------------

;; (setq doom-font (font-spec :family "Sarasa Mono K" :size 16 :weight 'normal)
;;       doom-variable-pitch-font (font-spec :family "Sarasa Mono K" :weight 'normal)
;;       doom-big-font (font-spec :family "Sarasa Mono K" :size 20)
;;       doom-font-increment 1)

;; (setq doom-font (font-spec :family "goorm Sans Code" :size 15 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "goorm Sans Code" :weight 'normal)
;;       doom-big-font (font-spec :family "goorm Sans Code" :size 20)
;;       doom-font-increment 1)

(setq doom-font (font-spec :family "PragmataPro Mono" :size 15 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "PragmataPro Mono" :weight 'normal)
      doom-big-font (font-spec :family "PragmataPro Mono" :size 20)
      doom-font-increment 1)
;; 한글 폰트
(defun my/set-hangul-font (&rest _)
  (when (display-graphic-p)
    (let ((fontset (frame-parameter nil 'font)))
      (set-fontset-font fontset 'hangul
                        (font-spec :family "Sarasa Mono K") nil 'prepend)
      (set-fontset-font fontset '(#x3130 . #x318F)
                        (font-spec :family "Sarasa Mono K") nil 'prepend))
    (set-fontset-font "fontset-default" 'hangul
                      (font-spec :family "Sarasa Mono K") nil 'prepend)))
;; 초기 적용
(add-hook! 'doom-init-ui-hook #'my/set-hangul-font)
;; 폰트 크기 변경 시에도 재적용
(advice-add 'set-frame-font :after #'my/set-hangul-font)
(advice-add 'doom/increase-font-size :after #'my/set-hangul-font)
(advice-add 'doom/decrease-font-size :after #'my/set-hangul-font)
(advice-add 'doom/reset-font-size :after #'my/set-hangul-font)
;; big font 모드 전환 시에도
(advice-add 'doom-big-font-mode :after #'my/set-hangul-font)

;; macOS 폰트 렌더링 힌팅
(setq ns-use-thin-smoothing t)

;; 줄간. 기본값은 nil이고 1이면 조금 더 넓다. 소수이면 비율.
;; 폰트에 따라 효과는 다르게 보일 수 있다.
(setq-default line-spacing 0.2)

;; -------------------------------------------------------------------------------
;; keymaps
;; -------------------------------------------------------------------------------
(define-key (current-global-map) (kbd "C-h") #'evil-window-left)
(define-key (current-global-map) (kbd "C-l") #'evil-window-right)
(define-key (current-global-map) (kbd "C-j") #'evil-window-down)
(define-key (current-global-map) (kbd "C-k") #'evil-window-up)

(after! evil
  (map! :leader
        (:desc "Switch to last buffer"    :n "TAB" #'evil-switch-to-windows-last-buffer)
        (:prefix ("z" . "workspace")
         :desc "Switch to last workspace" :n "@"   #'+workspace/other
         :desc "Switch to last workspace" :n "z"   #'+workspace/other
         :desc "Display tab bar"          :n "."   #'+workspace/display
         :desc "New workspace"            :n "n"   #'+workspace/new
         :desc "Load workspace from file" :n "l"   #'+workspace/load  
         :desc "Load last session"        :n "L"   (λ! (+workspace/load-session))
         :desc "Save workspace to file"   :n "s"   #'+workspace/save
         :desc "Autosave current session" :n "S"   #'+workspace/save-session
         :desc "Switch workspace"         :n "."   #'+workspace/switch-to
         :desc "Kill all buffers"         :n "x"   #'doom/kill-all-buffers
         :desc "Delete session"           :n "X"   #'+workspace/kill-session
         :desc "Delete this workspace"    :n "d"   #'+workspace/kill
         :desc "Load session"             :n "L"   #'+workspace/load-session
         :desc "Next workspace"           :n "]"   #'+workspace/switch-right
         :desc "Previous workspace"       :n "["   #'+workspace/switch-left
         :desc "Switch to 1st workspace"  :n "1"   (λ! (+workspace/switch-to 0))
         :desc "Switch to 2nd workspace"  :n "2"   (λ! (+workspace/switch-to 1))
         :desc "Switch to 3rd workspace"  :n "3"   (λ! (+workspace/switch-to 2))
         :desc "Switch to 4th workspace"  :n "4"   (λ! (+workspace/switch-to 3))
         :desc "Switch to 5th workspace"  :n "5"   (λ! (+workspace/switch-to 4))
         :desc "Switch to 6th workspace"  :n "6"   (λ! (+workspace/switch-to 5))
         :desc "Switch to 7th workspace"  :n "7"   (λ! (+workspace/switch-to 6))
         :desc "Switch to 8th workspace"  :n "8"   (λ! (+workspace/switch-to 7))
         :desc "Switch to 9th workspace"  :n "9"   (λ! (+workspace/switch-to 8))
         :desc "Switch to last workspace" :n "0"   #'+workspace/switch-to-last)
        ))

(map! :leader
  (:prefix ("e" . "errors")
   :desc "next flycheck error" "n" #'flycheck-next-error
   :desc "prev flycheck error" "p" #'flycheck-previous-error)
)

(define-key (current-global-map) (kbd "C-;") 'hippie-expand)

;; -------------------------------------------------------------------------------
;; lang
;; -------------------------------------------------------------------------------
(add-to-list 'yas-snippet-dirs "~/.config/doom/snippets")

(use-package! flycheck
  :hook (eglot-managed-mode . flycheck-mode))

;; -------------------------------------------------------------------------------
;; typescript
;; -------------------------------------------------------------------------------
(after! treesit
  (setq treesit-language-source-alist
        '((typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src" nil nil)
          (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src" nil nil))))

(use-package tsx-ts-mode
  :ensure nil  ; tsx-ts-mode is built-in for Emacs 29+
  :mode "\\.tsx\\'"
  :config
  ;; Optional: Enable electric pair mode
  (add-hook 'tsx-ts-mode-hook #'electric-pair-local-mode)
  )

(use-package! prettier-js
  :hook
  (web-mode . prettier-js-mode)
  (js2-mode . prettier-js-mode)
  (typescript-ts-mode . prettier-js-mode)
  (tsx-ts-mode . prettier-js-mode)
  )
(add-hook 'before-save-hook 'prettier-js nil t)

(use-package! eglot
  :ensure t
  :defer 3
  :hook
  ((js2-mode
    typescript-ts-mode
    tsx-ts-mode) . eglot-ensure)
  :config
  (cl-pushnew '((js2-mode typescript-mode typescript-tsx-mode) . ("typescript-language-server" "--stdio"))
              eglot-server-programs
              :test #'equal)
  (cl-pushnew '((elixir-mode elixir-ts-mode heex-ts-mode) . ("elixir-ls"))
              eglot-server-programs
              :test #'equal))

;; -------------------------------------------------------------------------------
;; org-mode
;; -------------------------------------------------------------------------------

;; emacs 30 버전이후 org-modern 에 의해 모양 바뀐 것 복귀
;; init.el에서 +pretty flag 삭제하였으므로 필요 없어서 주석 처리함.
;;(remove-hook 'org-mode-hook #'org-modern-mode)
;;(remove-hook 'org-mode-hook #'org-indent-mode)
;;(setq org-startup-indented nil)

(use-package! org
  :config
  ;; 완료일시 기록
  (setq org-log-done 'time
        org-refile-use-outline-path 'file
        org-fold-catch-invisible-edits 'smart
        org-export-in-background t
        org-startup-folded t
        org-ellipsis " [+]"
        org-list-demote-modify-bullet nil
        org-hide-emphasis-markers 1
        org-todo-keywords '((sequence "TODO(t)" "FIX(f)" "NEXT(n)" "STARTED(s)" "WAIT(w@/!)" "|" "DONE(d)" "CANCELED(c@)"))
        org-todo-keyword-faces '(
                                 ("STARTED" . (:foreground "red" :weight bold))
                                 ("NEXT" . (:foreground "yellow" :weight bold))
                                 ("TODO" . (:foreground "green" :weight bold))
                                 ("FIX" . (:foreground "orange" :weight bold))
                                 )
        )
  )


(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background 'unspecified)
  ;; :foreground "#a9a1e1"
  (set-face-attribute 'org-code nil
                      :background 'unspecified)
  (set-face-attribute 'org-date nil
                      ;; :foreground "#5B6268"
                      :background 'unspecified)
  (set-face-attribute 'org-level-1 nil
                      ;; :foreground "steelblue2"
                      :background 'unspecified
                      :height 1.2
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      ;; :foreground "slategray2"
                      :background 'unspecified
                      ;; :height 1.2
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      ;; :foreground "SkyBlue2"
                      :background 'unspecified
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      ;; :foreground "DodgerBlue2"
                      :background 'unspecified
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      ;; :foreground "SlateGray1"
                      :background 'unspecified
                      :height 1.5
                      :weight 'bold)

  (defun my-org-update-cookies ()
    (interactive)
    (org-with-wide-buffer
     (goto-char (point-min))
     (org-update-statistics-cookies t)))
  (map! :map org-mode-map
        :localleader
        "#" 'my-org-update-cookies)
  )

(use-package! org-superstar
  :hook (org-mode . org-superstar-mode)
  :config
  (setq org-superstar-headline-bullets-list '("◉" "○" "○" "○" "○"))
  )

(use-package! org-fancy-priorities
  :defer t
  :config
  (setq org-fancy-priorities-list '((?A . "️🏌🏼‍♂️")
                                    (?B . "⛳")
                                    (?C . "🏆"))))

;; org-agenda-files를 동적 스캔 대신 캐싱
;; 캐시를 수동으로 갱신하고 싶으면 (setq my/org-agenda-files-cache nil)
(defvar my/org-agenda-files-cache nil)
(defvar my/org-agenda-files-cache-time nil)

(defun my/org-agenda-files-cached ()
  "5분간 캐싱된 agenda 파일 목록 반환."
  (when (or (null my/org-agenda-files-cache)
            (> (float-time (time-since my/org-agenda-files-cache-time)) 300))
    (setq my/org-agenda-files-cache
          (directory-files-recursively "~/Dropbox/org" "\\`[^.].*\\.org\\'")
          my/org-agenda-files-cache-time (current-time)))
  my/org-agenda-files-cache)

(setq org-agenda-files #'my/org-agenda-files-cached)

(setq org-agenda-dim-blocked-tasks nil)

(add-to-list
  'org-src-lang-modes '("plantuml" . plantuml))

(setq org-pomodoro-length 25                ; 작업 시간 (분)
      org-pomodoro-short-break-length 5     ; 짧은 휴식 시간
      org-pomodoro-long-break-length 15     ; 긴 휴식 시간
      org-pomodoro-long-break-frequency 4   ; 긴 휴식 전까지의 포모도로 횟수
      org-pomodoro-start-sound-p t          ; 시작 알림음
      org-pomodoro-finished-sound-p t)      ; 종료 알림음

;; 포모도로 상태를 모드라인에 표시
(setq org-pomodoro-mode-line t)
(after! org-pomodoro
  ;; macOS 알림 설정
  (setq org-pomodoro-finished-sound-p nil)  ; 소리 알림 끄기
  (setq org-pomodoro-finished-hook
        (lambda ()
          (call-process "terminal-notifier"
                       nil 0 nil
                       "-title" "Pomodoro Completed"
                       "-message" "Time for a break!"
                       "-sound" "default")))  ; 시스템 알림음 사용

  ;; 휴식 시간 종료 알림
  (setq org-pomodoro-break-finished-hook
        (lambda ()
          (call-process "terminal-notifier"
                       nil 0 nil
                       "-title" "Break Finished"
                       "-message" "Ready for next pomodoro?"
                       "-sound" "default")))

  ;; 긴 휴식 시간 종료 알림
  (setq org-pomodoro-long-break-finished-hook
        (lambda ()
          (call-process "terminal-notifier"
                       nil 0 nil
                       "-title" "Long Break Finished"
                       "-message" "Ready to get back to work?"
                       "-sound" "default"))))

;; SPC k -> org-capture
;; SPC k를 누르면 캡처 창이 뜨고, r을 선택하면
;; 코드 리뷰 노트가 현재 파일 링크(%a)와 선택 영역(%i)까지 자동으로 포함됩니다.
;; 코드 보다가 이슈 발견하면 영역 선택 → SPC k r → 메모 작성 → C-c C-c로 저장. 흐름이 끊기지 않습니다.
(map! :leader                                                         
      :desc "Quick capture" "k" #'org-capture)

;; capture 템플릿
(after! org
  (setq org-capture-templates
        '(("t" "TODO" entry
           (file+headline "~/Dropbox/org/inbox.org" "Inbox")
           "* TODO %?\n%U\n%a" :prepend t)
          ("r" "Code Review Note" entry
           (file+headline "~/Dropbox/org/inbox.org" "Code Review")
           "* TODO [Review] %?\n%U\n%a\n#+begin_src %^{lang}\n%i\n#+end_src" :prepend t)
          ("m" "Memo" entry
           (file+headline "~/Dropbox/org/inbox.org" "Memo")
           "* %?\n%U" :prepend t))))

;; -------------------------------------------------------------------------------
;; Markdown
;; -------------------------------------------------------------------------------

(use-package! ox-gfm
  :after org)

;; markdown-preview (SPC m p) 를 GitHub 스타일로 개선.
;; - 로컬 CSS 사용(오프라인/다크모드/버전 고정), CDN 미의존
;; - 본문을 .markdown-body 에 max-width + margin:auto 로 가운데 정렬
;; 애셋: doom/etc/{github-markdown.css, github-highlight.css, highlight.min.js}
;;
;; `doom upgrade`/`doom sync` 무충돌 설계:
;;   - Doom stock 모듈(~/.config/emacs)은 건드리지 않고 변수만 오버라이드한다.
;;   - 애셋은 doom-user-dir 하위 etc/ 에만 두며, 경로는 doom-user-dir 기준
;;     상대(expand-file-name)로 해석한다. etc/ 에 .el 을 두지 않으므로
;;     doom sync 의 바이트컴파일 대상에도 포함되지 않는다.
;;   - 애셋 버전은 upstream pin(파일 상단 주석)으로 고정 — upgrade 와 독립.
(after! markdown-mode
  (defvar +my/markdown-etc-dir
    (expand-file-name "etc/" doom-user-dir)
    "로컬 마크다운 프리뷰 애셋 디렉터리.")

  (setq markdown-css-paths
        (list (concat "file://" (expand-file-name "github-markdown.css" +my/markdown-etc-dir))
              (concat "file://" (expand-file-name "github-highlight.css" +my/markdown-etc-dir)))

        markdown-xhtml-header-content
        (concat
         "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>"
         "<style>"
         " body { margin: 0; }"
         " .markdown-body {"
         "   box-sizing: border-box;"
         "   max-width: 1200px;"
         "   margin: 0 auto;"
         "   padding: 45px;"
         " }"
         " @media (max-width: 767px) { .markdown-body { padding: 15px; } }"
         "</style>"
         "<script src='file://" (expand-file-name "highlight.min.js" +my/markdown-etc-dir) "'></script>"
         "<script id='MathJax-script' async src='https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js'></script>"
         "<script>document.addEventListener('DOMContentLoaded', () => {"
         "  document.body.classList.add('markdown-body');"
         "  document.querySelectorAll('pre[lang] > code').forEach((c) => c.classList.add(c.parentElement.lang));"
         "  document.querySelectorAll('pre > code').forEach((c) => hljs.highlightElement(c));"
         "});</script>")))

;; -------------------------------------------------------------------------------
;; Code
;; -------------------------------------------------------------------------------

;; https://github.com/Exafunction/codeium.el?tab=readme-ov-file
(use-package codeium
    ;; if you use straight
    ;; :straight '(:type git :host github :repo "Exafunction/codeium.el")
    ;; otherwise, make sure that the codeium.el file is on load-path

    :init
    ;; use globally
    (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
    ;; or on a hook
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions '(codeium-completion-at-point))))

    ;; if you want multiple completion backends, use cape (https://github.com/minad/cape):
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local completion-at-point-functions
    ;;             (list (cape-capf-super #'codeium-completion-at-point #'lsp-completion-at-point)))))
    ;; an async company-backend is coming soon!

    ;; codeium-completion-at-point is autoloaded, but you can
    ;; optionally set a timer, which might speed up things as the
    ;; codeium local language server takes ~0.2s to start up
    ;; (add-hook 'emacs-startup-hook
    ;;  (lambda () (run-with-timer 0.1 nil #'codeium-init)))

    ;; :defer t ;; lazy loading, if you want
    :config
    (setq use-dialog-box nil) ;; do not use popup boxes

    ;; if you don't want to use customize to save the api-key
    ;; (setq codeium/metadata/api_key "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

    ;; get codeium status in the modeline
    (setq codeium-mode-line-enable
        (lambda (api) (not (memq api '(CancelRequest Heartbeat AcceptCompletion)))))
    (add-to-list 'mode-line-format '(:eval (car-safe codeium-mode-line)) t)
    ;; alternatively for a more extensive mode-line
    ;; (add-to-list 'mode-line-format '(-50 "" codeium-mode-line) t)

    ;; use M-x codeium-diagnose to see apis/fields that would be sent to the local language server
    (setq codeium-api-enabled
        (lambda (api)
            (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))
    ;; you can also set a config for a single buffer like this:
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local codeium/editor_options/tab_size 4)))

    ;; You can overwrite all the codeium configs!
    ;; for example, we recommend limiting the string sent to codeium for better performance
    (defun my-codeium/document/text ()
        (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))
    ;; if you change the text, you should also change the cursor_offset
    ;; warning: this is measured by UTF-8 encoded bytes
    (defun my-codeium/document/cursor_offset ()
        (codeium-utf8-byte-length
            (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
    (setq codeium/document/text 'my-codeium/document/text)
    (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset))

(use-package company
    :defer 0.1
    :config
    (global-company-mode t)
    (setq-default
        company-idle-delay 0.05
        company-require-match nil
        company-minimum-prefix-length 0

        ;; get only preview
        company-frontends '(company-preview-frontend)
        ;; also get a drop down
        ;; company-frontends '(company-pseudo-tooltip-frontend company-preview-frontend)
        ))

;; -------------------------------------------------------------------------------
;; 생산성 check
;; -------------------------------------------------------------------------------
(defun days-until-target (target-date)
  "Calculate the number of days from today to the TARGET-DATE.
TARGET-DATE should be a string in the format 'YYYY-MM-DD'."
  (let* ((today (current-time))
         (target (date-to-time target-date))
         (diff-time (time-subtract target today))
         (diff-days (floor (/ (float-time diff-time) 86400))))
    diff-days))

(defun org-dblock-write:todo-summary (params)
  (let* ((todo-count 0)
         (wait-count 0)
         (done-count 0))
    (org-map-entries
     (lambda ()
       (let ((state (org-get-todo-state)))
         (cond
          ((string= state "TODO") (setq todo-count (1+ todo-count)))
          ((string= state "NEXT") (setq todo-count (1+ todo-count)))
          ((string= state "STARTED") (setq todo-count (1+ todo-count)))
          ((string= state "WAIT") (setq wait-count (1+ wait-count)))
          ((string= state "DONE") (setq done-count (1+ done-count))))))
       t 'file)
     (let* ((target-date (or (plist-get params :target-date) "2024-12-31"))
            (days-left (days-until-target target-date))
            (todos-per-day (if (> days-left 0)
                               (/ (float todo-count) days-left)
                             remaining-todos)))
       (insert (format "TODO count: %d\n" todo-count))
       (insert (format "WAIT count: %d\n" wait-count))
       (insert (format "DONE count: %d\n" done-count))
       (insert (format "Days until target date (%s): %d\n" target-date days-left))
       (insert (format "TODOs per day: %.2f" todos-per-day)))))

(add-to-list 'org-dynamic-block-alist '("todo-summary" . org-dblock-write:todo-summary))

(setq org-agenda-custom-commands
      '(("c" "Today's closed TODOs"
         ((tags "CLOSED>=\"<today>\""
                ((org-agenda-overriding-header "Today's closed TODOs")))))))
(map! :leader
        :desc "Today's closed TODOs"
        "o a c" #'(lambda () (interactive) (org-agenda nil "c")))

;; CLI에서 emacsclient로 이 Emacs에 파일을 열 수 있도록 서버 자동 시작
(use-package! server
  :config
  (unless (server-running-p) (server-start)))

;; emacsclient로 연 파일/디렉터리가 프로젝트에 속하면 그 프로젝트 workspace에서 연다.
;; workspace가 이미 있으면 재사용, 없으면 생성. 프로젝트가 아니면 현재 workspace에 연다.
(defun my/server-visit-in-project-workspace ()
  (when-let* ((buf (current-buffer))
              (dir (if buffer-file-name
                       (file-name-directory buffer-file-name)
                     default-directory))
              (root (projectile-project-root dir))
              (name (projectile-project-name root)))
    (unless (equal name (+workspace-current-name))
      (let ((prev (get-current-persp)))
        (+workspace-switch name t)
        ;; 반드시 추가 → 제거 순서. 어느 persp에도 없는 버퍼는
        ;; persp-autokill-buffer-on-remove에 의해 kill되기 때문.
        (persp-add-buffer buf)
        (when (and prev (persp-contain-buffer-p buf prev))
          (persp-remove-buffer buf prev))))))
(add-hook 'server-visit-hook #'my/server-visit-in-project-workspace)
