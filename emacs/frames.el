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

;(line-number-mode t)
;(column-number-mode t)
;(set-face-attribute 'mode-line nil  :height 140)
;
;;; 改行コードを表示する
;(setq eol-mnemonic-dos  "(CRLF)")
;(setq eol-mnemonic-mac  "(CR)")
;(setq eol-mnemonic-unix "(LF)")
;;; モードラインの割合表示を総行数表示
;(defvar my-lines-page-mode t)
;(defvar my-mode-line-format)
;;; display full length path
;;(set-default 'mode-line-buffer-identification
;;             '(buffer-file-name ("%f") ("%b")))
;(defvar mode-line-buffer-fullpath
;  (list 'buffer-file-name
;        (propertized-buffer-identification "%12f")
;        (propertized-buffer-identification "%12b")))
;
;(add-hook 'dired-mode-hook
;          (lambda ()
;            ;; TODO: handle (DIRECTORY FILE ...) list value for dired-directory
;            (setq mode-line-buffer-identification
;                  ;; emulate "%17b" (see dired-mode):
;                  '(:eval
;                    (propertized-buffer-identification
;                     (if (< (length default-directory) 17)
;                         (concat default-directory
;                                 (make-string (- 17 (length default-directory))
;                                              ?\s))
;                       default-directory))))))
;
;(setq  mode-line-buffer-default mode-line-buffer-identification)
;
;(defun show-mode-line-fullpath (event)
;  (interactive "e")
;  (when (buffer-file-name)
;    (select-window (posn-window (event-start event))) ; activate window
;    (let ((wait-sec 5))
;      (setq mode-line-buffer-identification mode-line-buffer-fullpath)
;      (force-mode-line-update)
;      ;(my-copy-buffer-file-name)                      ; copy path string to killring
;      (sit-for wait-sec)
;      (setq mode-line-buffer-identification mode-line-buffer-default)
;      (force-mode-line-update)
;      (message ""))))
;
;(define-key mode-line-buffer-identification-keymap [mode-line mouse-1] 'show-mode-line-fullpath) ; left click
;(set-face-attribute 'mode-line-highlight nil :box nil) ; remove box when hover mouse
;
;(defun my-copy-buffer-file-name ()
;  "copy buffer-file-name to kill-ring."
;  (interactive)
;  (let ((fn (unwind-protect
;                (buffer-file-name)
;              nil)))
;    (if fn
;        (let ((f (abbreviate-file-name (expand-file-name fn))))
;          (kill-new f)
;          (message "copied: \"%s\"" f))
;      (message "no file name"))))
;
;(when my-lines-page-mode
;  (setq my-mode-line-format "%d")
;  (if size-indication-mode
;      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
;  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
;         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
;        ((eq line-number-mode t)
;         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
;        ((eq column-number-mode t)
;         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))
;  (setq mode-line-position
;        '(:eval (format my-mode-line-format
;                        (count-lines (point-max) (point-min))))))
;

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
   ;; read-only or modified status
   (:eval
    (cond (buffer-read-only
           (propertize " RO " 'face 'mode-line-read-only-face))
          ((buffer-modified-p)
           (propertize " %%%% " 'face 'mode-line-modified-face))
          (t " -- ")))
   ;; space
   "    "
   ;; directory and buffer/file name
   (:propertize (:eval (shorten-directory default-directory 30))
                face mode-line-folder-face)
   (:propertize "%b"
                face mode-line-filename-face)
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
   ; nyan-mode uses nyan cat as an alternative to %p
   ;(:eval (when nyan-mode (list (nyan-create))))
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
(make-face 'mode-line-mode-face)
(make-face 'mode-line-minor-mode-face)
(make-face 'mode-line-process-face)
(make-face 'mode-line-80col-face)

(set-face-attribute 'mode-line nil
					:foreground "#434643" :background "#B6B8B6"
					:inverse-video nil)
					;:box '(:line-width 6 :color "gray20" :style nil))
(set-face-attribute 'mode-line-inactive nil
    :foreground "#434643" :background "#F1F3F1";;"#B6B8B6"
    :inverse-video nil)
    ;:box '(:line-width 6 :color "gray40" :style nil))
(set-face-attribute 'mode-line-read-only-face nil
    :inherit 'mode-line-face
    :foreground "#4271ae")
    ;:box '(:line-width 2 :color "#4271ae"))
(set-face-attribute 'mode-line-modified-face nil
    :inherit 'mode-line-face
    :foreground "#f3f5f3"
    :background "#C6C8C6")
    ;:box '(:line-width 2 :color "#c82829"))
(set-face-attribute 'mode-line-folder-face nil
    :inherit 'mode-line-face
    :foreground "#434643")
(set-face-attribute 'mode-line-filename-face nil
    :inherit 'mode-line-face
    :foreground "#434643"
    :weight 'bold)
(set-face-attribute 'mode-line-position-face nil
    :inherit 'mode-line-face
    :family "Menlo" :height 100)
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
		   '(line-spacing . 3)
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
