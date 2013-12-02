;;; prog-conf.el --- 
;; $Id: prog-conf.el,v 1.3 2001/05/08 14:21:52 seb Exp $

(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;(autoload 'xxml-mode-routine "xxml")
;(add-hook 'sgml-mode-hook 'xxml-mode-routine)
;(setq auto-mode-alist 
;      (cons
;       '("\\.[xXoOmMdD][HhnNmMeESs][TtmMlLaAbBDd]?[pP]?$" . xml-mode)
;       auto-mode-alist))
(autoload 'xml-mode "psgml" nil t)


(setq-default 
 indent-tabs-mode nil
 default-tab-width 8
; tab-stop-list
; '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76)
 ksh-indent 4)

; runs make in the "current directory"
(global-set-key "\C-xm" 'compile)
; Goes to the next error in the compile errors list...
; or it goes to the next grep match in the grep match list
(global-set-key "\C-x\C-j" 'next-error)
;; Set the size of the compilation window height
(setq compilation-window-height 15)
;;force compilation to scroll
(setq compilation-scroll-output t)

;;;

(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
;(require 'ruby-electric) 
;(add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode))) 

(autoload 'coffee-mode "coffee-mode" "Load coffee-mode")
(add-to-list 'auto-mode-alist '("\\.coffee\\'" . coffee-mode))


(add-to-list 'auto-mode-alist '("\\.scss\\'" . css-mode))


;; if complaining about not being compiled, use: 
;;    emacs --batch --eval '(byte-compile-file "js2.el")'
;; rather than fully loading emacs and failing to compile.
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-bounce-indent-p t)


(setq load-path (append
		 (list (concat st::init-lisp-dir "rhtml/"))
		 load-path))
(autoload 'rhtml-mode "rhtml-mode" "Load RHTML mode")
;;;

(setq load-path (append
		 (list (concat st::init-lisp-dir "mmm-mode/"))
		 load-path))

(require 'mmm-auto)

(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                 ("<%=" . mmm-output-submode-face)
                 ("<%"  . mmm-code-submode-face))
    :front "<%[#=]?" 
    :back "%>" 
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
             (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
             (?= erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))
;(add-hook 'html-mode-hook
;          (lambda ()
;            (setq mmm-classes '(erb-code))
;            (mmm-mode-on)))
;(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))


;;;


;;{{{ Perl
(message "Configuration Perl")
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

;;}}}
;;{{{ C/C++
(message "Configuration du mode C")

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
     
;; offset customizations not in my-c-style
(setq c-offsets-alist '((member-init-intro . ++)))

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
(global-cwarn-mode 1)

;(require 'develock)

;; Tell cc-mode not to check for old-style (K&R) function declarations.
;; This speeds up indenting a lot.
(setq c-recognize-knr-p nil)

;;}}}
;;{{{ SQL

(message "Configuration du mode SQL")
;; le mode SQL est un peu lourd. On ne le charge que sur demande.
(defun st::register-sql-mode ()
  (setq sql-lisp-dir (concat st::init-lisp-dir "sql-mode/"))
  (setq load-path (append load-path (list sql-lisp-dir)))
  (require 'sql-mode)
  (sql-initialize)
  (autoload 'sql-mode "sql-mode" "SQL Editing Mode" t)
  (setq auto-mode-alist
	(append '(("\\.sql$" . sql-mode)
		  ("\\.tbl$" . sql-mode)
		  ("\\.sp$"  . sql-mode))
		auto-mode-alist))
  )

;;}}}
;;{{{ Ada

(message "Configuration du mode ADA")
(setq-default
 ada-indent 4
 ada-case-keyword 'upcase-word
 ada-case-identifier 'downcase-word
 )

;;}}}
;;{{{ Modula3


;  Si le fichier du module existe (paquet pm3-extra sur une potato,
;  par exemple), on introduit sa config.
(let ((st::modula3-mode-file
       "/usr/share/emacs/site-lisp/pm3/modula3.el"))
  (if (file-exists-p st::modula3-mode-file)
      (progn
        (setq-default m3::electric-end 'all)
        (autoload 'modula-3-mode
          st::modula3-mode-file  nil t)
        (setq auto-mode-alist
              (cons '("\\.m3\\'" . modula-3-mode) auto-mode-alist)))))


;;}}}
;;{{{ Caml

(setq load-path (cons (concat st::init-lisp-dir "tuareg-mode") load-path))
(setq auto-mode-alist 
      (append '(("\\.ml\\w?" . tuareg-mode))
              auto-mode-alist))
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)

;;}}}
;;{{{ C#

(autoload 'csharp-mode "csharp-mode" 
  "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '( "\\.cs\\'" . csharp-mode ) auto-mode-alist ))

;;}}}

;; Fonction pour aligner des expressions
(autoload `align "align" nil t)


(autoload 'which "which" "Show where FUNCTION will be loaded from" t)

; Pour jouer avec des templates.
(setq tpl-dir (concat st::init-lisp-dir "template"))
(setq load-path (append
		 load-path
		 (list (concat tpl-dir "/lisp/"))))
(require 'template)
(template-initialize)


;;{{{ ASP Pages

;; (mmm-add-group 'asp-cs
;;  `((asp-cs-code
;;     :submode csharp-mode
;;     :match-face (("<%!" . mmm-declaration-submode-face)
;;                  ("<%=" . mmm-output-submode-face)
;;                  ("<%"  . mmm-code-submode-face))
;;     :front "<%[!=]?"
;;     :back "%>"
;;     :insert ((?% asp-cs-code nil @ "<%" @ " " _ " " @ "%>" @)
;;              (?! asp-cs-declaration nil @ "<%!" @ " " _ " " @ "%>" @)
;;              (?= asp-cs-expression nil @ "<%=" @ " " _ " " @ "%>" @))
;;     )
;;    (asp-cs-directive
;;     :submode text-mode
;;     :face mmm-special-submode-face
;;     :front "<%@"
;;     :back "%>"
;;     :insert ((?@ asp-cs-directive nil @ "<%@" @ " " _ " " @ "%>" @))
;;     )))

;;}}}

;(load "includer")
(require 'show-wspace)

;; Mode type :set num de VI
(autoload 'setnu-mode "setnu" nil t)
(autoload 'watson "watson" "Mode sherlock" t t)

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
(setq msf-abbrev-verbose t) ;; optional
(setq msf-abbrev-root "~/.emacs.d/23/mode-abbrevs")
;(global-set-key (kbd "C-c l") 'msf-abbrev-goto-root)
;(global-set-key (kbd "C-c a") 'msf-abbrev-define-new-abbrev-this-mode)
(msf-abbrev-load)

;;; prog-conf.el ends here
;; Local variables:
;; folded-file: t
;; fold-internal-margins: nil
;; end:
