;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Setting for Jave Programming Environment.
;;

;; Sets the basic indentation for Java source files
;; to two spaces.

(setq-default indent-tabs-mode nil)
(defun fill-column-hook () (setq fill-column 80)) ; use 80 column width
(defun comment-column-hook () (setq comment-column 40)) ; start comments in column 40

(defun my-java-mode-hook ()
  (font-lock-mode)

  ;; --------------------------------------------------
  ;; From kde-c++-mode-hook
  ;; --------------------------------------------------
  (define-key java-mode-map "\C-m"  'c-context-line-break)
  (when (or (eq kde-tab-behavior 'default)
            (eq kde-tab-behavior 'abbrev-indent))
    (define-key java-mode-map "\C-i" 'agulbra-c++-tab))
  (define-key java-mode-map "\ef" 'c-forward-into-nomenclature)
  (define-key java-mode-map "\eb" 'c-backward-into-nomenclature)
  ;; Add (setq magic-keys-mode nil) to your .emacs (before loading this file)
  ;; to disable the magic keys in C++ mode.
  (and (boundp 'magic-keys-mode) magic-keys-mode
       (progn
  ;;        ;; (define-key java-mode-map "\(" 'insert-parens)
  ;;        ;; (define-key java-mode-map "\)" 'insert-parens2)
         (define-key java-mode-map "\," 'insert-comma)
  ;;        (define-key java-mode-map "\{" 'insert-curly-brace)
         ))

  ;; --------------------------------------------------
  ;; My customization
  ;; --------------------------------------------------
  (setq show-trailing-whitespace t)
  ;; (setq c-basic-offset 4)
  ;; (turn-off-auto-fill)
  ;; (setq c-comment-start-regexp "\\(@\\|/\\(/\\|[*][*]?\\)\\)")
  (modify-syntax-entry ?@ "< b" java-mode-syntax-table)
  (local-set-key (quote [C-return]) (quote jde-complete))
)
(add-hook 'java-mode-hook 'my-java-mode-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;+ JDEE settings
;;
;; (setq JDE_LISP_HOME (concat LISP_HOME "/jde/trunk/trunk/jdee/build"))
(setq JDE_LISP_HOME (concat LISP_HOME "/jde/2.4.0.1"))
;; (setq JDE_LISP_HOME (concat LISP_HOME "/jde/trunk"))

; (setq debug-on-error nil)
(add-to-list 'load-path (concat JDE_LISP_HOME "/lisp"))
(add-to-list 'load-path (concat LISP_HOME "/elib-1.0"))

(require 'jde)

;; (setq defer-loading-jde t)
;; (if defer-loading-jde
;;     (progn
;;       (autoload 'jde-mode "jde" "JDE mode." t)
;;       (setq auto-mode-alist
;;             (append
;;              '(("\\.java$" . jde-mode))
;;              auto-mode-alist)))
;;   (require 'jde))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;+ JDEE prj.el template
;;
(defun add_classpath (classpath)
  (cond
   ((stringp classpath)
    (add-to-list 'jde-global-classpath classpath))
   ((listp classpath)
    (setq jde-global-classpath (append jde-global-classpath classpath)))
   ))

(defun add_src_path (src_path)
  (cond
   ((stringp src_path)
    (add-to-list 'jde-sourcepath src_path))
   ((listp src_path)
    (setq jde-sourcepath (append jde-sourcepath src_path)))
   ))

;; progname
;;   -
;;    | src
;;    | test
;;    | bin
;;    | lib


;;;elisp 的一点语法
;;;   '("aaa" "bbb" "ccc" )  与(quote ("aaa" "bbb" "ccc"))同
;;;   将 "aaa" 变成 '(aaa)  使用 (list "aaa")     '("aaa" "bbb" ) 变成 '("aaa" "bbb" "ccc")的语法 (append  _listname  string    );;;    (setq var value)  与 '(var value) 同为设值

;;在编辑java 文件时 Ctrl+return 代码提示
;; (defun my-java-jde-mode-hook()
;;   (local-set-key (quote [C-return]) (quote jde-complete));;java jde 自动补全键C-return
;;     )
;; (add-hook 'java-mode-hook 'my-java-jde-mode-hook)
