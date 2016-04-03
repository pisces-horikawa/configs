;;(require 'auto-complete-config)
;;(ac-config-default)
;;(add-to-list 'ac-modes 'cperl-mode)
;;(add-to-list 'ac-modes 'js2-mode)
;;(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
;;(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
;;(add-to-list 'ac-modes 'org-mode)
;;(add-to-list 'ac-modes 'yatex-mode)
;;(ac-set-trigger-key "TAB")
;;(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
;;(setq ac-use-fuzzy t)          ;; 曖昧マッチ


(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
               "~/.emacs.d/auto-complete")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))
