;;; init-web -- Initialize web related modes
;;; Commentary:
;;; -
;;; Code:

(use-package web-mode
  :ensure t
  :mode (("\\.erb\\'" . web-mode)
	 ("\\.mustache\\'" . web-mode)
	 ("\\.html?\\'" . web-mode)
         ("\\.php\\'" . web-mode)
         ("\\.tsx\\'" . typescript-mode))
  :config (progn
            (setq web-mode-markup-indent-offset 2
		  web-mode-css-indent-offset 2
		  web-mode-code-indent-offset 2))
  :init
  (setq web-mode-enable-current-element-highlight t)
  )

;; JavaScript and TypeScript
(use-package js2-mode
  :ensure t
  :custom
  (js2-strict-missing-semi-warning nil)
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))


(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-formater-before-save)))

(use-package vue-mode
  :mode "\\.vue\\'"
  :ensure t
  )

(use-package rainbow-mode               ; Fontify color values in code
  :ensure t
  :bind (("C-c t r" . rainbow-mode))
  :config (add-hook 'css-mode-hook #'rainbow-mode))


(provide 'init-web)

;;; init-web ends here
