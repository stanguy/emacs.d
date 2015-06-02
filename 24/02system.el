(setq st::menu-disable t)

(when (eq window-system 'ns)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (set-default-font "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto5")
  (setq st::menu-disable nil)
  (exec-path-from-shell-initialize)
)
(when (eq window-system 'x)
  (set-default-font "Inconsolata-12")
)

(setq-default cursor-type 'bar)

(setq make-backup-files nil)
(savehist-mode 1)

(server-start)

(delete-selection-mode 1)

(global-set-key [(control f3)] 'highlight-symbol-at-point)
(windmove-default-keybindings 'meta)

 (setq ring-bell-function 'ignore)
