;;
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist (append '(("\\.psgi$" . cperl-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.cgi$" . cperl-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.pl$" . cperl-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.pm$" . cperl-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.t$" . cperl-mode)) auto-mode-alist))

;; tab width
(setq cperl-indent-level 4)

(add-hook 'cperl-mode-hook
          '(lambda ()
             ;; インデント設定
             (cperl-set-style "PerlStyle")
             (custom-set-variables
              '(cperl-indent-parens-as-block t)
              '(cperl-close-paren-offset -4)
              '(cperl-indent-subs-specially nil))
             ;; ドキュメントを表示する
             (define-key global-map (kbd "M-p") 'cperl-perldoc)
             ))

;;; ソースを見る
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

(global-set-key (kbd "M-m") 'perldoc-m)

;; perl-completion
(add-hook 'cperl-mode-hook
          (lambda()
            (require 'perl-completion)
            (perl-completion-mode t)))

;(add-hook  'cperl-mode-hook
;           (lambda ()
;             (when (require 'auto-complete nil t)
;               (auto-complete-mode t)
;               (make-variable-buffer-local 'ac-sources)
;               (setq ac-sources
;                     '(ac-source-perl-completion)))))

;(with-eval-after-load "flycheck"
;  (flycheck-define-checker
;   perl-project-libs
;   "A perl syntax checker."
;   :command ("perl" "-MProject::Libs" "-wc" source-inplace)
;   :error-patterns ((error line-start
;                           (minimal-match (message))
;                           " at " (file-name) " line " line
;                           (or "." (and ", " (zero-or-more not-newline)))
;                           line-end))
;   :modes (cperl-mode)))
;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (unless (or (and (fboundp 'tramp-tramp-file-p)
;                             (tramp-tramp-file-p buffer-file-name))
;                        (string-match "sudo:.*:" (buffer-file-name)))
;              (progn
;                (flycheck-mode t)
;                (setq flycheck-checker 'perl-project-libs)))))
