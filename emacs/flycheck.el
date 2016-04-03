;;; Flycheck --- settings:
(require 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

;(flycheck-define-checker perl-project-libs
;  "A perl syntax checker."
;  :command ("perl"
;            "-MProject::Libs lib_dirs => [qw(local/lib/perl5)]"
;            "-wc"
;            source-inplace)
;  :error-patterns ((error line-start
;                          (minimal-match (message))
;                          " at " (file-name) " line " line
;                          (or "." (and ", " (zero-or-more not-newline)))
;                          line-end))
;  :modes (cperl-mode))

;(add-hook 'cperl-mode-hook
;	  (lambda ()
;	    (flycheck-mode t)
;            (setq flycheck-checker 'perl-project-libs)))
