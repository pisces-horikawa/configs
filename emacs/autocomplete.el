;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

(require 'auto-complete)
(require 'auto-complete-config)
;; グローバルでauto-completeを利用
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "M-n") 'ac-next)      ; M-nで次候補選択
(define-key ac-completing-map (kbd "M-p") 'ac-previous)  ; M-pで前候補選択
(setq ac-dwim t)  ; 空気読んでほしい
;; 情報源として
;; * ac-source-filename
;; * ac-source-words-in-same-mode-buffers
;; を利用
(setq-default ac-sources '(ac-source-filename ac-source-words-in-same-mode-buffers))
;; また、Emacs Lispモードではac-source-symbolsを追加で利用
(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(add-to-list 'ac-sources 'ac-source-symbols t)))
;; 以下、自動で補完する人用
(setq ac-auto-start 3)
;; 以下、手動で補完する人用
;(setq ac-auto-start nil)
;(ac-set-trigger-key "TAB")  ; TABで補完開始(トリガーキー)
;; or
;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)  ; M-TABで補完開始

