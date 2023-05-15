;;; init-themes -- Initialize themes
;;; Commentary:
;;; -
;;; Code:

(defun set-local-face()
  (set-face-attribute 'default nil :family "Inconsolata" :height 120)
  (set-face-attribute 'fixed-pitch nil :family "Inconsolata")
  (set-face-attribute 'variable-pitch nil :family "Baskerville")
  )

(use-package pastelmac-theme
  :disabled
  :config
  (load-theme 'pastelmac t)
  (set-local-face)
  )

(use-package inkpot-theme
  :config
  (load-theme 'inkpot t)
  (set-local-face)
  )

(use-package poet-theme
  :disabled
  :config
  (load-theme 'poet t)
  (set-local-face)
  )

(use-package eziam-themes
  :disabled
  :config
  (load-theme 'eziam-dusk t)
  (set-local-face)
  )

(provide 'init-themes)

;;; init-themes ends here

