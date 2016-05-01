(require 'multiple-cursors)
(require 'smartrep)

(global-set-key (kbd "<C-M-return>") 'mc/edit-lines)
(smartrep-define-key
 global-map "C-." '(("C-n" . 'mc/mark-next-like-this)
                    ("C-p" . 'mc/mark-previous-like-this)
                    ("*"   . 'mc/mark-all-like-this)
					("C-d" . 'mc/mark-all-like-this-dwim)
					("C-u" . 'mc/unmark-next-like-this)
					("C-U" . 'mc/unmark-previous-like-this)
					("C-s" . 'mc/skip-to-next-like-this)
					("C-S" . 'mc/skip-to-previous-like-this)))
