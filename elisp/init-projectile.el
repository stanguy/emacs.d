;;; init-projectile -- Initialize projectile
;;; Commentary:
;;; -
;;; Code:


(use-package projectile
  :ensure t
  :bind-keymap ("C-c p" . projectile-command-map)
  :diminish projectile-mode
  :config
  (projectile-mode)
  (setq projectile-enable-caching t
	projectile-project-compilation-cmd "")
;  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )


(provide 'init-projectile)

;;; init-projectile ends here
