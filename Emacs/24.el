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
;; (add-hook 'after-make-window-system-frame-hooks
;;           (lambda ()
;;             ;; (load-theme 'tsdh-dark)))
;;             ;; (load-theme 'tango-dark)))
;;             ;; (load-theme 'tsdh-dark)))
;;             (load-theme 'manoj-dark)
;;             ;; (load-theme 'wombat)
;;             ;; (load-theme 'tango)
;;             ;; (load-theme 'whiteboard)
;;             ))
