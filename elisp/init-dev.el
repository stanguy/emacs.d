;;; init-dev -- Initialize generic development utilities and modes
;;; Commentary:
;;; -
;;; Code:


;; First utilitiles


(use-package aggressive-indent
  :ensure t
  :init
  (global-aggressive-indent-mode 1)
  ;; maybe
                                        ; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  )

(use-package eglot
  :ensure t)


;; Other languages

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

(use-package elixir-mode
  :ensure t)

(provide 'init-dev)

;;; init-dev ends here
