;; ------------------------------------------------------------
;; Stuff that is specific to Emacs 24
;; ------------------------------------------------------------
(message "===> loading settings for Emacs 24")

;; --------------------------------------------------
;; package sources
;; --------------------------------------------------
(require 'package)
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; --------------------------------------------------
;; Color theme
;; --------------------------------------------------
(add-hook 'after-make-window-system-frame-hooks
          (lambda ()
            ;; (load-theme 'tsdh-dark)
            (load-theme 'tango-dark)
            ;; (load-theme 'tsdh-dark)
            ;; (load-theme 'manoj-dark)
            ;; (load-theme 'wombat)
            ;; (load-theme 'tango)
            ;; (load-theme 'whiteboard)
            ))

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
;; (message ">>>>> [Emacs23] Setting load-path for org-mode <<<<<")
;; (setq ORG_LISP_HOME (concat ELPA_HOME "/org-20111026"))
(setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.8.02"))
;; (setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.7"))

;; (add-to-list load-path (concat LISP_HOME "/remember"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))
