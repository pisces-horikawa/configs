;; Javascript environment

;; js2-mode setting
(autoload 'js2-mode "js2-mode" nil t)
(setq auto-mode-alist (append '(("\\.js$" . js2-mode)) auto-mode-alist))
(setq auto-mode-alist (append '(("\\.jsx$" . js2-mode)) auto-mode-alist))
