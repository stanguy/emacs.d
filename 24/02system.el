(when (eq window-system 'ns)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil)
  (set-default-font "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto5")
)
(when (eq window-system 'x)
  (set-default-font "Inconsolata-12")
)

(setq make-backup-files nil)

(server-start)
