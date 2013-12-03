(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)


(defalias 'perl-mode 'cperl-mode)
(setq-default
 cperl-electric-parens t 
 cperl-electric-keywords t
 cperl-indent-level 4
 cperl-hairy t
 cperl-auto-newline t
 cperl-mode-map nil
 cperl-extra-newline-before-brace nil
 )

(setq c-default-style
      '((php-mode . "symfony2")
	(java-mode . "java")
	(awk-mode . "awk")
	(other . "gnu")))

(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

(autoload 'rainbow-turn-on "rainbow-mode" "Enable rainbow mode colour literal overlays")
(dolist (hook '(css-mode-hook html-mode-hook sass-mode-hook scss-mode-hook))
  (add-hook hook 'rainbow-turn-on))

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

