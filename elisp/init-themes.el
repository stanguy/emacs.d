;;; init-themes -- Initialize themes
;;; Commentary:
;;; -
;;; Code:

(use-package pastelmac-theme
  :disabled t
  :ensure t
  :config (load-theme 'pastelmac t))

(use-package poet-theme
  :ensure t
  :config
  (load-theme 'poet t)
  (set-face-attribute 'default nil :family "Inconsolata" :height 120)
  (set-face-attribute 'fixed-pitch nil :family "Inconsolata")
  (set-face-attribute 'variable-pitch nil :family "Baskerville")
  )

(provide 'init-themes)

;;; init-themes ends here

