(setq default-input-method "MacOSX")

;; カーソルの色
;(mac-set-input-method-parameter `roman `cursor-color "dim gray")
;(mac-set-input-method-parameter `japanese `cursor-color "magenta")

;; emacs 起動時は英数モードから始める
;(add-hook 'after-init-hook 'mac-change-language-to-us)

;; backslash を優先
;(mac-translate-from-yen-to-backslash)

;; minibuffer 内は英数モードにする
;(add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
