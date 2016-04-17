;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

;; js2-mode setting
(autoload 'js2-mode "js2-mode" nil t)

(setq auto-mode-alist
	  (append
	   '(("\\.js$" . js2-mode))
	   '(("\\.jsx$" . js2-mode))
	   auto-mode-alist))
