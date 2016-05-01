(setq default-input-method "MacOSX")

(setq auto-mode-alist
	  (append
	   '(("\\.plist$" . xml-mode))
	   auto-mode-alist))

;; emacs 起動時は英数モードから始める
;(add-hook 'after-init-hook 'mac-change-language-to-us)
;; minibuffer 内は英数モードにする
;(add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
