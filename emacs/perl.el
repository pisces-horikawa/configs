;; -*- mode: emacs-lisp; coding: utf-8-emacs; -*-

(defalias 'perl-mode 'cperl-mode)

(setq auto-mode-alist
	  (append
	   '(("\\.psgi$" . cperl-mode))
	   '(("\\.cgi$"  . cperl-mode))
	   '(("\\.pl$"   . cperl-mode))
	   '(("\\.pm$"   . cperl-mode))
	   '(("\\.t$"    . cperl-mode))
	   auto-mode-alist))

;; Perl デバッガの設定
(autoload 'perl-debug "perl-debug" nil t)
(autoload 'perl-debug-lint "perl-debug" nil t)

(defun perl-eval (beg end)
  (interactive "r")
  (save-excursion
    (shell-command-on-region beg end "perl")))
(add-hook 'cperl-mode-hook
          '(lambda ()
			 (define-key cperl-mode-map "\C-cp" 'perl-eval)))

;; perl-completion
(add-hook 'cperl-mode-hook
		  (lambda ()
			(require 'perl-completion)
			(add-to-list 'ac-sources 'ac-source-perl-completion)))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq cperl-close-paren-offset -4)
             (setq cperl-continued-statement-offset 4)
             (setq cperl-indent-level 4)
             (setq cperl-indent-parens-as-block t)
             (setq cperl-tab-always-indent t)
             (custom-set-variables '(cperl-indent-subs-specially nil))
			 (define-key cperl-mode-map "\C-cp" 'perl-eval)
             (define-key cperl-mode-map [(super T)] 'run-perl-test)
             (define-key cperl-mode-map [(super t)] 'run-perl-method-test)
             (define-key global-map (kbd "M-p") 'cperl-perldoc)
             (local-set-key (kbd "C-c C-c C-u") 'popup-editor-perl-use)
             (font-lock-add-keywords
              'cperl-mode
              '(
                ("!" . font-lock-warning-face)
                (":" . font-lock-warning-face)
                ("TODO" 0 'font-lock-warning-face)
                ("XXX" 0 'font-lock-warning-face)
                ("Hatean" 0 'font-lock-warning-face)
                ))
             ))

(custom-set-faces
 '(cperl-array-face (
					 (((class color) (background light))
					  (:foreground "Blue" :weight normal))))
 '(cperl-hash-face  (
					 (((class color) (background light))
					  (:foreground "Red" :slant italic :weight normal)))))

(add-hook 'cperl-mode-hook 'flycheck-mode)
;(with-eval-after-load "flycheck"
;  (flycheck-define-checker
;	  perl-project-libs
;	"A perl syntax checker."
;	:command ("perl" "-MProject::Libs" "-wc" source-inplace)
;	:error-patterns ((error line-start
;							(minimal-match (message))
;							" at " (file-name) " line " line
;							(or "." (and ", " (zero-or-more not-newline)))
;							line-end))
;	:modes (cperl-mode)))
;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (unless (or (and (fboundp 'tramp-tramp-file-p)
;                             (tramp-tramp-file-p buffer-file-name))
;                        (string-match "sudo:.*:" (buffer-file-name)))
;              (progn
;                (flycheck-mode t)
;                (setq flycheck-checker 'perl-project-libs)))))

;; ソースを見る
(put 'perl-module-thing 'end-op
     (lambda ()
       (re-search-forward "\\=[a-zA-Z][a-zA-Z0-9_:]*" nil t)))
(put 'perl-module-thing 'beginning-op
     (lambda ()
       (if (re-search-backward "[^a-zA-Z0-9_:]" nil t)
           (forward-char)
         (goto-char (point-min)))))
(defun perldoc-m ()
  (interactive)
  (let ((module (thing-at-point 'perl-module-thing))
        (pop-up-windows t)
        (cperl-mode-hook nil))
    (when (string= module "")
      (setq module (read-string "Module Name: ")))
    (let ((result (substring (shell-command-to-string (concat "perldoc -m " module)) 0 -1))
          (buffer (get-buffer-create (concat "*Perl " module "*")))
          (pop-or-set-flag (string-match "*Perl " (buffer-name))))
      (if (string-match "No module found for" result)
          (message "%s" result)
        (progn
          (with-current-buffer buffer
            (toggle-read-only -1)
            (erase-buffer)
            (insert result)
            (goto-char (point-min))
            (cperl-mode)
            (toggle-read-only 1)
            )
          (if pop-or-set-flag
              (switch-to-buffer buffer)
            (display-buffer buffer)))))))
