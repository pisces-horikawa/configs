;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

(tool-bar-mode 0)     ;; without tool bar
(menu-bar-mode 1)     ;; with menu bar
(blink-cursor-mode 0) ;; stop blink cursor

;;
;; hilight current line
;;______________________________________________________________________

;; define background color
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

(set-scroll-bar-mode 'left)  ;; bug? nil にすると1行目が消える
(fringe-mode (cons 0 nil))   ;; fringe left 0, right nil

;;
;; line number display
;;______________________________________________________________________

(global-linum-mode t)
(setq linum-format "%04d")
(set-face-attribute 'linum nil
                    :foreground "#F1F3F1"
					:background "#B6B8B6"
                    :height 0.9)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;;
;; mode line
;;______________________________________________________________________

;; EOL format
(setq eol-mnemonic-dos  "(DS)")
(setq eol-mnemonic-mac  "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; Mode line setup
(setq-default
 mode-line-format
 '(;; Position, including warning for 80 columns
   (:propertize "%4l:" face mode-line-position-face)
   (:eval (propertize "%3c" 'face
                      (if (>= (current-column) 80)
						  'mode-line-80col-face
						'mode-line-position-face)))
   ;; emacsclient [default -- keep?]
   mode-line-client
   "  "
   ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
   ;; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " %%%% " 'face 'mode-line-modified-face))
          (t " -- ")))
   ;; EOL format
   (:propertize " %Z "
                face mode-line-eol-face)
   ;; narrow [default -- keep?]
   " %n "
   ;;mode indicators: vc, recursive edit, major mode, minor modes, process, global
   (vc-mode vc-mode)
   " %["
   (:propertize mode-name
                face mode-line-mode-face)
   "%] "
   (:eval (propertize (format-mode-line minor-mode-alist)
                      'face 'mode-line-minor-mode-face))
   (:propertize mode-line-process
                face mode-line-process-face)
   (global-mode-string global-mode-string)
   "    "
   ))
;; Helper function
(defun shorten-directory (dir max-length)
  "Show up to `max-length' characters of a directory name `dir'."
  (let ((path (reverse (split-string (abbreviate-file-name dir) "/")))
        (output ""))
    (when (and path (equal "" (car path)))
      (setq path (cdr path)))
    (while (and path (< (length output) (- max-length 4)))
      (setq output (concat (car path) "/" output))
      (setq path (cdr path)))
    (when path
      (setq output (concat ".../" output)))
    output))

;; Extra mode line faces
(make-face 'mode-line-read-only-face)
(make-face 'mode-line-modified-face)
(make-face 'mode-line-folder-face)
(make-face 'mode-line-filename-face)
(make-face 'mode-line-position-face)
(make-face 'mode-line-eol-face)
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
					:foreground "#434643" :background "#B6B8B6"
					:inverse-video nil)
(set-face-attribute 'mode-line-inactive nil
    :foreground "#434643" :background "#F1F3F1"
    :inverse-video nil)
(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#31ac31")
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#CC5151"
    :background "#C6C8C6")
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "#434643")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#934643"
    :slant 'italic)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo" :height 100)
(set-face-attribute 'mode-line-eol-face nil
    :inherit 'mode-line-face
    :family "Menlo" :height 120)
(set-face-attribute 'mode-line-mode-face nil
    :inherit 'mode-line-face
    :foreground "#434643")
(set-face-attribute 'mode-line-minor-mode-face nil
    :inherit 'mode-line-mode-face
    :foreground "#434643"
    :height 110)
(set-face-attribute 'mode-line-process-face nil
    :inherit 'mode-line-face
    :foreground "#434643")
(set-face-attribute 'mode-line-80col-face nil
    :inherit 'mode-line-position-face
    :foreground "#434643" :background "#eab700")

;;
;; frames default
;;______________________________________________________________________

(if window-system
    (setq default-frame-alist
	  (append (list
		   '(top          . 0)
		   '(left         . 2)
		   '(width        . 87)  ;; 113
		   '(height       . 51)  ;;  64
		   '(line-spacing . 2)
		   '(foreground-color                    . "#191719")
		   '(background-color                    . "#F1F3F1")
		   '(cursor-color                        . "SlateBlue3")
		   '(region                              . "#bfefff")
		   '(mode-line-foreground-color          . "#fafafa")
		   '(mode-line-background-color          . "#9fb6cd")
		   '(mode-line-inactive-foreground-color . "#fafafa")
		   '(mode-line-inactive-background-color . "#c1cdcf")
		   '(alpha . (0.98 0.98))
		   )
		  default-frame-alist)
	  )
  )
(set-face-foreground 'font-lock-comment-delimiter-face "#bbb85a")
(set-face-foreground 'font-lock-comment-face           "#888888")
(set-face-foreground 'font-lock-string-face            "#8b7765")
(set-face-foreground 'font-lock-function-name-face     "#8F7FFF")
(set-face-foreground 'font-lock-keyword-face           "#FF7F7F")
(set-face-foreground 'font-lock-constant-face          "#A26318")
(set-face-foreground 'font-lock-variable-name-face     "#7F7FFF")
(set-face-foreground 'font-lock-type-face              "#5F4FCF")
(set-face-foreground 'fringe                           "#282828")
(set-face-background 'fringe                           "#D1D3D1")

(provide 'frames.el)
