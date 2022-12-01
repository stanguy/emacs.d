;;; init-c -- Initialize C dev modes
;;; Commentary:
;;; -
;;; Code:

(use-package cc-mode
  :preface
  (defun st-c-mode-common-hook()
    (c-toggle-auto-hungry-state )1
    )
  :hook ((c-mode-common . st-c-mode-common-hook)
	 (c++-mode .  (lambda () (hs-minor-mode 1))))
  :config
  (global-cwarn-mode 1)
  (setq-default c-basic-offset 2)
  (setq c-default-style
	'((other . "bsd"))))

(use-package clang-format
  :ensure t
  :bind (("C-c i" . clang-format-region )
	 ("C-c u" . clang-format-buffer))
  :config
  (setq clang-format-binary "clang-format-6.0")
  )

(provide 'init-c)

;;; init-c ends here
