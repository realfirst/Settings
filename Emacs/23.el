;; ------------------------------------------------------------
;; Stuff that is specific for Emacs 23
;; ------------------------------------------------------------

;; loading color-theme for non-Aquamacs
(unless (featurep 'aquamacs)
  (when window-system
    (progn                                ; non-aquamacs
      (message ">>>>> [Emacs23] Loading color themes <<<<<")
      (set-variable 'color-theme-is-global nil)
      (defconst COLOR_THEME_LISP_HOME (concat ELPA_HOME "/color-theme-6.6.1"))

      (add-to-list 'load-path COLOR_THEME_LISP_HOME)
      (require 'color-theme)
      (load-file (concat ELPA_HOME "/color-theme-twilight-0.1/color-theme-twilight.el"))
      ;; (load-file (concat ELPA_HOME "/color-theme-actress-0.1.0/color-theme-actress.el"))
      (set-variable 'color-theme-is-global nil)
      (message "Setting favorite color theme")
      ;; (add-hook 'after-make-window-system-frame-hooks 'color-theme-midnight)
      ;; (add-hook 'after-make-window-system-frame-hooks 'color-theme-twilight)
      ;; (add-hook 'after-make-window-system-frame-hooks 'color-theme-tangotango)
      ;; (add-hook 'after-make-console-frame-hooks 'color-theme-tty-dark)
      (load-file (concat LISP_HOME "/color-theme-tomorrow.el"))
      )))

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
;; (message ">>>>> [Emacs23] Setting load-path for org-mode <<<<<")
(setq ORG_LISP_HOME (concat LISP_HOME "/org/org-7.8.02"))

(add-to-list 'load-path (concat ORG_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat ORG_LISP_HOME "/contrib/lisp"))

;; ----------------------------------------------------------------------
;; Magit
;;
;; M-x magic-status
;;     d -> diff
;;     s -> stage    u -> unstage
;;     c -> commit
;;     P -> push
;;     f -> remote update   F -> pull
;; ----------------------------------------------------------------------
(add-to-list 'load-path (concat ELPA_HOME "/elpa/magit-1.0.0/"))

;; Cygwin-mount
(add-to-list 'load-path (concat ELPA_HOME "/cygwin-mount-2001"))

;; multi-term
(add-to-list 'load-path (concat ELPA_HOME "/multi-term-0.8.8"))

;; tabbar
(add-to-list 'load-path (concat ELPA_HOME "/tabbar-2.0.1"))

;; perforce integration
(add-to-list 'load-path (concat ELPA_HOME "/p4-11.0"))

;; hideshow-vis
(add-to-list 'load-path (concat ELPA_HOME "/hideshowvis-0.3"))
