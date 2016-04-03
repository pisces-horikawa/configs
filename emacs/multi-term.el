(require 'multi-term)
(setq multi-term-program shell-file-name)

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

