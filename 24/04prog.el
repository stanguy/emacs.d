(require 'grizzl)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'grizzl)
;; Press Command-p for fuzzy find in project
(global-set-key (kbd "M-p") 'projectile-find-file)
;; Press Command-b for fuzzy switch buffer
(global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(setq-default indent-tabs-mode nil)
; runs make in the "current directory"
(global-set-key "\C-xm" 'compile)
; Goes to the next error in the compile errors list...
; or it goes to the next grep match in the grep match list
(global-set-key "\C-x\C-j" 'next-error)
;; Set the size of the compilation window height
(setq compilation-window-height 15)
;;force compilation to scroll
(setq compilation-scroll-output t)
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

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

(defconst my-c-style
       '((c-tab-always-indent        . t)
         (c-comment-only-line-offset . 0)
         (c-hanging-braces-alist     . ((substatement-open before after)
                                        (brace-list-open)))
         (c-hanging-colons-alist     . ((member-init-intro before)
                                        (inher-intro)
                                        (case-label after)
                                        (label after)
                                        (access-label after)))
         (c-cleanup-list             . (scope-operator
                                        empty-defun-braces
                                        defun-close-semi))
         (c-offsets-alist            . ((arglist-close . c-lineup-arglist)
                                        (substatement-open . 0)
                                        (case-label        . 4)
                                        (block-open        . 0)
                                        (knr-argdecl-intro . -)))
         (c-echo-syntactic-information-p . t))
       "My C Programming Style")

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; add my personal style and set it for the current buffer
  (c-add-style "PERSONAL" my-c-style t)
  ;; other customizations
  ;; we like auto-newline and hungry-delete
  (c-toggle-auto-hungry-state 1)
  ;; key bindings for all supported languages.  We can put these in
  ;; c-mode-base-map because c-mode-map, c++-mode-map, objc-mode-map,
  ;; java-mode-map, idl-mode-map, and pike-mode-map inherit from it.
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))

(add-hook 'c-mode-common-hook
                  'my-c-mode-common-hook)
(add-hook 'c++-mode-hook (lambda () (hs-minor-mode 1)))
(add-hook 'php-mode-hook (lambda () (c-set-style "symfony2")))
(global-cwarn-mode 1)

(setq c-default-style
      '((php-mode . "symfony2")
	(java-mode . "java")
	(awk-mode . "awk")
	(other . "gnu")))

(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

(defun ome-create-newline-and-enter-sexp (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (message "pouet")
    (previous-line)
    (indent-according-to-mode)
    (forward-line)
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

(dolist (mode '(c-mode c++-mode java-mode js2-mode sh-mode php-mode))
    (sp-local-pair mode
                   "{"
                   nil
                   :post-handlers
                   '((ome-create-newline-and-enter-sexp "RET"))))


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

