;;; init-formattedfiles -- Initialize modes for random (non-programming) formats
;;; Commentary:
;;; -
;;; Code:

(use-package yaml-mode
  :ensure t
  :mode ("\\.ya?ml\\'" . yaml-mode))

(use-package nxml-mode
  :config
  (setq nxml-slash-auto-complete-flag t)
  )

(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode))

(use-package plantuml-mode
  :mode "\\.plantuml\\'")

(use-package org
  :defines org-capture-templates
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t)))
  (setq org-capture-templates
        '(
          ("j" "Work Log Entry"
           entry (file+datetree "~/Documents/notes/work-log.org")
           "* %?"
           :empty-lines 0)
          ("m" "Meeting"
           entry (file+datetree "~/Documents/notes/meetings.org")
           "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)
          ("p" "Project advancement"
           entry (clock)
           "* %?"
           )
          )))

(use-package org-bullets
  :ensure t
  :after (org)
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-hide-leading-stars t)
  )


(provide 'init-formattedfiles)

;;; init-formattedfiles ends here
