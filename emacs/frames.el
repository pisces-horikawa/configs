;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-
;; color theme
(load-theme 'whiteboard t)

(tool-bar-mode 0)
(menu-bar-mode 1)
(blink-cursor-mode 0)

;; hilight current line
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "#eee8aa"))
    (((class color)
      (background light))
     (:background "#eee8aa"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode t)

;; turn off scroll bar
;;(scroll-bar-mode nil)
;; fringe left 0, right nil
(fringe-mode (cons 0 nil))

;; 行番号表示
(global-linum-mode t)
(setq linum-format "%04d ")
(set-face-attribute 'linum nil
                    :foreground "#F8FEF3"
					:background "#C8C6D3"
                    :height 0.95)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; mode line
(line-number-mode t)
(column-number-mode t)
(set-face-attribute 'mode-line nil  :height 140)
;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)

;;フルパスを表示
(set-default 'mode-line-buffer-identification
             '(buffer-file-name ("%f") ("%b")))
(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))
  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

(if window-system
    (setq default-frame-alist
	  (append (list
		   '(top . 0)
		   '(left . 2)
;;		   '(width . 113)
;;		   '(height . 64)
		   '(width . 87)
		   '(height . 51)
		   '(line-spacing . 3)
		   '(foreground-color . "#191719")
		   '(background-color . "#F1F3F1")
		   '(cursor-color . "SlateBlue3")
		   )
		  default-frame-alist)
	  )
  )
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
(add-to-list 'default-frame-alist '(alpha . (0.98 0.98)))
(set-face-foreground 'mode-line "#44454A")
(set-face-background 'mode-line "#C8C6D3")

;;(set-face-background 'region                           "#222244") ; リージョン
;;(set-face-foreground 'modeline                         "#CCCCCC") ; モードライン文字
;;(set-face-background 'modeline                         "#333333") ; モードライン背景
;;(set-face-foreground 'mode-line-inactive               "#333333") ; モードライン文字(非アクティブ)
;;(set-face-background 'mode-line-inactive               "#CCCCCC") ; モードライン背景(非アクティブ)
;;(set-face-foreground 'font-lock-comment-delimiter-face "#888888") ; コメントデリミタ
;;(set-face-foreground 'font-lock-comment-face           "#888888") ; コメント
;;(set-face-foreground 'font-lock-string-face            "#7FFF7F") ; 文字列
;;(set-face-foreground 'font-lock-function-name-face     "#BF7FFF") ; 関数名
;;(set-face-foreground 'font-lock-keyword-face           "#FF7F7F") ; キーワード
;;(set-face-foreground 'font-lock-constant-face          "#FFBF7F") ; 定数(this, selfなども)
;;(set-face-foreground 'font-lock-variable-name-face     "#7F7FFF") ; 変数
;;(set-face-foreground 'font-lock-type-face              "#FFFF7F") ; クラス
;;(set-face-foreground 'fringe                           "#666666") ; fringe(折り返し記号なでが出る部分)
;;(set-face-background 'fringe                           "#282828") ; fringe

