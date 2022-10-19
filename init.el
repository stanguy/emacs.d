;;; init.el -- Emacs configuration
;;; Commentary:
;;; -
;;; Code:


(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(defvar file-name-handler-alist-old file-name-handler-alist)
(setq package-enable-at-startup nil
      file-name-handler-alist nil
      message-log-max 16384
      gc-cons-threshold 402653184
      gc-cons-percentage 0.6
      auto-window-vscroll nil
      inhibit-splash-screen t
      make-backup-files nil
      ring-bell-function 'ignore
      gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(setq-default
 indent-tabs-mode nil)

(add-hook 'after-init-hook
          `(lambda ()
             (setq file-name-handler-alist file-name-handler-alist-old
                   gc-cons-threshold 800000
                   gc-cons-percentage 0.1)
             (garbage-collect)) t)

;; Bootstrap `use-package'
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

; To limit clutter on the modeline
(use-package diminish :demand t :ensure t)

(use-package ido
  :config
  (setq ido-enable-flex-matching t)
  ;(ido-everywhere t)
  (ido-mode 1))

(use-package ido-grid-mode
  :ensure t
  :config
  (ido-grid-mode 1))

(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(require 'init-themes)

(use-package recentf-ext
  :ensure t
  :defer 1)

(require 'init-helm)
(require 'init-projectile)

(use-package avy
  :ensure t
  :bind*  ("C-." . avy-goto-char-timer)
  :config (avy-setup-default)
  )

(use-package beacon
  :ensure t
  :defer 10
  :diminish
  :init (beacon-mode 1)
  :commands beacon-mode)

(require 'init-ruby)

(use-package flycheck
  :ensure t
  :defer 5
  :config (progn
            (setq flycheck-shellcheck-follow-sources nil)
            (global-flycheck-mode 1)))

(require 'init-git)

(use-package smartparens
  :ensure t
  :defer 2
  :diminish smartparens-mode
  :config
  (smartparens-global-mode)
  (show-smartparens-global-mode t)
  (sp-with-modes '(rhtml-mode)
    (sp-local-pair "<" ">")
    (sp-local-pair "<%" "%>"))
  )

(use-package column-enforce-mode
  :ensure t
  :defer 12
  :bind* ("<f8>" . column-enforce-mode))

; to highlight multiple search results
(use-package anzu
  :ensure t
  :defer 6
  :diminish
  :config
  (global-anzu-mode +1)
)

(use-package subword
  :init (global-subword-mode))

(use-package company
  :ensure t
  :defer 3
  :diminish company-mode
  :init
  (dolist (hook '(emacs-lisp-mode-hook
                  c-mode-common-hook))
    (add-hook hook
              #'(lambda ()
                  (local-set-key (kbd "<tab>")
				 #'company-indent-or-complete-common))))
  :config
  (global-company-mode)
  (setq
   company-idle-delay 0.2
   company-minimum-prefix-length 1
   company-require-match nil
   company-dabbrev-code-ignore-case nil
   company-dabbrev-downcase nil
   )
  )

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

(use-package origami
  :ensure t
  :defer 10
  :commands origami-mode)

(use-package yasnippet
  :ensure t
  :demand t
  :diminish yas-minor-mode
  :bind (("C-c y d" . yas-load-directory)
         ("C-c y i" . yas-insert-snippet)
         ("C-c y f" . yas-visit-snippet-file)
         ("C-c y n" . yas-new-snippet)
         ("C-c y t" . yas-tryout-snippet)
         ("C-c y l" . yas-describe-tables)
         ("C-c y g" . yas/global-mode)
         ("C-c y m" . yas/minor-mode)
         ("C-c y r" . yas-reload-all)
         ("C-c y x" . yas-expand))
  :bind (:map yas-keymap
              ("C-i" . yas-next-field-or-maybe-expand))
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :config
  (yas-load-directory "~/.emacs.d/snippets")
  (yas-global-mode 1))

(use-package whitespace
  :bind ("C-c T w" . whitespace-mode)
  :init
  (setq whitespace-line-column nil
        whitespace-display-mappings '((space-mark 32 [183] [46])
                                      (newline-mark 10 [9166 10])
                                      (tab-mark 9 [9654 9] [92 9])))
  :config
  (set-face-attribute 'whitespace-space       nil :foreground "#666666" :background nil)
  (set-face-attribute 'whitespace-newline     nil :foreground "#666666" :background nil)
  (set-face-attribute 'whitespace-indentation nil :foreground "#666666" :background nil)
  :diminish whitespace-mode)

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode 1)
  :config
  (defalias 'redo 'undo-tree-redo)
  :bind (("C-z" . undo)     ; Zap to character isn't helpful
         ("C-S-z" . redo)))

(require 'init-formattedfiles)


(use-package go-mode
  :defer t
  :ensure t
  :mode ("\\.go$" . go-mode))

(use-package cperl-mode
  :mode (("\\.pl$" . cperl-mode)
	 ("\\.pm$" . cperl-mode))
  :config
  (setq-default
   cperl-electric-parens t 
   cperl-electric-keywords t
   cperl-indent-level 4
   cperl-hairy t
   cperl-auto-newline t
   cperl-mode-map nil
   cperl-extra-newline-before-brace nil)
  )

(use-package plantuml-mode
  :mode "\\.plantuml\\'")

(use-package cc-mode
  :preface
  (defun st-c-mode-common-hook()
    (c-toggle-auto-hungry-state )1
    )
  :hook ((c-mode-common . st-c-mode-common-hook)
	 (c++-mode .  (lambda () (hs-minor-mode 1))))
  :config
  (global-cwarn-mode 1)
  (setq-default c-basic-offset 2)
  (setq c-default-style
	'((other . "bsd"))))

(use-package clang-format
  :ensure t
  :bind (("C-c i" . clang-format-region )
	 ("C-c u" . clang-format-buffer))
  :config
  (setq clang-format-binary "clang-format-6.0")
  )

(require 'init-web)

(use-package elixir-mode
  :ensure t)

(use-package org
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t))))

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

;; Packages done, let's configure the rest

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

(savehist-mode 1)

(server-start)

(delete-selection-mode 1)

(windmove-default-keybindings 'meta)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(clang-format-executable "clang-format-6.0")
 '(package-selected-packages
   '(dockerfile-mode yaml-mode web-mode use-package undo-tree treemacs tide smartparens rubocop rspec-mode recentf-ext rbenv rainbow-mode popwin poet-theme pastelmac-theme origami olivetti minitest markdown-mode magit js2-mode ido-grid-mode helm-swoop helm-projectile helm-descbinds helm-ag go-mode git-timemachine git-gutter enh-ruby-mode diminish darkburn-theme company column-enforce-mode clang-format cheatsheet beacon anzu ag)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'upcase-region 'disabled nil)
