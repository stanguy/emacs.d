;;; modes.el --- 

;; Mode type :set num de VI
(autoload 'setnu-mode "setnu" nil t)
(autoload 'watson "watson" "Mode sherlock" t t)

;; Mode d'édition de fortunes
(autoload 'fortune "fortune" nil t)
(autoload 'fortune-add-fortune "fortune" nil t)
(autoload 'fortune-from-region "fortune" nil t)
(autoload 'fortune-compile "fortune" nil t)
(autoload 'fortune-to-signature "fortune" nil t)

;; couleurs
(require `font-lock)

;; on flash la parenthèse d'en face.
(require `paren)
; (paren-set-mode 'paren)

(message "Configuration du mode CSS")
(autoload `css-mode "css-mode")
(setq auto-mode-alist       
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))


(setq mmm-global-mode 'maybe)


(setq-default abbrev-mode t)
(setq save-abbrevs nil)

;(require 'msf-abbrev)
;(defun my-msf-abbrev-load-tree ()
;  (interactive)
;  (msf-abbrev-load-tree "~/.elisp/mode-abbrevs"))
;(my-msf-abbrev-load-tree)

;; ensure abbrev mode is always on
(setq-default abbrev-mode t)

;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)

;; load up abbrevs for these modes
(require 'msf-abbrev)
;(setq msf-abbrev-verbose t) ;; optional
(setq msf-abbrev-root "~/.emacs.d/mode-abbrevs")
;(global-set-key (kbd "C-c l") 'msf-abbrev-goto-root)
;(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)
(msf-abbrev-load)



;;; modes.el ends here
