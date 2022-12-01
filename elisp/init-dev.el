;;; init-dev -- Initialize generic development utilities
;;; Commentary:
;;; -
;;; Code:

(use-package aggressive-indent
  :ensure t
  :init
  (global-aggressive-indent-mode 1)
  ;; maybe
                                        ; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

(use-package eglot
  :ensure t)


(provide 'init-dev)

;;; init-dev ends here
