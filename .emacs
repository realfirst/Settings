(setq use-org-mode t)
(load-file (expand-file-name "~/Settings/Emacs/emacs.el"))

(setq user-full-name "Liu Yen-Liang (Josh)")
(setq user-mail-address "yenliangl@gmail.com")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom variable and faces
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default-input-method "chinese-zozy")
 '(jde-jdk-registry (quote (("Sun JDK6" . "/usr/lib/jvm/java-6-sun"))))
 '(jde-sourcepath (quote ("~/workspace/Android/frameworks/base/core/java" "~/workspace/Android/frameworks/policies/base/phone" "~/workspace/Android/frameworks/base/services/java/")))
 )

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(when window-system
  (progn
    (set-fontset-font "fontset-default"
                      'han '("MingLan" . "unicode-bmp"))))

(menu-bar-mode -1)

;; (remove-hook 'before-save-hook 'delete-trailing-whitespace)


;; customize compile mode for StarRC
;;     main.C  Master.hier  Master.make
(add-hook 'c++-mode-hook
          (lambda ()
            ;; (unless (or (file-exists-p "main.C")
            ;;             (file-exists-p "Master.hier")
            ;;             (file-exists-p "Master.make"))
            (set (make-local-variable 'compile-command)
                 (concat "synmake -C " default-directory)
                 )
            ))
