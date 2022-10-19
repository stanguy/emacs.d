;;; init-git -- Initialize git related packages
;;; Commentary:
;;; -
;;; Code:

(use-package magit
  :ensure t
  :defer 2
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine            ; Go back in Git time
  :ensure t
  :bind (("C-c g t" . git-timemachine)))

(use-package git-gutter
  :ensure t
  :defer 2
  :diminish git-gutter-mode
  :config
  (global-git-gutter-mode t)
  (setq git-gutter:modified-sign " "
	git-gutter:added-sign " "
	git-gutter:deleted-sign " ")
  (set-face-background 'git-gutter:modified "purple") ;; background color
  (set-face-background 'git-gutter:added "SeaGreen")
  (set-face-background 'git-gutter:deleted "firebrick4"))


(provide 'init-git)

;;; init-git ends here
