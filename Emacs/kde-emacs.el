;; ------------------------------------------------------------
;; Pull wanted stuff from Kde-emacs
;; ------------------------------------------------------------
(require 'cc-mode)

(add-to-list 'load-path (concat LISP_HOME "/kde-emacs/4.6.1"))
(require 'kde-emacs-utils)
(setq kde-full-name "yenliangl"
      kde-mail "yenliangl@gmail.com")

(defcustom kde-tab-behavior 'default
  "Specifies the current tab behavior. default will expand try to complete
the symbol at point if at the end of something that looks like an indentifier else
it will indent the current line if the pointer is at the beginning of the line it will
be moved the the start of the indention. abbrev-indent behaves like default, but the
cursor isn't moved to the beginning of the indention with tab is pressed when the cursor
is at the beginning of the line. indent simply indents the line without trying to
complete the symbol"
  :group 'kde-devel
  :version "0.1"
  :type `(choice (const default) (const abbrev-indent) (const indent)))

(defun agulbra-clean-out-spaces ()
  "Remove spaces at ends of lines."
  (interactive)
  (and (not buffer-read-only)
       (save-excursion
         (goto-char (point-min))
         (let ((count 0)
               (bmp (buffer-modified-p)))
           (while (re-search-forward "[ \t]+$" nil t)
             (setq count (1+ count))
             (replace-match "" t t))
           (set-buffer-modified-p bmp)
	   nil
           ))))

(defun agulbra-c++-clean-out-spaces ()
  "Remove spaces at ends of lines, only in c++ mode."
  (interactive)
  (if (eq major-mode 'c++-mode)
      (agulbra-clean-out-spaces)
    )
  )

(defun agulbra-c++-tab (arg)
  "Do the right thing about tabs in c++ mode.
Try to finish the symbol, or indent the line."
  (interactive "*P")
  (cond
   ((and (not (looking-at "[A-Za-z0-9]"))
         (save-excursion
           (forward-char -1)
           (looking-at "[A-Za-z0-9:>_\\-\\&\\.(){}\\*\\+/]")))
         (dabbrev-expand arg))
   (t
    (if (eq kde-tab-behavior 'default)
	(c-indent-command)
      (save-excursion
	(beginning-of-line)
	(c-indent-command))))))

(defun agulbra-delete-into-nomenclature (&optional arg)
  "Delete forward until the end of a nomenclature section or word.
With arg, do it arg times."
  (interactive "p")
  (save-excursion
    (let ((b (point-marker)))
      (c-forward-into-nomenclature arg)
      (delete-region b (point-marker)))))

(c-add-style "kde-c" '("stroustrup"
		       (c-basic-offset . 4)
		       (c-offsets-alist
			(case-label . 4)
			(access-label . -)
			(label . 0)
			(statement-cont . c-lineup-math)
			)))

(c-add-style "kde-c++" `("kde-c"
			 (if (not (eq kde-tab-behavior 'indent))
			     (c-tab-always-indent . nil))
					; (insert-tab-mode nil)
			 (indent-tabs-mode . nil)
			 (c-access-key . ,kde-access-labels)
			 (c-opt-access-key . ,kde-access-labels)
			 (c-offsets-alist . ((case-label . 0)
					     (inline-open . 0)))
			 ))

(defun kde-c++-mode-hook ()
  (c-set-style kde-c++-style)
  (font-lock-mode)
  (define-key c++-mode-map "\C-m"  'c-context-line-break)
  (when (or
	 (eq kde-tab-behavior 'default)
	 (eq kde-tab-behavior 'abbrev-indent))
    (define-key c++-mode-map "\C-i" 'agulbra-c++-tab))
  (define-key c++-mode-map "\ef" 'c-forward-into-nomenclature)
;;   (define-key c++-mode-map "\ed" 'agulbra-delete-into-nomenclature)
  (define-key c++-mode-map "\eb" 'c-backward-into-nomenclature)
  ;; fontify "public|protected|private slots" with one and the same face :)
  ;; NOTE: write face-at-point function to fontify those just like other
  ;; access specifiers
  (font-lock-add-keywords nil '(("\\<\\(\\(public\\|protected\\|private\\) slots\\)\\>"
				 . font-lock-reference-face)))
  ;; Add (setq magic-keys-mode nil) to your .emacs (before loading this file)
  ;; to disable the magic keys in C++ mode.
  (and (boundp 'magic-keys-mode) magic-keys-mode
       (progn
	 (define-key c++-mode-map "\(" 'insert-parens)
	 (define-key c++-mode-map "\)" 'insert-parens2)
	 (define-key c++-mode-map "\," 'insert-comma)
	 (define-key c++-mode-map "\{" 'insert-curly-brace)
	 ))
  )

(defun kde-c-mode-hook ()
  (font-lock-mode)
  (define-key c-mode-map [(f6)] 'kde-switch-cpp-h)
  (c-set-style kde-c-style))

;; (add-hook 'c++-mode-hook 'kde-c++-mode-hook)
;; (add-hook 'c-mode-hook 'kde-c-mode-hook)
; always end a file with a newline
(setq-default require-final-newline t)
; 'next-line won't be adding newlines
(setq-default next-line-add-newlines nil)

(global-set-key [(control %)] 'match-paren) ;;for all buffers :)
(if kde-emacs-newline-semicolon
    (define-key c++-mode-map "\;" 'insert-semicolon))
(define-key c++-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c-mode-map [(f6)] 'kde-switch-cpp-h)
(define-key c++-mode-map [(f7)] 'switch-to-function-def)
(define-key global-map [(meta n)] 'next-error)

(define-key global-map [(control backspace)] 'backward-kill-word)
(define-key global-map [(control delete)] 'kill-word)
(define-key global-map [(control prior)] 'beginning-of-buffer)
(define-key global-map [(control next)] 'end-of-buffer)

