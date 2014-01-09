(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(powerline-default-theme)
(load-theme 'zen-and-art t)

(require 'git-gutter)
;; If you enable global minor mode
(global-git-gutter-mode t)
(setq git-gutter:modified-sign " ")
(setq git-gutter:added-sign " ")
(setq git-gutter:deleted-sign " ")
(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-background 'git-gutter:added "SeaGreen")
(set-face-background 'git-gutter:deleted "firebrick4")

(require 'smartparens-config)
(require 'smartparens-ruby)
 (smartparens-global-mode)
 (show-smartparens-global-mode t)
 (sp-with-modes '(rhtml-mode)
   (sp-local-pair "<" ">")
   (sp-local-pair "<%" "%>"))
