;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yenliangl@gmail.com
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ----------------------------------------------------------------------
;; Create two hooks for console and window modes
;; ----------------------------------------------------------------------
(defvar after-make-console-frame-hooks '()
  "Hooks to run after creating a new TTY frame")
(defvar after-make-window-system-frame-hooks '()
  "Hooks to run after creating a new window-system frame")

(defun run-after-make-frame-hooks (frame)
  "Selectively run either `after-make-console-frame-hooks' or
`after-make-window-system-frame-hooks'"
  (select-frame frame)
  (run-hooks (if window-system
                 'after-make-window-system-frame-hooks
               'after-make-console-frame-hooks)))

(add-hook 'after-make-frame-functions 'run-after-make-frame-hooks)
(add-hook 'after-init-hook
          (lambda ()
            (run-after-make-frame-hooks (selected-frame))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; ----------------------------------------------------------------------
;; Basic settings
;; ----------------------------------------------------------------------
;; (mouse-wheel-mode 1)

;; Language environment
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(setenv "TERM" "emacs")

(setq default-major-mode 'text-mode
      inhibit-startup-messages t
      require-final-newline t
      next-line-add-newlines nil
      show-paren-style 'paren
      find-file-existing-other-name t ; Make emacs recognize that symlinks are the same files
      debug-on-error nil
      scroll-margin 3
      oll-conservatively 10000
      visible-bell nil
      x-select-enable-clipboard t
      column-number-mode t

      ;; --------------------------------------------------
      ;; Backup
      ;; --------------------------------------------------
      auto-save-directory (expand-file-name "~/.emacs-saves/")
      auto-save-default t
      auto-save-directory-fallback auto-save-directory
      auto-save-hash-p nil
      efs-auto-save t
      efs-auto-save-remotely nil
      ;; now that we have auto-save-timeout, let's crank this up
      ;; for better interactive response.
      auto-save-interval 800

      backup-directory-alist '(("." . "~/.backup"))
      kept-new-versions 16
      kept-old-versions 2
      delete-old-versions t
      backup-by-copying-when-linked t

      ;; --------------------------------------------------
      ;; Version control
      ;; --------------------------------------------------
      version-control t
      ;; vc-handled-backends nil           ;speed-up saving buffers
      vc-make-backup-files nil
      vc-cvs-stay-local nil             ; automatic version backup.

      ;; --------------------------------------------------
      ;; Auto-revert buffer when disk file changes
      ;; --------------------------------------------------
      auto-revert-interval 3
      auto-revert-check-vc-info t

      tramp-default-method "ssh"        ;smb

      )

(fset 'yes-or-no-p 'y-or-n-p)
(setq-default fill-column 80
              indent-tabs-mode nil
              line-number-mode t
              column-number-mode t
              transient-mark-mode t     ; Transient mark mode
              cursor-type 'box
              )

(global-auto-revert-mode t)
(global-font-lock-mode t)
(show-paren-mode t)                     ; Parenesis mode
(blink-cursor-mode 0)
(when window-system
  (tool-bar-mode -1))
(unless window-system
  (menu-bar-mode -1))

;; --------------------------------------------------
;; handle trailing whitespaces
;; --------------------------------------------------
(setq-default show-trailing-whitespace t)
(setq default-indicate-empty-lines t)

;; --------------------------------------------------
;; system-specific
;; --------------------------------------------------
(unless (boundp 'EMACS_HOME)
	(defconst EMACS_HOME (expand-file-name "~/Settings/Emacs")))
(defconst DROPBOX (expand-file-name "~/Dropbox"))
(setq user-emacs-directory (concat DROPBOX "/.emacs.d"))
(defconst LISP_HOME (expand-file-name (concat user-emacs-directory "/elisp")))
(defconst ELPA_HOME (expand-file-name (concat user-emacs-directory "/elpa")))

(add-to-list 'load-path LISP_HOME)

;; work around a bug on OS X where system-name is FQDN
(if (eq system-type 'darwin)
    (setq system-name (car (split-string system-name "\\."))))

;; keep system- or user-specific customizations here
(setq system-specific-config (concat EMACS_HOME "/" system-name ".el")
      user-specific-config (concat EMACS_HOME "/" user-login-name ".el")
      user-specific-dir (concat EMACS_HOME "/" user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
    (mapc #'load (directory-files user-specific-dir nil ".*el$")))

(setq version-specific-config (concat EMACS_HOME "/" (number-to-string emacs-major-version) ".el"))
(if (file-exists-p version-specific-config) (load version-specific-config))

;; (defconst is-after-emacs-23  (<= 23 emacs-major-version))
;; (defconst is-after-emacs-24  (<= 24 emacs-major-version))

(setq system-type-specific-config (concat EMACS_HOME "/" (prin1-to-string system-type) ".el"))
(if (file-exists-p system-type-specific-config) (load system-type-specific-config))

;; ----------------------------------------------------------------------
;; Query and search EMACS_HOME
;; ----------------------------------------------------------------------
(add-hook 'isearch-mode-hook
          ;; (function
          (lambda ()
            (define-key isearch-mode-map "\C-h" 'isearch-mode-help)
            (define-key isearch-mode-map "\C-t" 'isearch-toggle-regexp)
            (define-key isearch-mode-map "\C-c" 'isearch-toggle-case-fold)
            (define-key isearch-mode-map "\C-j" 'isearch-edit-string)))
;; Case fold search indicator on mode-line
(add-to-list 'minor-mode-alist '(case-fold-search " CFS"))
(setq-default case-fold-search nil)
(setq search-highlight t
      query-replace-highlight t)


;; ----------------------------------------------------------------------
;; Ido mode: switch to buffers by typing a subset of their names
;; ----------------------------------------------------------------------
(require 'ido)
(ido-mode t)
(setq ido-create-new-buffer 'always)

;; Don't prompt when killing a buffer with a live process attached to it.
(setq kill-buffer-query-functions
      (remq 'process-kill-buffer-query-function
            kill-buffer-query-functions))

;; ----------------------------------------------------------------------
;; Doxygen mode load-path
;; ----------------------------------------------------------------------
(add-to-list 'load-path (concat LISP_HOME "/url"))
(add-to-list 'load-path (concat LISP_HOME "/doxymacs"))
(require 'doxymacs)
(dolist (hook (list 'c++-mode-hook
                    'java-mode-hook))
  (add-hook hook 'doxymacs-font-lock))

;; (defun my-doxymacs-font-lock-hook ()
;;   (when (memq major-mode '(c-mode jde-mode java-mode c++-mode))
;;        (doxymacs-font-lock)))

;; ----------------------------------------------------------------------
;; Emacs goodies
;; ----------------------------------------------------------------------
(add-to-list 'load-path (concat LISP_HOME "/emacs-goodies-el"))
(require 'emacs-goodies-el)

;; --------------------------------------------------
;; Xrdb mode
;; --------------------------------------------------
(autoload 'xrdb-mode "xrdb-mode" "Mode for editing X resource files" t)
(setq auto-mode-alist
      (append '(("\\.Xdefaults$"    . xrdb-mode)
                ("\\.Xenvironment$" . xrdb-mode)
                ("\\.Xresources$"   . xrdb-mode)
                ("*.\\.ad$"         . xrdb-mode)
                )
              auto-mode-alist))

;; ----------------------------------------------------------------------
;; Lex/Yacc/Bison
;; ----------------------------------------------------------------------
(autoload 'make-regexp "make-regexp" "Return a regexp to match a string item in STRINGS." t)
(autoload 'make-regexps "make-regexp"  "Return a regexp to REGEXPS." t)
(autoload 'bison-mode "bison-mode")
(autoload 'flex-mode "flex-mode")
(setq auto-mode-alist
      (append '(("\\.l$" . flex-mode)
                ("\\.y$" . bison-mode)
                )
              auto-mode-alist))

;; ----------------------------------------------------------------------
;; C/C++
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/cc.el"))

;; ----------------------------------------------------------------------
;; Tags/Global
;; ----------------------------------------------------------------------
(autoload 'gtags-mode "gtags" "" t)
(dolist (hook (list 'c-mode-hook
                    'c++-mode-hook
                    'java-mode-hook))
  (add-hook hook '(lambda ()
                    (gtags-mode 1)
                    )))
(add-hook 'gtags-mode-hook
          '(lambda ()
             (setq gtags-pop-delete t)
             (setq gtags-path-style 'absolute)
             (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
             (local-set-key (kbd "M-,") 'gtags-find-rtag)  ; reverse tag
             ))

(add-hook 'gtags-select-mode-hook
          '(lambda ()
             (setq hl-line-face 'underline)
             (hl-line-mode 1)
             ))

;; ----------------------------------------------------------------------
;; CEDET & JDEE
;; ----------------------------------------------------------------------
(and (boundp 'use-jdee) use-jdee
     (progn
       ;; ----------------------------------------------------------------------
       ;; CEDET
       ;; ----------------------------------------------------------------------
       (load-file (concat EMACS_HOME "/cedet.el"))

       ;; ----------------------------------------------------------------------
       ;; JDEE
       ;; ----------------------------------------------------------------------
       (load-file (concat EMACS_HOME "/jdee.el"))
       ))

;; ----------------------------------------------------------------------
;; ECB
;; ----------------------------------------------------------------------
(and (boundp 'use-ecb) use-ecb
     (load-file (concat EMACS_HOME "/ecb.el"))
     )

;; ----------------------------------------------------------------------
;; _+ Fontlock mode
;; ----------------------------------------------------------------------
;; (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

(setq font-lock-maximum-decoration t
      keyword-highlight-modes '(java-mode c-mode c++-mode emacs-lisp-mode jde-mode))
(make-face 'font-lock-fixme-face)
(make-face 'font-lock-todo-face)
(make-face 'font-lock-question-face)
(make-face 'font-lock-small-face)
(set-face-attribute 'font-lock-small-face nil :height 0.9)
(mapc (lambda (mode)
        (font-lock-add-keywords
         mode
         '(("\\<\\(FIXME\\):" 1 'font-lock-fixme-face t))))
      keyword-highlight-modes)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode '(("\\<\\(TODO\\):" 1 'font-lock-todo-face t))))
      keyword-highlight-modes)

(mapc (lambda (mode)
        (font-lock-add-keywords
         mode '(("\\<\\(QUESTION\\)\\?" 1 'font-lock-question-face t))))
      keyword-highlight-modes)

(add-hook 'after-make-window-system-frame-hooks 'josh/set-small-modeline-font-hook)
(defun josh/set-small-modeline-font-hook ()
  "Revert the current buffer without confirmation unless explicitly modified."
  (set-face-attribute 'mode-line nil :height 0.9)
  (set-face-attribute 'mode-line-inactive nil :height 0.9)
  (set-face-attribute 'minibuffer-prompt nil :height 0.9)
  )

;; (add-hook 'after-make-console-frame-hooks 'josh/after-make-console-frame-hook)
;; (defun josh/after-make-console-frame-hook ()
;;   "Revert the current buffer without confirmation unless explicitly modified."
;;   (set-face-attribute 'mode-line nil :height 0.8)
;;   (set-face-attribute 'mode-line-inactive nil :height 0.8)
;;   )

;; ----------------------------------------------------------------------
;; Shell/Multi-term/GUD
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/shell.el"))

;; ----------------------------------------------------------------------
;; Key mappings.
;; ----------------------------------------------------------------------
(load-file (concat EMACS_HOME "/binding.el"))

;; ----------------------------------------------------------------------
;; Window manager & Moving behavior
;; ----------------------------------------------------------------------
(require 'windmove)
(windmove-default-keybindings 'control)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; _+ Org-mode
;;
(and (boundp 'use-org-mode) use-org-mode
     (load-file (concat EMACS_HOME "/org.el")))

;; ----------------------------------------------------------------------
;; EasyPG
;; ----------------------------------------------------------------------
(require 'epa)
(epa-file-enable)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

;; ----------------------------------------------------------------------
;; Uniquify buffer names
;; ----------------------------------------------------------------------
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward
      uniquify-separator ":")

;; ----------------------------------------------------------------------
;; ibuffer
;; ----------------------------------------------------------------------
(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      '(("default"
         ("Org" ;; all org-related buffers
          (mode . org-mode))
         ("Mail"
          (or  ;; mail-related buffers
           (mode . message-mode)
           (mode . mail-mode)
           ;; etc.; all your mail related modes
           ))
         ("Leo21"
          (or (filename . "/Volumes/Leo21/")
              (filename . "~/projects/altek/Leo21")))
         ("Froyo"
          (or (filename . "/Volumes/Froyo/")
              (filename . "~/projects/android/AndroidSource/Froyo")))
         ("quicklearn-android"
          (filename . "~/projects/quicklearn-android/"))
         ("Programming" ;; prog stuff not already in MyProjectX
          (or
           (mode . c-mode)
           (mode . perl-mode)
           (mode . python-mode)
           (mode . emacs-lisp-mode)
           (mode . java-mode)
           (mode . jde-mode)
           ;; etc
           ))
	 ("Help" (or (name . "\*Help\*")
		     (name . "\*Apropos\*")
		     (name . "\*info\*")))
         ("ERC" (mode . erc-mode)))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

(setq ibuffer-show-empty-filter-groups nil)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Compare two marked buffers with ediff
(defun ibuffer-ediff-marked-buffers ()
  (interactive)
  (let* ((marked-buffers (ibuffer-get-marked-buffers))
         (len (length marked-buffers)))
    (unless (= 2 len)
      (error (format "%s buffer%s been marked (needs to be 2)"
                     len (if (= len 1) " has" "s have"))))
    (ediff-buffers (car marked-buffers) (cadr marked-buffers))))

(define-key ibuffer-mode-map "e" 'ibuffer-ediff-marked-buffers)

;; ----------------------------------------------------------------------
;; Rainbow delimiters
;; ----------------------------------------------------------------------
;; (when (require 'rainbow-delimiters nil 'noerror)
;;   (progn
;;     (add-hook 'scheme-mode-hook 'rainbow-delimiters-mode)
;;     (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
;;     ))

;; ----------------------------------------------------------------------
;; nav
;;
;; M-x nav
;; ----------------------------------------------------------------------
;; (require 'nav)

;; ----------------------------------------------------------------------
;; Load my secrets
;; ----------------------------------------------------------------------
;; (load-file (concat EMACS_HOME "/secrets.el"))
;; (require 'my-secrets)

;; ----------------------------------------------------------------------
;; Anything
;; ----------------------------------------------------------------------
;; (add-to-list 'load-path (concat LISP_HOME "/elpa/anything-config-0.4.1"))
;; (add-to-list 'load-path (concat LISP_HOME "/elpa/anything-1.287"))
;; (require 'anything-config)

;; (add-to-list 'load-path (concat LISP_HOME "/doremi"))
;; (require 'doremi)
;; (require 'doremi-mac)
;; (require 'doremi-cmd)

;; ----------------------------------------------------------------------
;; Resize windows
;; ----------------------------------------------------------------------
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; ----------------------------------------------------------------------
;; GUI config
;; ----------------------------------------------------------------------
(when window-system
  (progn
    (setq default-frame-alist
          '((vertical-scroll-bars)
            (alpha 95 90)                   ;transparency
            ))

    ;; --------------------------------------------------
    ;; Hideshow
    ;; --------------------------------------------------
    (add-to-list 'load-path (concat LISP_HOME "/elpa/hideshowvis-0.3"))
    (autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
    (autoload 'hideshowvis-minor-mode
      "hideshowvis"
      "Will indicate regions foldable with hideshow in the fringe."
      'interactive)

    (dolist (hook (list 'emacs-lisp-mode-hook
                        'c++-mode-hook
                        'java-mode-hook))
      (add-hook hook 'hideshowvis-enable))

    ;; --------------------------------------------------
    ;; elscreen
    ;; --------------------------------------------------
    (load-file (concat EMACS_HOME "/elscreen.el"))

    ))
(appt-activate t)
