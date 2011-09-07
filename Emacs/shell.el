;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; _+ Shell/sh mode
;;
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(setq comint-buffer-maximum-size 10240
      comint-scroll-to-bottom-on-input t
      comint-scroll-to-bottom-on-output t
      comint-scroll-show-maximum-output t)
;; (add-hook 'comint-output-filter-functions 'comint-truncate-buffer)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
(add-hook 'eshell-preoutput-filter-functions 'ansi-color-filter-apply)

(make-face 'my-shell-small-face)
(set-face-attribute 'my-shell-small-face nil :height 0.9 :family "Andale_Mono")
(add-hook 'shell-mode-hook
          '(lambda ()
             (font-lock-mode t)
             (buffer-face-mode t)
             (buffer-face-set 'my-shell-small-face)
             (ansi-color-for-comint-mode-on)
             (local-set-key [home] ; move to the beginning of the line
                            'comint-bol)
             (local-set-key [up] ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
             (local-set-key [down] ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             (make-local-variable 'show-trailing-whitespace)
             (setq show-trailing-whitespace nil)
             ))

;; Include the following only if you want to run
;; bash as your shell.

;; Setup Emacs to run bash as its primary shell.
;; (setq shell-file-name "bash")
(setq shell-command-switch "-c")
(setq explicit-shell-file-name shell-file-name)
(setenv "SHELL" shell-file-name)
(setq explicit-sh-args '("-login" "-i"))
(if (boundp 'w32-quote-process-args)
    (setq w32-quote-process-args ?\")) ;; Include only for MS Windows.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;_+ gud-mode
;;
(add-hook 'gud-mode-hook
          '(lambda ()
             (buffer-face-mode t)
             (buffer-face-set 'my-shell-small-face)
             (local-set-key [home] ; move to beginning of line, after prompt
                            'comint-bol)
             (local-set-key [up]   ; cycle backward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-previous-input 1)
                                 (previous-line 1))))
             (local-set-key [down]  ; cycle forward through command history
                            '(lambda () (interactive)
                               (if (comint-after-pmark-p)
                                   (comint-next-input 1)
                                 (forward-line 1))))
             ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;_+ ansi-term
;;
(defun open-localhost ()
  (interactive)
  (ansi-term "bash" "localhost"))

;; Use this for remote so I can specify command line arguments
(defun open-remotehost (new-buffer-name cmd &rest switches)
  (setq term-ansi-buffer-name (concat "*" new-buffer-name "*"))
  (setq term-ansi-buffer-name (generate-new-buffer-name term-ansi-buffer-name))
  (setq term-ansi-buffer-name (apply 'make-term term-ansi-buffer-name cmd nil switches))
  (set-buffer term-ansi-buffer-name)
  (term-mode)
  (term-char-mode)
  (term-set-escape-char ?\C-x)
  (switch-to-buffer term-ansi-buffer-name))

(defun open-wbu-rdsw1-linux ()
  (interactive)
  (open-remotehost "wbu-rdsw1-linux" "ssh" "yenliangliu@192.168.23.133"))


(add-hook 'term-mode-hook
          '(lambda ()
             (font-lock-mode t)
             (buffer-face-mode t)
             (buffer-face-set 'my-shell-small-face)
             (make-local-variable 'show-trailing-whitespace)
             (setq show-trailing-whitespace nil)
             ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;_+ Multi-term
;; load-path
(add-to-list 'load-path (concat LISP_HOME "/elpa/multi-term-0.8.8"))
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
(global-set-key (kbd "C-c t") 'multi-term-dedicated-open)
(global-set-key (kbd "C-c T") 'multi-term) ;; create a new one
(setq multi-term-program "/bin/bash"
      multi-term-buffer-name "term"
      ;; Jump to dedicated term window after its creation
      multi-term-dedicated-select-after-open-p t
      multi-term-scroll-to-bottom-on-output 'this
      multi-term-scroll-show-maximum-output t
      ;; term-default-fg-color "#eeeeec" ; in sync with color-theme
      ;; term-default-bg-color "#2e3436")
      )
;; (add-to-list 'term-unbind-key-list "C-l")
