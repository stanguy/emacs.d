(message "init.el")

(setq inhibit-splash-screen t)

(cond 
 ((<= emacs-major-version 23)
  (setq st::init-lisp-dir (expand-file-name "~/.emacs.d/23/")))
 ((= emacs-major-version 24)
  (setq st::init-lisp-dir (expand-file-name "~/.emacs.d/24/")))
)

(setq  load-path (append load-path (list st::init-lisp-dir)))

(load "01base.el")
(load "02system.el")
(load "03decorations.el")
(load "04prog.el")

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
 
