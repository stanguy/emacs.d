;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

(setq
 ns-command-modifier 'meta         ; Apple/Command key is Meta
 ns-alternate-modifier 'alt         ; Option is the Mac Option key
 ns-use-mac-modifier-symbols  nil  ; display standard Emacs (and not standard Mac) modifier symbols)
 x-select-enable-clipboard t
 mac-option-modifier nil
 )

(one-buffer-one-frame-mode 0)

(tool-bar-mode 0)
(set-face-attribute 'mode-line nil :inherit 'unspecified) ; show modeline in Monaco
(set-face-attribute 'echo-area nil :family 'unspecified)  ; show echo area in Monaco
(aquamacs-autoface-mode -1)

(global-set-key (kbd "M-RET") 'aquamacs-toggle-full-frame)

(set-default-font "-apple-Menlo-medium-normal-normal-*-12-*-*-*-m-0-fontset-auto5")
