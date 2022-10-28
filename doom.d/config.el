;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "seonhyu"
      user-mail-address "seonhyu@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; ----------------------------------------------------------
;; 01 UI / Basic
;; ----------------------------------------------------------

;; 들여쓰기
(setq-default delete-by-moving-to-trash t            ; Delete files to trash
              history-length 1000                    ; better company
              prescient-history-length 1000
              blink-cursor-mode 1
              indent-tabs-mode nil
              tab-width 2
              evil-shift-width 2
              line-spacing 3                          ; 줄간. 기본값은 nil이고 1이면 조금 더 넓다. 소수이면 비율. comapny-mode 높이 문제 발생.
              ;; js2-mode
              js2-basic-offset 2
              js2-strict-trailing-comma-warning nil
              js2-strict-missing-semi-warning nil
              ;; web-mode
              web-mode-attr-indent-offset 2
              web-mode-code-indent-offset 2
              web-mode-css-indent-offset 2
              web-mode-markup-indent-offset 2
              web-mode-script-padding 2
              css-indent-offset 2
              js-indent-level 2
              typescript-indent-level 2)

;; 한글 출력이 추한 AppleGothic인 것을 바꾸기 위해서.
;; Sarasa Mono K - company box 깨진다
;;   - 아니다, doom-font, doom-variable-pitch-font 가 다을면 깨진다.
(setq doom-theme 'doom-one
      doom-font (font-spec :family "Sarasa Term K" :size 14 :weight 'normal)
      doom-variable-pitch-font (font-spec :family "Sarasa Term K")
      doom-big-font (font-spec :family "Sarasa Term K" :size 16)
      doom-font-increment 1
      display-line-numbers-type t
      create-lockfiles nil
      highlight-indent-guides-responsive 'top    ; indent-guide 현재 위치 highlight
      undo-limit 80000000                        ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                      ; By default while in insert all changes are one big blob. Be more granular
      inhibit-compacting-font-caches t           ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…"              ; Unicode ellispis are nicer than "...", and also save /precious/ space
      which-key-idle-delay 0.5
      ;; windows 열때 새 윈도우로 포커스 이동
      evil-vsplit-window-right t
      evil-split-window-below t
      )
;; (set-fontset-font t 'hangul (font-spec :name "D2Coding" :weight 'normal))

;; 한글 파일명 자소분리 해결
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)

