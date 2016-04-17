;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-
;; fundamental ----- 雑多な設定
;; package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;;
;; encoding
;;______________________________________________________________________

(set-language-environment               "Japanese")
(set-default-coding-systems             'utf-8)
(cond ((string-match "apple" (emacs-version))
       (require 'ucs-normalize)
       (set-file-name-coding-system     'utf-8-hfs)
       (setq locale-coding-system '     utf-8-hfs))
      ((string-match "linux" (emacs-version))
       (set-file-name-coding-system     'utf-8)
       (setq locale-coding-system       'utf-8))
      )
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system          'utf-8)
(set-terminal-coding-system             'utf-8)
(set-keyboard-coding-system             'utf-8)
(set-clipboard-coding-system            'utf-8)
(prefer-coding-system                   'utf-8)

;;
;; key bind & behavior
;;______________________________________________________________________

;; key bindings
(global-set-key "\C-z" 'undo)
(global-unset-key "\M-z")
(global-unset-key "\M-c")
;; C-k １回で行全体を削除する
(setq kill-whole-line t)
;;改行時に自動でインデントする
(global-set-key "\C-m" 'newline-and-indent)
;; 最終行に必ず一行挿入する
(setq require-final-newline t)
;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)
;; タブ幅4
(setq-default tab-width 4
              indent-tabs-mode t)
;; 問い合せには y か n で返答
(fset 'yes-or-no-p 'y-or-n-p)
;; 括弧などを補完する
;(electric-pair-mode t)
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; 起動時の画面はいらない
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; 複数ウィンドウを禁止する
(setq ns-pop-up-frames nil)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;;file名の補完で大文字小文字を区別しない
(setq completion-ignore-case t)
;; 最近使ったファイルをメニューに表示
(recentf-mode t)
;; 最近使ったファイルの表示数
(setq recentf-max-menu-items 10)
;; 最近開いたファイルの保存数を増やす
(setq recentf-max-saved-items 3000)
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 1行づつスクロールする
(setq scroll-conservatively 1000)
(setq scroll-step 1)
(setq scroll-margin 2)
;; 選択範囲をハイライト
(transient-mark-mode t)
;; 対応する括弧をハイライト
(show-paren-mode t)
;; 括弧のハイライトの設定。
(setq show-paren-style 'mixed)
(setq show-paren-delay 0.1)
(set-face-background 'show-paren-match "#c0c4fc")
;;同名のファイルのバッファ名を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; C-x C-b でバッファリストを開く時に、ウィンドウを分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)
;; 
(setq resize-mini-windows 0)

;;
;; white space mode
;;______________________________________________________________________

(require 'whitespace)
;; space-markとtab-mark、それからspacesとtrailingを対象とする
(setq whitespace-style '(space-mark face spaces trailing))
;;(setq whitespace-style '(space-mark tab-mark face spaces trailing))
(setq whitespace-display-mappings
      '(
        ;; (space-mark   ?\     [?\u00B7]     [?.]) ; space - centered dot
        (space-mark ?\xA0  [?\u00A4]     [?_]) ; hard space - currency
        (space-mark ?\x8A0 [?\x8A4]      [?_]) ; hard space - currency
        (space-mark ?\x920 [?\x924]      [?_]) ; hard space - currency
        (space-mark ?\xE20 [?\xE24]      [?_]) ; hard space - currency
        (space-mark ?\xF20 [?\xF24]      [?_]) ; hard space - currency
        (space-mark ?\u3000 [?\u25a1] [?_ ?_]) ; full-width-space - square
        ;; NEWLINE is displayed using the face `whitespace-newline'
        ;; (newline-mark ?\n    [?$ ?\n])  ; eol - dollar sign
        ;; (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n])	; eol - downwards arrow
        ;; (newline-mark ?\n    [?\u00B6 ?\n] [?$ ?\n])	; eol - pilcrow
        ;; (newline-mark ?\n    [?\x8AF ?\n]  [?$ ?\n])	; eol - overscore
        ;; (newline-mark ?\n    [?\x8AC ?\n]  [?$ ?\n])	; eol - negation
        ;; (newline-mark ?\n    [?\x8B0 ?\n]  [?$ ?\n])	; eol - grade
        ;;
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t]) ; tab - left quote mark
        ))
;; whitespace-spaceの定義を全角スペースにし、色をつけて目立たせる
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-space "#2e6cbe")
(set-face-background 'whitespace-space 'nil)
;; whitespace-trailingを色つきアンダーラインで目立たせる
(set-face-underline  'whitespace-trailing t)
(set-face-foreground 'whitespace-trailing "#2e6cbe")
(set-face-background 'whitespace-trailing 'nil)
(global-whitespace-mode 1)


;;
;; open file as root
;;______________________________________________________________________

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))
