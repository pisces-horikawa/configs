(deftheme Pisces
  "Pisces color theme")
(custom-theme-set-faces
 'pisces
 ;; 背景・文字・カーソル
 '(cursor ((t (:foreground "#484840"))))
 '(default ((t (:background "#1B1D1E" :foreground "#F8F8F2"))))
 ;; 選択範囲
 '(region ((t (:background "#403D3D"))))
 ;; モードライン
 '(mode-line ((t (:foreground "#6665BA" :background "#C8C6D3"
							  :box (:line-width 1 :color "#444444" :style released-button)))))
 '(mode-line-buffer-id ((t (:foreground nil :background nil))))
 '(mode-line-inactive ((t (:foreground "#BCBCBC" :background "#333333"
									   :box (:line-width 1 :color "#333333")))))
 ;; ハイライト
 '(highlight ((t (:foreground "#000000" :background "#C4BE89"))))
 '(hl-line ((t (:background "#4FACAF"))))
 ;; 関数名
 '(font-lock-function-name-face ((t (:foreground "#FFFFFF"))))
 ;; 変数名・変数の内容
 '(font-lock-variable-name-face ((t (:foreground "#FFFFFF"))))
 '(font-lock-string-face ((t (:foreground "#E6DB74"))))
 ;; 特定キーワード
 '(font-lock-keyword-face ((t (:foreground "#F92672"))))
 ;; Boolean
 '(font-lock-constant-face((t (:foreground "#AE81BC"))))
 ;; 括弧
 '(show-paren-match-face ((t (:foreground "#1B1D1E" :background "#FD971F"))))
 '(paren-face ((t (:foreground "#A6E22A" :background nil))))
 ;; コメント
 '(font-lock-comment-face ((t (:foreground "#74715D"))))
 ;; CSS
 '(css-selector ((t (:foreground "#66D9EF"))))
 '(css-property ((t (:foreground "#FD971F"))))
 ;; nXML-mode
 ;; タグ名
 '(nxml-element-local-name ((t (:foreground "#F92672"))))
 ;; 属性
 '(nxml-attribute-local-name ((t (:foreground "#66D9EF"))))
 ;; 括弧
 '(nxml-tag-delimiter ((t (:foreground "#A6E22A"))))
 ;; DOCTYPE宣言
 '(nxml-markup-declaration-delimiter ((t (:foreground "#74715D"))))
 ;; dired
 '(dired-directory ((t (:foreground "#A6E22A"))))
 '(dired-symlink ((t (:foreground "#66D9EF"))))
 ;; MMM-mode
 '(mmm-default-submode-face ((t (:foreground nil :background "#000000")))))
										;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))
(provide-theme 'pisces)
(load-theme 'pisces t)
(enable-theme 'pisces)

