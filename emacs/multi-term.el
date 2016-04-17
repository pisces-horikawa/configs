;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

(require 'multi-term)
(global-set-key "\C-xm" 'multi-term)
(setq multi-term-program "/bin/zsh")
;(setenv "TERMINFO" "~/.terminfo")

(setq multi-term-program shell-file-name)

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(dolist (dir (list
              "/sbin"
              "/usr/sbin"
              "/bin"
              "/usr/bin"
              "/usr/local/bin"
              "/Users/pisces/.nvm/versions/node/v0.12.13/bin"
              ))
  ;; PATH と exec-path に同じ物を追加します
  (when (and (file-exists-p dir) (not (member dir exec-path)))
	(setenv "PATH" (concat dir ":" (getenv "PATH")))
	(setq exec-path (append (list dir) exec-path))))
