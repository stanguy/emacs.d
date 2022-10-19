;;; init-formattedfiles -- Initialize modes for random (non-programming) formats
;;; Commentary:
;;; -
;;; Code:

(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package nxml-mode
  :config
  (setq nxml-slash-auto-complete-flag t)
  )

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode))

(provide 'init-formattedfiles)

;;; init-formattedfiles ends here
