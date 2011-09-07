;; ----------------------------------------------------------------------
;; Key mappings.
;; ----------------------------------------------------------------------

(global-set-key [f2] 'save-buffer)
(global-set-key [f3] 'find-file)

(defun josh/revert-buffer ()
  "Revert the current buffer without confirmation unless explicitly modified."
  (interactive)
  (revert-buffer t (not (buffer-modified-p))))
(global-set-key [f4] 'switch-to-buffer)
(global-set-key [(meta r)] 'josh/revert-buffer)

(defun josh/kill-current-buffer ()
  "Kill the current buffer without confirmation unless explicitly modified."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key [f12] 'josh/kill-current-buffer)


(global-set-key [insertchar] 'overwrite-mode)

(global-set-key "\C-x%" 'match-paren)

(global-set-key "\r" 'newline-and-indent)

(global-set-key "\C-s" 'isearch-forward)

(global-set-key "\C-i" 'agulbra-c++-tab)

(global-set-key "\C-\\" 'toggle-input-method)

;; Avoid to minimize Emasc in windowed system.
(when window-system (global-unset-key "\C-z"))

;; --------------------------------------------------
;; Movement and window management
;; --------------------------------------------------
(global-set-key [f5] 'other-window)

;; for rxvt
;;(define-key function-key-map "\e[7~" [home])
;;(define-key function-key-map "\e[8~" [end])
(global-set-key [end] 'end-of-line)
(global-set-key [select] 'end-of-line)

(global-set-key "\C-j" 'goto-line)
(global-set-key "\M-g" 'goto-line)

(global-set-key [mouse-5] 'scroll-up)
(global-set-key [mouse-4] 'scroll-down)

;; window management
(global-set-key "\C-x(" 'shrink-window)
(global-set-key "\C-x)" 'enlarge-window)

;; --------------------------------------------------
;; For Rxvt only
;; --------------------------------------------------
;; (load-file (concat LISP_HOME "/rxvt.el"))
;; (define-key function-key-map "\e[a" [(shift up)])
;; (define-key function-key-map "\e[b" [(shift down)])
;; (define-key function-key-map "\e[c" [(shift right)])
;; (define-key function-key-map "\e[d" [(shift left)])

;; --------------------------------------------------
;; WoMan
;; --------------------------------------------------
;; use topic w/o confirmation
(global-set-key "\C-cw"
                (lambda ()
                  (interactive)
                  (let ((woman-use-topic-at-point t))
                    (woman))))
