;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; _+ Tabbar mode
;;

(require 'tabbar)
(setq tabbar-buffer-groups-function 'tabbar-buffer-ignore-groups)

(defun tabbar-buffer-ignore-groups (buffer)
  "Return the list of group names BUFFER belongs to.
Return only one group for each buffer."
  (with-current-buffer (get-buffer buffer)
    (cond
     ((or (get-buffer-process (current-buffer))
          (memq major-mode
                '(comint-mode compilation-mode)))
      '("Process")
      )
     ((member (buffer-name)
              '("*scratch*" "*Messages*" "*grep*"))
      '("Common")
      )
     ((eq major-mode 'org-mode)
      '("Org")
      )
     ((eq major-mode 'dired-mode)
      '("Dired")
      )
     ((eq major-mode 'emacs-lisp-mode)
      '("Lisp")
      )
     ((eq major-mode 'xml-mode)
      '("Xml")
      )
     ((memq major-mode '(jde-mode java-mode))
      '("Java")
      )
     ((eq major-mode 'cc-mode)
      '("C/C++")
      )
     ((memq major-mode '(help-mode apropos-mode Info-mode Man-mode))
      '("Help")
      )
     ((memq major-mode
            '(rmail-mode
              rmail-edit-mode vm-summary-mode vm-mode mail-mode
              mh-letter-mode mh-show-mode mh-folder-mode
              gnus-summary-mode message-mode gnus-group-mode
              gnus-article-mode score-mode gnus-browse-killed-mode))
      '("Mail")
      )
     (t
      (list
       "default"  ;; no-grouping
       (if (and (stringp mode-name) (string-match "[^ ]" mode-name))
           mode-name
         (symbol-name major-mode)))
      )

     )))

;; (set-face-attribute 'tabbar-default-face nil :background "gray60" :family "helvetica")
;; (set-face-attribute 'tabbar-unselected-face nil :background "gray85" :foreground "gray30" :box '(:line-width 2 :color "grey75" :style released-button))
;; (set-face-attribute 'tabbar-selected-face nil :background "#f2f2f6" :foreground "black" :box '(:line-width 2 :color "grey75" :style pressed-button) :weight 'bold)
;; (set-face-attribute 'tabbar-button-face nil :box '(:line-width 1 :color "gray72" :style released-button))
;; (set-face-attribute 'tabbar-separator-face nil :height 0.7)

(tabbar-mode 1)
(define-key global-map [(alt j)] 'tabbar-backward)
(define-key global-map [(alt k)] 'tabbar-forward)
