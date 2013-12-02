(message "init.el")
(require 'cask "~/.cask/cask.el")
(cask-initialize)


(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(when (eq window-system 'ns)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (set-default-font "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto5")
)


(tool-bar-mode -1)
(powerline-default-theme)
(load-theme 'zen-and-art t)


(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
 (setq projectile-completion-system 'grizzl)
 ;; Press Command-p for fuzzy find in project
 (global-set-key (kbd "M-p") 'projectile-find-file)
 ;; Press Command-b for fuzzy switch buffer
 (global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(require 'git-gutter)
;; If you enable global minor mode
(global-git-gutter-mode t)
(setq git-gutter:modified-sign " ")
(setq git-gutter:added-sign " ")
(setq git-gutter:deleted-sign " ")
(set-face-background 'git-gutter:modified "purple") ;; background color
(set-face-background 'git-gutter:added "SeaGreen")
(set-face-background 'git-gutter:deleted "firebrick4")

(autoload 'rainbow-turn-on "rainbow-mode" "Enable rainbow mode colour literal overlays")
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook scss-mode-hook))
  (add-hook hook 'rainbow-turn-on))

(require 'smartparens-config)
(require 'smartparens-ruby)
 (smartparens-global-mode)
 (show-smartparens-global-mode t)
 (sp-with-modes '(rhtml-mode)
   (sp-local-pair "<" ">")
   (sp-local-pair "<%" "%>"))

(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)
(add-hook 'prog-mode-hook 'subword-mode)
(global-hl-line-mode +1)


(require 'highlight-indentation)
(add-hook 'prog-mode-hook
	  (lambda () (highlight-indentation-current-column-mode)))



(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "854e99f94a7dae0446b2f8c1de3ceeaeeb60f9085b1880e63def87ae81190869" "0c311fb22e6197daba9123f43da98f273d2bfaeeaeb653007ad1ee77f0003037" default)))
 '(powerline-default-separator (quote wave)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line-buffer-id ((t (:background "grey70" :foreground "black" :weight bold))))
 '(powerline-active1 ((t (:inherit mode-line :background "grey22" :foreground "gray70"))))
 '(powerline-active2 ((t (:inherit mode-line :background "grey40" :foreground "grey90")))))
 
