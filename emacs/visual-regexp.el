(defvar emacs-root
  (eval-when-compile
    '((require 'visual-regexp-steroids))))

;; 'python, 'pcre2el, or 'emacs
(setq vr/engine 'python)

;; multiple-cursors ( https://github.com/magnars/multiple-cursors.el )
;; を使っている場合
(global-set-key (kbd "C-c m") 'vr/mc-mark)
;; 普段の 'query-replace-regexp を visual-regexp に
;(define-key global-map (kbd "C-x C-r") 'vr/query-replace)
