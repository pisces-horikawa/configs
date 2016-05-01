;; ------------------------------------------------------------------------
;; @anzu

(require 'anzu)
(global-anzu-mode +1)
(custom-set-variables
 '(anzu-mode-lighter "")
 '(setq anzu-use-migemo nil)
 '(anzu-deactivate-region t)
 '(anzu-search-threshold 200)
 '(anzu-replace-threshold 50)
 '(anzu-minimum-input-length 3)
 '(anzu-replace-to-string-separator " => "))

(set-face-attribute 'anzu-mode-line nil
                    :foreground "brown" :weight 'normal :height 140)

(global-set-key "\C-c\C-r" 'anzu-replace-at-cursor-thing)
(global-set-key [remap query-replace]        'anzu-query-replace)
(global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
