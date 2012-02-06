;; ----------------------------------------------------------------------
;; Settings for org-mode
;; ----------------------------------------------------------------------

(require 'org-install)
;;(require 'org-screen)
;;(require 'org-expiry)

;; (make-face 'my-org-fontlock-face)
;; (set-face-attribute 'my-org-fontlock-face nil :family "Monaco" )
(add-hook 'org-mode-hook
          (lambda()
            (font-lock-mode t)
            ;; (buffer-face-mode t)
            ;; (buffer-face-set 'my-org-fontlock-face)
            (imenu-add-to-menubar "Imenu")

            ;; yasnippet
            ;; (make-variable-buffer-local 'yas/trigger-key)
            ;; (setq yas/trigger-key [tab])
            ;; (define-key yas/keymap [tab] 'yas/next-field-group)

            (make-local-variable 'fill-column)
            (setq fill-column 70)

            ;; flyspell mode
            (flyspell-mode 1)))

(if (boundp 'ORG_HOME)
    (setq org-directory ORG_HOME)
  (setq org-directory (expand-file-name "~/Work/Org")))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-completion-use-ido t)
(setq org-support-shift-select t)
;; STARTED = ACTION
;; DONE = FINISHED
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "WAITING(w@)" "SOMEDAY(o!)" "MAYBE(m@/!)" "|" "CANCELLED(c@/!)" "DONE(d@/!)")
        (sequence "BUG(b!)" "ASSIGNED(a!)" "|" "REJECTED(j@/!)" "CLOSED(C@/!)" "FIXED(x@)")
        ))
(setq org-use-fast-todo-selection t)
(setq org-enforce-todo-dependencies t)  ;

;; refile
(setq org-completion-use-ido t)
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 5)
                                 (nil :maxlevel . 5))))
(setq org-refile-use-outline-path (quote file))
(setq org-outline-path-complete-in-steps t)

(setq org-tag-persistent-alist
      '(("Task" . nil)
        ("Note" . nil)

        ;; Study group
        ("Study" . nil)
        (:startgroup . nil)
        ("book" . nil)
        ("paper" . nil)
        ("manual" . nil)
        (:endgroup . nil)

        ;; Location
        ("@India" . nil)
        ("@Taipei" . nil)
        ("@China" . nil)
        ("@Hualien" . nil)
        ("@TPML" . nil)

        ;; Work
        ("Company" . nil)
        (:startgroup . nil)
        ("@alchip" . nil)
        ("@altek" . nil)
        ("@synopsys" . nil)
        (:endgroup . nil)

        ;; Operating systems
        ("Ubuntu" . nil)
        ("Windows" . nil)
        ("MacOSX" . nil)
        ("Unix" . nil)
        ("Android" . nil)
        ("iOS" . nil)

        ;; EDA/VLSI Topics
        ("EDA" . nil)

        ;; Emacs
        ("Emacs" . nil)
        (:startgroup . nil)
        ("org-mode" . nil)
        (:endgroup . nil)

        ;; Emacs
        ("Shell" . nil)
        (:startgroup . nil)
        ("bash" . nil)
        ("tcsh" . nil)
        (:endgroup . nil)

        ("Software" . nil)
        (:startgroup . nil)

        ;; programming language
        ("java" . nil)
        ("cpp" . nil)
        ("tcl" . nil)

        ("synmake" . nil)
        ("gnumake" . nil)
        ("cmake" . nil)
        ("parser" . nil)
        ("designpattern" . nil)
        ("ui" . nil)
        ("font" . nil)
        ("guideline" . nil)
        ("qt" . nil)
        ("performance" . nil)
        ("test" . nil)
        ("debug" . nil)
        ("network" . nil)

        ;; SCM
        ("cvs" . nil)
        ("git" . nil)
        ("subversion" . nil)
        ("perforce" . nil)
        (:endgroup . nil)

        ("Bug" . nil)
        ("Enhancement" . nil)

        ("Presentation" . nil)

        ;;
        ("Personal" . nil)
        ("Shopping" . nil)
        ("Project" . nil)

        ;;
        ("Quote" . nil)
        ("Career" . nil)
        ("Health" . nil)
        ("Exhibition" . nil)
        ("Meeting" . nil)
        ("Conference" . nil)
        ("Seminar" . nil)
        ("Training" . nil)
        ))

(setq org-default-notes-file (concat org-directory "/NOTE.org"))
;; (define-key global-map "\C-cr" 'org-remember)

;; (require 'org-protocol)
(setq org-capture-templates `(("t" "Todo" entry (file+headline (concat org-directory "/TASK.org") "Tasks") "* TODO %? %^g %u %i %a" :prepend t)
                              ("n" "Note" entry (file+headline (concat org-directory "/NOTE.org") "Notes") "* %^{Title}  %^g %? %u %i %a" :prepend t)
                              ("w" "org-protocol" entry (file (concat org-directory "/NOTE.org")) "* TODO Review %c  :NEXT: %U :PROPERTIES: :Effort: 0:10 :END:" :immediate-finish t)))

(define-key global-map "\C-cc" 'org-capture)

(setq org-log-into-drawer "LOGBOOK")
(setq org-log-state-notes-into-drawer "LOGBOOK")
(setq org-clock-persist 'history
      org-clock-persist-file (convert-standard-filename (concat org-directory "/org-clock-save.el"))
      )
(org-clock-persistence-insinuate)

(setq org-agenda-files
      (list org-directory               ;normal org files sync'd with Dropbox
            "~/Org")                    ;files that are not supposed to be cloud sync'd
      )

;; Mark a TODO entry DONE automatically when all children are done
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)    ;turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))
(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)

(require 'org-publish)
(setq org-internal-directory "~/Org")
(setq org-internal-publishing-directory (concat "/ssh:" user-login-name "@starrc01:~/public_html"))
(setq org-publish-project-alist
      `(                                ;use back-quote
        ;; publish to public cloud
        ("org" :components ("org-notes" "org-static" "org-ebooks"))

        ;; publish to internal cloud
        ("org-internal" :components ("org-internal-notes" "org-internal-static"))

        ;; components
        ("org-notes"
         :base-directory ,org-directory
         :base-extension "org"
         :publishing-directory "~/Dropbox/public_html"
         :recursive t
         :publishing-function org-publish-org-to-html
         :plain-source t
         :headline-levels 10
         :htmlized-source t
         :section-numbers nil
         :table-of-contents t
         :style "<link rel=\"stylesheet\" href=\"css/worg.css\" type=\"text/css\"/>"
         :auto-preamble t
         :auto-index t
         :index-filename "sitemap.org"
         :index-title "Sitemap"
         )

        ("org-ebooks"
         :base-directory ,org-directory
         :base-extension "pdf\\|chm"
         :publishing-directory "~/Dropbox/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ("org-static"
         :base-directory ,org-directory
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf\\|mm"
         :publishing-directory "~/Dropbox/public_html/"
         :recursive t
         :publishing-function org-publish-attachment
         )

        ;; for everythings that should be kept away from public
        ("org-internal-notes"
         :base-directory ,org-internal-directory
         :base-extension "org"
         :publishing-directory ,org-internal-publishing-directory
         :recursive t
         :publishing-function org-publish-org-to-html
         :headline-levels 10
         :htmlized-source t
         :section-numbers nil
         :table-of-contents t
         :style "<link rel=\"stylesheet\" href=\"css/worg.css\" type=\"text/css\"/>"
         :auto-preamble t
         :auto-index t
         :auto-sitemap t
         :sitemap-filename "index.html"
         :sitemap-title "Homepage of Liu, Yen-Liang (David)"
         :sitemap-style "tree"
         :tags nil
         )

        ("org-internal-static"
         :base-directory ,org-internal-directory
         :publishing-directory ,org-internal-publishing-directory
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf\\|mm"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ))

;; tasks with dates are scheduled into the future sometime and you don't
;; need to deal with them until the date approaches
(setq org-agenda-todo-ignore-with-date t)
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-skip-timestamp-if-done t)

(setq org-agenda-ndays 7
      org-deadline-warning-days 3
      ;;       org-remember-store-without-prompt nil
      org-agenda-show-all-dates nil
      ;;       remember-annotation-functions (quote (org-remember-annotation))
      ;;       remember-handler-functions (quote (org-remember-handler))
      org-agenda-include-diary nil
      org-use-property-inheritance t
      org-reverse-note-order t
      )

;; (custom-set-variables
;;  '(org-fast-tag-selection-single-key (quote expert))
;;  '(org-remember-store-without-prompt nil)
;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;  '(remember-handler-functions (quote (org-remember-handler))))

(setq org-agenda-custom-commands
      '(("X" agenda    ""        nil ("agenda.html" "agenda.ps"))
        ("Y" alltodo   ""        nil ("todo.html" "todo.txt" "todo.ps"))
        ("S" tags-todo "STUDY"   nil ("study.html" "study.txt" "study.ps"))
        ("F" tags-todo "FINANCE" nil ("finance.html" "finance.txt" "finance.ps"))
        ("E" tags-todo "EMAIL"   nil ("email.html" "email.txt" "email.ps"))

        ("o" "Agenda and Office-related tasks"
         ((agenda "TODO")
          (tags-todo "aspirin")
          (tags "office"))
         nil
         ("~/views/office.ps" "~/calendars/office.ics"))))

;; (setq org-agenda-exporter-settings
;;       '((ps-number-of-columns 2)
;;         (ps-landscape-mode t)
;;         (org-agenda-add-entry-text-maxlines 5)
;;         (htmlize-output-type 'css)))

;; (require 'org-latex)

(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(setq org-clock-history-length 35)
(setq org-clock-in-resume t)
(setq org-clock-in-switch-to-state "STARTED")
(setq org-clock-into-drawer t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-clock-out-when-done t)
(setq org-export-html-inline-images t)

;; Include agenda archive file when searching for things
(setq org-agenda-text-search-extra-files (quote (agenda-archives)))

;; activate highlight-line-mode for aganda view
(add-hook 'org-agenda-mode-hook
          '(lambda ()
             (hl-line-mode 1)))

;; show all future entries for repeating tasks
(setq org-agenda-repeating-timestamp-show-all t)
(setq org-agenda-show-all-dates t)

;; sorting order for tasks on the agenda
(setq org-agenda-sorting-strategy
      (quote ((agenda time-up priority-down effort-up category-up)
              (todo priority-down)
              (tags priority-down))))

;; start the weekly agenda today
(setq org-agenda-start-on-weekday nil)

;; customize display of the time grid
(setq org-agenda-time-grid
      (quote (nil "-------------------------------------"
                  (800 1000 1200 1400 1600 1800 2000))))

;; w3m
;;(require 'org-w3m)
;;(require 'org-wl)

;; invoice support
(autoload 'org-invoice-report "org-invoice")
(autoload 'org-dblock-write:invoice "org-invoice")

(require 'org-habit)

;; encryption
(require 'org-crypt)
                                        ; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
                                        ; Which tag is used to mark headings to be encrypted
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
                                        ; GPG key to use for encryption
(setq org-crypt-key "0C6F5345") ;; yenliangl@gmail.com

;; unique id for every task
(require 'org-id)
(setq org-id-method (quote uuidgen))
;; (add-hook 'org-insert-heading-hook
;;           (lambda () (org-id-get-create))) ;; always add ID for a header section

;; attachments
(setq org-attach-directory (expand-file-name (concat DROPBOX "/Data")))
;;
;; Attachment

(cond ((eq system-type 'cygwin) (setq org-attach-open "cygstart %s"))
      ((eq system-type 'darwin) (setq org-attach-open "open %s"))
      (t (setq org-attach-open "gnome-open")))
(setq org-file-apps
      `((auto-mode . emacs) ("\\.*\\'" . ,org-attach-open)))

;; fontify source block
(setq org-src-fontify-natively t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;_+ Babel
;;

;; (defconst my-org-ditaa-jar-path "~/Jar/ditaa0_9.jar")
;; (if (eq system-type 'cygwin)
;;     (setq org-ditaa-jar-path (shell-command-to-string (concat "cygpath -w " my-org-ditaa-jar-path)))
;;   (setq org-ditaa-jar-path (expand-file-name my-org-ditaa-jar-path)))
;; (setq org-ditaa-jar-path "~/Jar/ditaa0_9.jar")
;;(setq org-plantuml-jar-path "~/java/plantuml.jar")
;;(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)
(setq org-startup-with-inline-images nil)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (ditaa . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (haskell . nil)
   (latex . t)
   (ledger . t)         ;this is the important one for this tutorial
   (ocaml . nil)
   (octave . t)
   (python . t)
   (ruby . t)
   (screen . nil)
   (sh . t)
   (sql . nil)
   (sqlite . t)))

(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))
(add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)
(run-at-time "24:01" nil 'my-org-agenda-to-appt)

(my-org-agenda-to-appt)
(run-at-time "00:59" 3600 'org-save-all-org-buffers) ; save all org-buffers at 1 minute before the hour

(defun org-journal-insert-today-heading ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (widen)
  (let ((today (format-time-string "%Y/%m/%d %a")))
    ;; (beginning-of-buffer)
    (unless (org-goto-local-search-headings today nil t)
      ((lambda ()
         (org-insert-subheading 2)
         ;; (org-insert-heading 2)
         (insert today)
         ;; insert a item '-' for user to get started journaling
         (insert "\n   - "))))))

(defun org-journal-insert-month-heading ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (widen)
  (let ((month (format-time-string "%Y/%m ")))
    ;; (beginning-of-buffer)
    (unless (org-goto-local-search-headings month nil t)
      ((lambda ()
         (org-insert-heading)
         (insert month)
         (insert (concat ":@" (format-time-string "%B") ":"))
         (insert "\n")
         (org-align-all-tags)
         ;; insert first day journal heading
         (org-journal-insert-today-heading)
         )))))

(setq org-agenda-diary-file (concat org-directory "/diary.org")) ;; change this

(defadvice org-agenda-add-entry-to-org-agenda-diary-file
  (after add-to-google-calendar)
  "Add a new Google calendar entry that mirrors the diary entry just created by
org-mode."
  (let ((type (ad-get-arg 0))
        (text (ad-get-arg 1))
        (d1 (ad-get-arg 2))
        (year1 (nth 2 d1))
        (month1 (car d1))
        (day1 (nth 1 d1))
        (d2 (ad-get-arg 3))
        entry dates)
    (if (or (not (eq type 'block)) (not d2))
        (setq dates (format "%d-%02d-%02d" year1 month1 day1))
      (let ((year2 (nth 2 d2)) (month2 (car d2)) (day2 (nth 1 d2)) (repeats (-
                                                                             (calendar-absolute-from-gregorian d1)
                                                                             (calendar-absolute-from-gregorian d2))))
        (if (> repeats 0)
            (setq dates (format "%d-%02d-%02d every day for %d days" year1
                                month1 day1 (abs repeats)))
          (setq dates (format "%d-%02d-%02d every day for %d days" year1 month1
                              day1 (abs repeats))))
        ))
    (setq entry (format "/usr/bin/google calendar add --cal org \'%s %s\'"
                        text dates))
    ;;(message entry)
    (if (not (string= "offline" mail-host-address))
        (shell-command entry)
      (let ((offline "~/tmp/org2google-offline-entries"))
        (find-file offline)
        (goto-char (point-max))
        (insert (concat entry "\n"))
        (save-buffer)
        (kill-buffer (current-buffer))
        (message "Plain text written to %s" offline)))))
(ad-activate 'org-agenda-add-entry-to-org-agenda-diary-file)

;; (setq org-startup-indented nil)

;; Use htmlize. Be sure to check if it uses the latest version
(require 'htmlize)
(setq htmlize-output-type 'css
      htmlize-html-charset "utf-8"
      htmlize-convert-nonascii-to-entities nil)

(setq org-infojs-options
      '((path . "~/scripts/org-info.js")
        (view . "info")
        (view . "info")
        (toc . :table-of-contents)
        (ftoc . "0")
        (tdepth . "max")
        (sdepth . "max")
        (mouse . "underline")
        (buttons . "0")
        (ltoc . "1")
        (up . :link-up)
        (home . :link-home)))
