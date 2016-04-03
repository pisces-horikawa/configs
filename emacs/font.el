;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

;;(create-fontset-from-ascii-font "Source Han Code JP-13:weight=light:slant=normal" nil "hancode")
;;(set-fontset-font "fontset-hancode" 'unicode (font-spec :family "Source Han Code JP Light" :size 12) nil 'append)
;;(add-to-list 'default-frame-alist '(font . "fontset-hancode"))


;;Ricty Font
;;(add-to-list 'default-frame-alist '(font . "ricty-15"))

;; Ricty Discord 160
(set-face-attribute 'default nil
                    :family "Ricty"
                    :height 160)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty" "iso10646-1"))

;(set-face-attribute 'default nil :family "Source Han Code JP Regular" :height 150)
;(set-fontset-font
; (frame-parameter nil 'font)
; 'japanese-jisx0208
; '("Source Han Code JP Regular" . "iso10646-*"))