;; 아래 있으면 ivy/helm/counsel 한글 검색 안된다.
;; (setq default-process-coding-system '(utf-8-hfs . utf-8-hfs))

;; esc 한 -> 영
;;(setq default-input-method "korean-hangul")
(global-set-key (kbd "<f13>") 'toggle-input-method)

;; 시작할 때 전체화면
;; (toggle-frame-fullschaekinssareen)

;; treemacs 모양 변경
;; folder open 일 때 줄맞춤 깨지는 문제 해결.
(setq doom-themes-treemacs-theme "doom-atom")
(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)

;; 커서 위치 강조
(beacon-mode 1)

;; ----------------------------------------------------------
;; 02 keymaps
;; ----------------------------------------------------------

;; window 이동
(define-key (current-global-map) (kbd "C-h") #'evil-window-left)
(define-key (current-global-map) (kbd "C-l") #'evil-window-right)
(define-key (current-global-map) (kbd "C-j") #'evil-window-down)
(define-key (current-global-map) (kbd "C-k") #'evil-window-up)

;; 단어 자동완성
(define-key (current-global-map) (kbd "C-;") 'dabbrev-expand)

;; leader-tab 으로 이전 버퍼이동하기 위해서
;; workspace가 tab 기본 map이었기때문에 z로 이동한다.
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
         :desc "Delete this workspace"    :n "d"   #'+workspace/delete
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

(use-package! markdown-mode
  :config
  (map! :mode markdown-mode
        :localleader
        :desc "Live markdown preview " :nve "p" #'vmd-mode
        )
  )

;; ----------------------------------------------------------
;; 03 org-mode
;; ----------------------------------------------------------

(setq org-directory "~/Dropbox/org/"
      org-roam-directory "~/Dropbox/org"
      ;; scheduled이면 deadline 미리 알림 안보이게
      org-agenda-skip-deadline-prewarning-if-scheduled t
      )

(setq org-agenda-files (apply 'append
                              (mapcar
                               (lambda (directory)
                                 (directory-files-recursively
                                  directory "\\`[^.].*\\.org\\'"))
                               '("~/Dropbox/org"))))

(use-package! org
  :defer t
  :config
  ;; 완료일시 기록
  (setq org-log-done 'time
        org-refile-use-outline-path 'file
        org-export-in-background t
        org-fold-catch-invisible-edits 'smart
        org-startup-folded 'fold
        org-ellipsis " ↘"
        org-list-demote-modify-bullet nil
        org-hide-emphasis-markers 1
        org-todo-keywords '((sequence "TODO(t)" "FIX(f)" "STARTED(s)" "|" "DONE(d)"))
        org-todo-keyword-faces '(("STARTED" . (:foreground "red" :weight bold))))
        ;; inline image 출력 크기를 1/3로 줄임
        org-image-actual-width (/ (display-pixel-width) 3)

        ;; org-mode에서 한영문자 조화롭게 보이기
        ;; custom-set-faces가 doom에서 가장 유효한 방법
        ;; 기본 font가 Sarasa Mono가 아닌 경우만 적용한다.
        ;(custom-set-faces!
        ;  '(default :family "Sarasa Mono K")
        ;  '(org-document-title :height 1.3 :weight bold)
        ;  '(link :weight normal)
        ;  )
        )

;; default 2
(setq org-indent-indentation-per-level 2)
(setq org-bullets-bullet-list '("◉" "◎" "○" "○" "○"))

(use-package org-fancy-priorities
  :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

;; plantuml
;;(setq org-plantuml-exec-mode 'plantuml)
;;(setq org-plantuml-executable-args '("-charset UTF-8 -headless"))
;; (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(setq org-image-actual-width nil)

;; from https://github.com/zaiste/.doom.d/blob/master/config.el
(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :background nil)
  (set-face-attribute 'org-code nil
                      ;; :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      ;; :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      ;; :foreground "steelblue2"
                      :background nil
                      :height 1.5
                      :weight 'bold)
  (set-face-attribute 'org-level-2 nil
                      ;; :foreground "slategray2"
                      :background nil
                      :height 1.2
                      :weight 'bold)
  (set-face-attribute 'org-level-3 nil
                      ;; :foreground "SkyBlue2"
                      :background nil
                      :height 1.0
                      :weight 'bold)
  (set-face-attribute 'org-level-4 nil
                      ;; :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      ;; :foreground "SlateGray1"
                      :background nil
                      :height 1.75
                      :weight 'bold)
  )

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; -----------------------------------------------------------------
;; 단어 일부만 mark up
;; C-* 단축키로 너비가 없는 여백을 추가하는 방법
(defun insert-zero-width-space ()
  (interactive)
  (insert-char #x200b))

(define-key org-mode-map (kbd "C-*") 'insert-zero-width-space)

(setq org-emphasis-regexp-components
      '("   ('\"{\x200B" "-     .,:!?;'\")}\\[\x200B" "
,\"'" "." 1))

;; export할 때는 공백 제거
(defun my-filter-remove-u200b (text backend info)
  "Remove zero width space character (U+200B) from TEXT."
  (replace-regexp-in-string "\x200B" "" text))

; org-export-filter-plain-text-functions 없는 변수라고 함.
;; (add-to-list 'org-export-filter-plain-text-functions
;;          'my-filter-remove-u200b)

;; ----------------------------------------------------------
;; 04 lsp-mode
;; ----------------------------------------------------------

(use-package! lsp-mode
  :config
  ;; LSP관련 성능
  ;; https://github.com/emacs-lsp/lsp-mode#performance
  ;; 200mb
  (setq lsp-enable-file-watchers nil)
  (setq lsp-warn-no-matched-clients nil)
  (setq gc-cons-threshold 200000000
        read-process-output-max (* 1024 1024)  ;; 1mb
        lsp-file-watch-threshold 5000 ;; default 1000
        )
  (dolist (dir '(
               "[/\\\\]\\.elixir_ls\\'"
               "[/\\\\]\\.log\\'"
               "[/\\\\]_build\\'"
               "[/\\\\]devops\\'"
               "[/\\\\]doc\\'"
               "[/\\\\]static\\'"
               "[/\\\\]tmp\\'"
               ;; nextjs
               "[/\\\\]\\.next\\'"
               "[/\\\\]\\out\\'"
               ;; 약산 임시
               "[/\\\\]vue\\'"
               "[/\\\\]assets-react\\'"
               ))
    (push dir lsp-file-watch-ignored-directories))
  :hook
  (elixir-mode . lsp)
  :init
  (add-hook 'lsp-mode-hook #'lsp-ui-mode)
  (add-to-list 'exec-path "~/elixir-ls/release/language_server.sh")
  )

(use-package! lsp-ui
  :config
  (setq
   lsp-ui-doc-show-with-cursor t
   lsp-ui-doc-delay 2
   lsp-ui-doc-include-signature t
   lsp-ui-doc-position 'top
   lsp-ui-doc-frame-mode t
   lsp-ui-doc-max-height 80
   lsp-ui-doc-max-width 300
   lsp-ui-sideline-enable t
   lsp-ui-flycheck-enable t
   lsp-lens-place-position 'above-line
  ))

;; LiveView ~L sigil highlight
;; polymode error
;; (use-package polymode
;;  :mode ("\.ex$" . poly-elixir-web-mode)
;;  :config
;;  (define-hostmode poly-elixir-hostmode :mode 'elixir-mode)
;;  (define-innermode poly-liveview-expr-elixir-innermode
;;    :mode 'web-mode
;;    :head-matcher (rx line-start (* space) "~H" (= 3 (char "\"'")) line-end)
;;    :tail-matcher (rx line-start (* space) (= 3 (char "\"'")) line-end)
;;    :head-mode 'host
;;    :tail-mode 'host
;;    :allow-nested nil
;;    :keep-in-mode 'host
;;    :fallback-mode 'host)
;;  (define-polymode poly-elixir-web-mode
;;    :hostmode 'poly-elixir-hostmode
;;    :innermodes '(poly-liveview-expr-elixir-innermode))
;;  )
(setq web-mode-engines-alist '(("elixir" . "\\.html\\.ex\\'")))
(setq web-mode-engines-alist '(("surface" . "\\.sface\\'")))
(add-to-list 'auto-mode-alist '("\\.ex\\'" . elixir-mode))
;; (add-to-list 'auto-mode-alist '("\\.heex\\'" . elixir-mode))
;; (add-to-list 'auto-mode-alist '("\\.sface\\'" . elixir-mode))

(add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
(add-hook 'web-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))

;; ----------------------------------------------------------
;; 05 web
;; ----------------------------------------------------------
(use-package web-mode
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(use-package! prettier-js
  :hook
  (js2-mode . prettier-js-mode)
  (typescript-mode . prettier-js-mode)
  (typescript-tsx-mode . prettier-js-mode)
  )

;; class="" 에서 auto complete 지원하고 싶다.
(with-eval-after-load 'company-etags '(progn (add-to-list 'company-etags-modes 'web-mode)))
(setq company-etags-everywhere '(html-mode web-mode nxml-mode))
(set-company-backend! 'web-mode '(
                                  :separate
                                  company-web-html
                                  company-etags
                                  company-css
                                  company-dabbrev-code
                                  company-yasnippet))

;; hook 동작하지 않아서 global로 설정
;; (add-hook 'typescript-tsx-mode-hook (lambda () setq-local emmet-expand-jsx-className? t))
(setq emmet-expand-jsx-className? t)
