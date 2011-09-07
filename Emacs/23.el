;; ------------------------------------------------------------
;; Stuff that is specific for Emacs 23
;; ------------------------------------------------------------
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;; (when
;;     (load
;;      (expand-file-name "~/.emacs.d/elpa/package.el"))
;;   (package-initialize))
;; (setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
;;                          ("gnu" . "http://elpa.gnu.org/packages/")))

(message ">>>>> [Emacs23] Loading color themes <<<<<")
(defconst COLOR_THEME_LISP_HOME (concat LISP_HOME "/color-theme/6.6.0"))

(add-to-list 'load-path COLOR_THEME_LISP_HOME)
(require 'color-theme)
(load-file (concat COLOR_THEME_LISP_HOME "/themes/contrib/color-theme-tango-2.el"))
(load-file (concat COLOR_THEME_LISP_HOME "/themes/contrib/color-theme-tangotango.el"))
(load-file (concat LISP_HOME "/elpa/color-theme-twilight-0.1/color-theme-twilight.el"))
(color-theme-initialize)
(set-variable 'color-theme-is-global nil)
(message "Setting favorite color theme")
;; (add-hook 'after-make-window-system-frame-hooks 'color-theme-midlight)
(add-hook 'after-make-window-system-frame-hooks 'color-theme-twilight)
;; (add-hook 'after-make-window-system-frame-hooks 'color-theme-tangotango)
(add-hook 'after-make-console-frame-hooks 'color-theme-tty-dark)

;; --------------------------------------------------
;; Org-mode
;; --------------------------------------------------
;; (message ">>>>> [Emacs23] Setting load-path for org-mode <<<<<")
(require 'htmlize)
(setq htmlize-output-type 'css
      htmlize-html-charset "utf-8"
      htmlize-convert-nonascii-to-entities nil)

(defconst ORG_LISP_HOME (concat LISP_HOME "/org/org-7.7"))

;; (add-to-list load-path (concat LISP_HOME "/remember"))
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
(add-to-list 'load-path (concat LISP_HOME "/elpa/magit-1.0.0/"))
(require 'magit)
