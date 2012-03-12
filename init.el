(setq debug-on-error t)
;; -*- Mode: Emacs-Lisp -*-
;; $Id: emacs,v 1.3 2001/05/08 14:43:29 seb Exp $
;; Fichier de config (X)Emacs.  La plupart des packages demandant une
;; config un peu plus grosse (enfin normalement) ont leur propre
;; fichier de config appelé en cours de route.

(message "Mise en place des preferences")

;; mon répertoire. Mis en premier pour la recherche des fichiers
;; chargés plus tard.

(setq st::lisp-dir (expand-file-name "~/.emacs.d/"))
(setq st::emacs-lisp-dir (expand-file-name "~/.emacs.d/"))

(setq 
 load-path 
 (append
  (list st::lisp-dir 
             st::emacs-lisp-dir)
  load-path))

(setq st::load-pgnus t)

;(load "variables")
(define-key function-key-map [dead-circumflex]
  'compose-circumflex-map)
;; et puis ça c'est bien pour utiliser des trucs genre C-x 8 <
;(require 'iso-insert)

;;* Make the sequence "C-x w" execute the `what-line' command,
;;* which prints the current line number in the echo area.
(global-set-key "\C-xw" 'what-line)

(global-set-key [(super tab)] 'other-window)
(global-set-key "\M-g" 'goto-line)

(global-set-key [s-up] 'backward-list)
(global-set-key [s-down] 'forward-list)
; Goes to the next error in the compile errors list...
; or it goes to the next grep match in the grep match list
(global-set-key "\C-x\C-j" 'next-error)
;; Set the size of the compilation window height
(setq compilation-window-height 15)
;;force compilation to scroll
(setq compilation-scroll-output t)



;;*======================= 
;;* make netscape use a new window when clicking a URL
;;   by Karl Kleinpaste
(setq browse-url-new-window-p t)
(defun karl-browse (a)
  "Wrapper, for new window use."
  (browse-url-netscape a t))
(setq browse-url-browser-function (function karl-browse))


;; Avant qu'on commence à charger le mulet
;(load "st-compile")


(message "Configuration de MIME")
;; MIME
(if (not st::load-pgnus)
    ; Inutile avec Gnus 5.8.x, qui gère le mime seul.
    (progn 
      (load "mime-setup")
      (setq mime-editor/transfer-level 8)
      (setq mime-editor/split-message nil)))

(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;(autoload 'xxml-mode-routine "xxml")
;(add-hook 'sgml-mode-hook 'xxml-mode-routine)
;(setq auto-mode-alist 
;      (cons
;       '("\\.[xXoOmMdD][HhnNmMeESs][TtmMlLaAbBDd]?[pP]?$" . xml-mode)
;       auto-mode-alist))
(autoload 'xml-mode "psgml" nil t)




(load "prog-conf.el")

;; Fonction pour aligner des expressions
(autoload `align "align" nil t)


(autoload 'which "which" "Show where FUNCTION will be loaded from" t)

;; Pour récupérer le nom du système
(defconst se::system-short-name
  (let* ((sys-name (system-name))
         (per-match (string-match "\\." sys-name)))
    (if (not per-match)
        sys-name
      (substring sys-name 0 per-match))))

;; Pour changer le titre de la fenêtre
(if (eq window-system 'x)
    (setq frame-title-format
          (concat user-login-name "@" se::system-short-name ": %b")))

;(server-start)


; Pour jouer avec des templates.
(setq tpl-dir (concat st::lisp-dir "template"))
(setq load-path (append
		 load-path
		 (list (concat tpl-dir "/lisp/"))))
(require 'template)
(template-initialize)


(setq load-path (append
		 load-path
		 (list  (concat st::lisp-dir "cucumber.el"))))
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))


(load "custom")
(load "modes")
;(load "includer")
(require 'show-wspace)


;(gnuserv-start)
(mwheel-install)


(one-buffer-one-frame-mode nil)
(desktop-load-default)
(desktop-read)
(desktop-save-mode 1)

;; doesn't work as nicely as expected
;(autoload 'dta-hook-up "desktopaid.elc" "Desktop Aid" t)
;(dta-hook-up)

(setq make-backup-files nil) 


;(require 'zenburn)
;(zenburn)
(color-theme-initialize)
(color-theme-clarity)
(setq-default cursor-type 'hbar)
(menu-bar-mode nil)
(tool-bar-mode nil)
(tabbar-mode nil)
(scroll-bar-mode nil)
(pc-selection-mode t)


(iswitchb-mode t)



; code found on emacswiki
(defvar find-file-root-prefix (if (featurep 'xemacs) "/[sudo/root@localhost]" "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")

(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."

  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
   	 ;; use a separate history list for "root" files.
   	 (file-name-history find-file-root-history)
   	 (name (or buffer-file-name default-directory))
   	 (tramp (and (tramp-tramp-file-p name)
   		     (tramp-dissect-file-name name)))
   	 path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
   	    dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))

(global-set-key [(control x) (control r)] 'find-file-root)


(defface find-file-root-header-face
  '((t (:foreground "white" :background "red3")))
  "*Face use to display header-lines for files opened as root.")

(defun find-file-root-header-warning ()
  "*Display a warning in header line of the current buffer.
   This function is suitable to add to `find-file-root-hook'."
  (let* ((warning "WARNING: EDITING FILE AS ROOT!")
   	 (space (+ 6 (- (window-width) (length warning))))
   	 (bracket (make-string (/ space 2) ?-))
   	 (warning (concat bracket warning bracket)))
    (setq header-line-format
   	  (propertize  warning 'face 'find-file-root-header-face))))

(add-hook 'find-file-root-hook 'find-file-root-header-warning)

(windmove-default-keybindings 'meta)


 
(defun color-theme-twilight ()
  "Color theme by Marcus Crafter, based off the TextMate Twilight theme, created 2008-04-18"
  (interactive)
  (color-theme-install
'(color-theme-twilight
((background-color . "black")
(background-mode . dark)
(border-color . "black")
(cursor-color . "#A7A7A7")
(foreground-color . "#F8F8F8")
(mouse-color . "sienna1"))
(default ((t (:background "black" :foreground "white"))))
(blue ((t (:foreground "blue"))))
(bold ((t (:bold t))))
(bold-italic ((t (:bold t))))
(border-glyph ((t (nil))))
(buffers-tab ((t (:background "black" :foreground "white"))))
(font-lock-builtin-face ((t (:foreground "white"))))
(font-lock-comment-face ((t (:italic t :foreground "#5F5A60"))))
(font-lock-constant-face ((t (:foreground "#CF6A4C"))))
(font-lock-doc-string-face ((t (:foreground "DarkOrange"))))
(font-lock-function-name-face ((t (:foreground "#9B703F"))))
(font-lock-keyword-face ((t (:foreground "#CDA869"))))
(font-lock-preprocessor-face ((t (:foreground "Aquamarine"))))
(font-lock-reference-face ((t (:foreground "SlateBlue"))))
 
(font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062"))))
(font-lock-regexp-grouping-construct ((t (:foreground "red"))))
 
(font-lock-string-face ((t (:foreground "#8F9D6A"))))
(font-lock-type-face ((t (:foreground "#9B703F"))))
(font-lock-variable-name-face ((t (:foreground "#7587A6"))))
(font-lock-warning-face ((t (:bold t :background "#EE799F" :foreground "red"))))
(gui-element ((t (:background "#D4D0C8" :foreground "black"))))
(region ((t (:background "#27292A"))))
(mode-line ((t (:background "grey75" :foreground "black"))))
(highlight ((t (:background "#111111"))))
(highline-face ((t (:background "SeaGreen"))))
(italic ((t (nil))))
(left-margin ((t (nil))))
(text-cursor ((t (:background "yellow" :foreground "black"))))
(toolbar ((t (nil))))
(underline ((nil (:underline nil))))
(zmacs-region ((t (:background "snow" :foreground "blue")))))))


;(set-default-font "Bitstream Vera Sans Mono-11")
;(set-default-font "DejaVu Sans Mono-11")
(set-default-font "Inconsolata-12")
(set-face-background 'mmm-default-submode-face "#6e625a")

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((fold-internal-margins) (folded-file . t)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(require 'window-numbering)
(window-numbering-mode 1)
(put 'upcase-region 'disabled nil)
