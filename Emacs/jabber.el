;; ----------------------------------------------------------------------
;;
;; ----------------------------------------------------------------------

(add-to-list 'load-path (concat LISP_HOME "jabber/0.8.0"))

(defun jabber ()
  (interactive)
  (require 'jabber)
  (define-key jabber-chat-mode-map [escape]
    'my-jabber-chat-delete-or-bury)

  (define-key mode-specific-map "jr"
    (lambda ()
      (interactive)
      (switch-to-buffer "*-jabber-*")))

  (define-key mode-specific-map "jc"
    '(lambda ()
       (interactive)
       (call-interactively 'jabber-connect)))

  (define-key mode-specific-map "jd"
    '(lambda ()
       (interactive)
       (call-interactively 'jabber-disconnect)))

  (define-key mode-specific-map "jj"
    '(lambda ()
       (interactive)
       (call-interactively 'jabber-chat-with)))

  (define-key mode-specific-map "ja"
    '(lambda ()
       (interactive)
       (jabber-send-presence "away" "" 10)))

  (define-key mode-specific-map "jo"
    '(lambda ()
       (interactive)
       (jabber-send-presence "" "" 10)))

  (define-key mode-specific-map "jx"
    '(lambda ()
       (interactive)
       (jabber-send-presence "xa" "" 10)))

  (jabber-connect))

;; Google talk
(setq jabber-account-list
    '(("yenliangl@gmail.com"
       (:network-server . "talk.google.com")
       (:connection-type . ssl))))




