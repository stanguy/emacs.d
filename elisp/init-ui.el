;;; init-ui -- UI interface configuration
;;; Commentary:
;;; -
;;; Code:


(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode 1)
  :config
  (defalias 'redo 'undo-tree-redo)
  (setq undo-tree-auto-save-history nil)
  :bind (("C-z" . undo)     ; Zap to character isn't helpful
         ("C-S-z" . redo)))

(cond
 ((version<= "25.2" emacs-version)
  (use-package treemacs
    :ensure t
    :commands treemacs))
 ((version<= emacs-version "25.2")
  (use-package neotree
    :ensure t
    :bind (("C-c f t" . neotree-toggle))
    :config (validate-setq neo-window-width 32
			   neo-create-file-auto-open t
			   neo-banner-message nil
			   neo-show-updir-line nil
			   neo-mode-line-type 'neotree
			   neo-smart-open t
			   neo-dont-be-alone t
			   neo-persist-show nil
			   neo-show-hidden-files t
			   neo-auto-indent-point t))))
  
(use-package olivetti
  :ensure t
  :defer 12
  :commands olivetti-mode)

; folding
(use-package origami
  :ensure t
  :defer 10
  :commands origami-mode)

(use-package popwin
  :ensure t
  :config
  (popwin-mode 1)
  (setq popwin:popup-window-height 35
        popwin:special-display-config
        '(("*Miniedit Help*" :noselect t)
          (help-mode :noselect nil)
          (completion-list-mode :noselect t)
          (compilation-mode :noselect nil)
          (grep-mode :noselect t)
          (occur-mode :noselect t)
          ("*Pp Macroexpand Output*" :noselect t)
          ("*Shell Command Output*")
          ("*Async Shell Command*")
          ("*vc-diff*")
          ("*vc-change-log*")
          (" *undo-tree*" :width 60 :position right)
          ("^\\*anything.*\\*$" :regexp t)
          ("*slime-apropos*")
          ("*slime-macroexpansion*")
          ("*slime-description*")
          ("*slime-compilation*" :noselect t)
          ("*slime-xref*")
          ("*Flycheck errors*")
          ("*Warnings*")
          ("*Error*")
          ("*Process List*")
          ("*Smex: Unbound Commands*")
          ("*Paradox Report*" :noselect nil)
          ("*Package Commit List*" :noselect nil)
          ("*Diff*" :noselect nil)
          ("*Messages*" :noselect nil)
          ("*ag search*" :noselect nil)
          ("*PDF-Occur*" :noselect nil)
          ("*PDF-Metadata*" :noselect nil)
          ("^\\*Outline .*\\.pdf\\*$" :regexp t :noselect nil)
          ("*MULTI-TERM-DEDICATED*" :noselect nil :stick t)
          (sldb-mode :stick t)
          (slime-repl-mode)
          (slime-connection-list-mode)))

  (bind-keys :map popwin:window-map
             ((kbd "<escape>") . popwin:close-popup-window)))

(use-package cheatsheet
  :ensure t
  :defer 12
  :config
  (cheatsheet-add-group 'helm
			'(:key "M-t" :description "Projectile Ag w/ Helm")
			'(:key "C-z" :description "Select directory (in find-files)")
			'(:key "C-l" :description "Go directory up (in find-files)")
			)
  (cheatsheet-add-group 'Navigation
			'(:key "C-." :description "Avy jump")
			)
  (cheatsheet-add-group 'Cheatsheet '(:key "C-q" :description "Exit ;)"))
  (cheatsheet-add-group 'Magit
                        '(:key "E r" :description "Ediff compare")
                        '(:key "C-x g" :description "Status"))
  )

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key [(control f3)] 'highlight-symbol-at-point)

(when (eq window-system 'x)
  (set-frame-font "Inconsolata-12")
  )

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(setq-default cursor-type 'bar)
(delete-selection-mode 1)
(windmove-default-keybindings 'meta)


(provide 'init-ui)

;;; init-ui ends here
