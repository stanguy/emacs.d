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

;; « lets you interactively do things with buffers and files »
(use-package ido
  :config
  (setq ido-enable-flex-matching t)
                                        ;(ido-everywhere t)
  (ido-mode 1))

(use-package ido-grid-mode
  :ensure t
  :config
  (ido-grid-mode 1))

;; silver searcher front
(use-package ag
  :ensure t
  :commands (ag ag-regexp ag-project))

(require 'init-themes)

(use-package recentf-ext
  :ensure t
  :defer 1)

(require 'init-helm)
(require 'init-projectile)

;; « Jump to arbitrary positions in visible text and select text
;; quickly. »
(use-package avy
  :ensure t
  :bind*  ("C-." . avy-goto-char-timer)
  :config (avy-setup-default)
  )

;; Highlight cursor on scrolling window
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
  (show-paren-mode t)
  (sp-with-modes '(rhtml-mode)
    (sp-local-pair "<" ">")
    (sp-local-pair "<%" "%>"))
  )


;; marking long lines
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

;; project management
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

(require 'init-formattedfiles)
(require 'init-c)
(require 'init-web)
(require 'init-dev)
(require 'init-ui)

;; Packages done, let's configure the rest

(savehist-mode 1)
(server-start)

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

;;; init ends here
