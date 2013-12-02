(define-key function-key-map [dead-circumflex]
  'compose-circumflex-map)
;; et puis ça c'est bien pour utiliser des trucs genre C-x 8 <
(require 'iso-insert)

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

(setq st::load-pgnus t)
(if (not st::load-pgnus)
    ; Inutile avec Gnus 5.8.x, qui gère le mime seul.
    (progn 
      (load "mime-setup")
      (setq mime-editor/transfer-level 8)
      (setq mime-editor/split-message nil)))

(defconst se::system-short-name
  (let* ((sys-name (system-name))
         (per-match (string-match "\\." sys-name)))
    (if (not per-match)
        sys-name
      (substring sys-name 0 per-match))))


(if (eq window-system 'x)
    (setq frame-title-format
          (concat user-login-name "@" se::system-short-name ": %b")))
(mwheel-install)


(windmove-default-keybindings 'meta)
;(set-default-font "Bitstream Vera Sans Mono-11")
;(set-default-font "DejaVu Sans Mono-11")
(set-default-font "Inconsolata-12")
(set-face-background 'mmm-default-submode-face "#6e625a")
(desktop-load-default)
(desktop-read)
(desktop-save-mode 1)
(setq make-backup-files nil) 


(require 'zenburn)
(zenburn)
(setq-default cursor-type 'hbar)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(pc-selection-mode t)
(iswitchb-mode t)
