(setq debug-on-error nil)

;; Don't turn this on unless you are debugging!!
(setq stack-trace-on-error nil)

(unless (featurep 'cedet)
  (load-file (concat EMACS_HOME "/cedet.el")))
(add-to-list 'load-path (concat LISP_HOME "/ecb/2.40"))

;;_+ ECB
(require 'ecb-autoloads)
