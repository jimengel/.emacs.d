
(package-initialize)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("SC"        . "http://joseito.republika.pl/sunrise-commander/") t)
(add-to-list 'package-archives '("user42"    . "http://download.tuxfamily.org/user42/elpa/packages/") t)

;;(load-file "~/.emacs.d/svnRepo/svnRepo.el")
;;(load-file "~/.emacs.d/rtc/rtc.el")
;;(load-file "~/.emacs.d/evernote/evernote-mode.el")
(setq load-path
      (append load-path
             '("~/.emacs.d/elpa/adoc-extension")))

(load-theme 'solarized-dark t)

;;(require 'server)
;;(unless (server-running-p) (server-start))

(require 'web-mode)

(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))

(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
(define-key web-mode-map (kbd "C-f") 'web-mode-fold-or-unfold)
(define-key web-mode-map (kbd "C-'") 'web-mode-mark-and-expand)

(set-face-attribute 'web-mode-html-tag-face nil :foreground "DarkViolet")

(add-to-list 'load-path
             "~/.emacs.d/elpa/yasnippet-0.6.1")
(require 'yasnippet)
;; (yas/initialize)
(yas/load-directory "~/.emacs.d/snippets")

(add-hook 'org-mode-hook
                    (lambda ()
                      (org-set-local 'yas/trigger-key [tab])
                      (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand)))

(defun yas/org-very-safe-expand ()
   (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
                    (lambda ()
                        (make-variable-buffer-local 'yas/vtrigger-key)
                        (setq yas/trigger-key [tab])
                        (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
                        (define-key yas/keymap [tab] 'yas/next-field)))

;;(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)

(defun my-exit-from-emacs ()
  (interactive)
  (if (yes-or-no-p "Are you sure you want to exit ")
      (save-buffers-kill-emacs)))

(global-set-key "\C-x\C-c" 'my-exit-from-emacs)

;; 
;; Customize EMACS/EPOCH window
;;
;;

;; Running-epoch is a better name for the variable that tells us is we are
;; in epoch or not

(defvar running-epoch (boundp 'epoch::version))

(if running-epoch (setq term-file-prefix nil)) ; don't load xterm stuff!
(setq target-buffer (get-buffer "*scratch*"))

(put 'eval-expression 'disabled nil)

(setq auto-save-default 0) ;; Auto save eat shit
(setq auto-save-interval 100000)

(show-paren-mode 1)

(setq large-file-warning-threshold nil)

(put 'scroll-left 'disabled nil)

(setq Info-enable-edit t)
;; Enable recursive commands in the minibuffer
(setq enable-recursive-minibuffers t)

;; Enable numbered backups
(setq version-control nil)

(setq load-path (cons  "/afs/apd.pok.ibm.com/u/jengel/.emacs.d/elpa/erlang"
                       load-path))
(setq erlang-root-dir "/afs/apd/projects/alacrite/alacriteCloud/webSupport/erlang/otp_src_17.1")
(setq exec-path (cons "/afs/apd/projects/alacrite/alacriteCloud/webSupport/erlang/otp_src_17.1/bin" exec-path))
;;(require 'erlang-start)

;;(add-to-list 'load-path "~/.emacs.d/lintnode")
;;(require 'flymake-jslint)
;;(add-hook 'js-mode-hook 'flymake-jslint-load)
;; Make sure we can find the lintnode executable
;;(setq lintnode-location "~/.emacs.d/lintnode")
;; JSLint can be... opinionated
;;(setq lintnode-jslint-excludes (list 'nomen 'undef 'plusplus 'onevar 'white))
;; Start the server when we first open a js file and start checking
;;(add-hook 'js-mode-hook
;;          (lambda ()
;;            (lintnode-hook)))


;;(require 'flymake-jslint)
(add-hook 'js-mode-hook 'flymake-jslint-load)

;; Sets up the indent level for C mode
(setq c-auto-newline '0)
(setq c-indent-level '0)
(setq c-brace-imaginary-offset '4)
(setq c-continued-statement-offset '4)
(setq c-brace-offset '0)
(setq c-label-offset '0)
(setq c-argdecl-indent '0)

;; gdb stuff
(setq gdb-command-name "/usr/local/bin/gdb")

(display-time)

(define-key  global-map [C-up] 'enlarge-window)
(define-key  global-map [C-down] 'shrink-window)
(define-key  global-map [C-left] 'enlarge-window-horizontally)
(define-key  global-map [C-right] 'shrink-window-horizontally)

(global-set-key "\C-x\C-d" 'dired)

(defun beg-window ()
  (interactive)
  (move-to-window-line 0))
(defun end-window ()
  (interactive)
  (move-to-window-line -1))

(define-key  global-map [C-home] 'beg-window)
(define-key  global-map [C-end] 'end-window)
(define-key  global-map [home] 'beginning-of-buffer)
(define-key  global-map [end] 'end-of-buffer)
(global-set-key [f1] 'other-window)
(global-set-key [f10] 'scroll-left)
(global-set-key [f11] 'scroll-right)

(defun up10 ()
  (interactive)
  (previous-line 10))
(defun dn10 ()
  (interactive)
  (next-line 10))

(define-key  global-map [S-up] 'up10)
(define-key  global-map [S-down] 'dn10)

(global-set-key [S-f1] 'switch-to-next-buffer)
(global-set-key [C-f1] 'switch-to-previous-buffer)

(fset 'dup-line
   [1 11 25 return 25])
(global-set-key [f2] 'dup-line)

;;(define-key dired-mode-map (kbd "ESC <delete>") 'dired-unmark-all-marks)

(defun kill-buffer-no-query (&optional buffer)
  "Kill BUFFER without querying."
  (interactive)
  (unless buffer (setq buffer  (current-buffer)))
  (let ((kill-buffer-query-functions ())
        (buffer-save-without-query   t)
        (buffer-modified-p           (buffer-modified-p)))
    (unwind-protect
        (progn (set-buffer-modified-p nil)
               (kill-buffer buffer))
      (when (get-buffer buffer)
        (set-buffer-modified-p buffer-modified-p)))))

(global-set-key [\e c] 'copy-region-as-kill)

(fset 'kill-buffer-noprompt
   [24 107 return])
(global-set-key [f3] 'kill-buffer-no-query)
;;(global-set-key [f3] 'kill-buffer-noprompt)
;;(global-set-key [f3] 'kill-buffer)


(fset 'bring-to-top
   "\C-u1\C-l")
(global-set-key [S-mouse-1] 'bring-to-top)


(setq transient-mark-mode 1)           
(setq scroll-step 1)           
;;(split-window-vertically) 
;;(split-window-horizontally) 
(global-set-key [delete] 'delete-char)
(setq key-translation-map nil)
(substitute-key-definition 'capitalize-word 'copy-region-as-kill esc-map )
(substitute-key-definition 'back-to-indentation 'kill-region esc-map )
(define-key  esc-map [C] 'capitalize-word)

(setq message-log-max nil)
;;(kill-buffer "*Messages*")


(fset 'file
   [24 19 24 107 return])
(global-set-key [f4] 'file)
(global-set-key [f5] 'desktop-save)

(global-set-key [vertical-scroll-bar C-down-mouse-1] 'mldrag-drag-vertical-line)
(global-set-key [mode-line C-down-mouse-1] 'mouse-drag-mode-line)
(global-set-key [mode-line C-mouse-3] 'mouse-delete-window)
(global-set-key [mode-line double-mouse-1] 'bury-buffer)
(global-set-key [mode-line mouse-1] 'mouse-select-window)
(global-set-key [mode-line mouse-2] 'mouse-select-window)
(global-set-key [mode-line mouse-3] 'mouse-select-window)
(global-set-key [mode-line down-mouse-1] 'mouse-select-window)
(global-set-key [C-down-mouse-1] 'mouse-buffer-menu)
(global-set-key [C-down-mouse-3] 'mouse-set-font)

;; ~/alacrite/code
(fset 'code
   [?\C-x ?\C-d ?\C-a ?\C-k ?/ ?a ?f ?s ?/ ?a ?p ?d ?/ ?u ?/ ?j ?e ?n ?g ?e ?l ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?/ ?c ?o ?d ?e return])

;; ~/alacrite/code/alacriteCloud
(fset 'ac
   [?\C-x ?\C-d ?\C-a ?\C-k ?/ ?a ?f ?s ?/ ?a ?p ?d ?/ ?u ?/ ?j ?e ?n ?g ?e ?l ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?/ ?c ?o ?d ?e ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?C ?l ?o ?u ?d return])

;; ~/alacrite/cqIssues
(fset 'cq
   [?\C-x ?\C-d ?\C-a ?\C-k ?/ ?a ?f ?s ?/ ?a ?p ?d ?/ ?u ?/ ?j ?e ?n ?g ?e ?l ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?/ ?c ?q ?I ?s ?s ?u ?e ?s return])

;; /afs/apd/projects/alacrite/alacriteCloud
(fset 'acp
   [?\C-x ?\C-d ?\C-a ?\C-k ?/ ?a ?f ?s ?/ ?a ?p ?d ?/ ?p ?r ?o ?j ?e ?c ?t ?s ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?C ?l ?o ?u ?d return])

;; /afs/apd/projects/alacrite/alacriteCloud
(fset 'dev
   [?\C-x ?\C-d ?\C-a ?\C-k ?/ ?a ?f ?s ?/ ?a ?p ?d ?/ ?p ?r ?o ?j ?e ?c ?t ?s ?/ ?a ?l ?a ?c ?r ?i ?t ?e ?/ ?d ?e ?v ?e ?l ?o ?p ?m ?e ?n ?t return])

(defun lq ()
  (interactive)
  (get-buffer-create "*LIST-QUOTA*")
  (call-process "fs" nil "*LIST-QUOTA*" nil "lq")
  (switch-to-buffer "*LIST-QUOTA*")
)

(defun la ()
  (interactive)
  (get-buffer-create "*LIST-ACL*")
  (call-process "fs" nil "*LIST-ACL*" nil "la")
  (switch-to-buffer "*LIST-ACL*")
)

(defun saw ()
  (interactive)
  (get-buffer-create "*SET-ACL*")
  (call-process "fs" nil "*SET-ACL*" nil "setacl" "-dir" "." "-acl" "jengel" "write")
  (switch-to-buffer "*SET-ACL*")
)

(defun san ()
  (interactive)
  (get-buffer-create "*SET-ACL*")
  (call-process "fs" nil "*SET-ACL*" nil "setacl" "-dir" "." "-acl" "jengel" "none")
  (switch-to-buffer "*SET-ACL*")
)

(autoload 'sqlite-dump "sqlite-dump" nil t)

(defun rename-frame (name)
  (interactive "sNew name of frame: ")
  (setq frame-title-format name)
)

(setq frame-title-format (list "emacs  - " (getenv "LOGNAME") "@" (getenv "HOSTNAME") "  -  " (number-to-string (emacs-pid))))

(defun display-pid ()
  (interactive)
  (message "The PID of emacs is %d" (emacs-pid))
)

(defun set-frame-work ( ) 
  "Sets the frame size to my work monitor 1500x1035"
  (interactive)
  (setq char-height (frame-char-height))
  (setq char-width  (frame-char-width))
  (setq lines (/ 1035 char-height))
  (setq width  (/ 1500 char-width))
  (set-frame-position (selected-frame) 3 3)
  ;;( set-frame-height 20)
  ;;( set-frame-width 40)
  ( set-frame-size (selected-frame) width lines)

)

(defun set-frame-work-hp ( ) 
  "Sets the frame size to my hp monitor 1830x1060"
  (interactive)
  (setq char-height (frame-char-height))
  (setq char-width  (frame-char-width))
  (setq lines (/ 1060 char-height))
  (setq width  (/ 1830 char-width))
  (set-frame-position (selected-frame) 3 3)
  ;;( set-frame-height 20)
  ;;( set-frame-width 40)
  ( set-frame-size (selected-frame) width lines)

)

(defun set-frame-mac ( ) 
  "Sets the frame size to my imac monitor 2400x1300"
  (interactive)
  (setq char-height (frame-char-height))
  (setq char-width  (frame-char-width))
  (setq lines (/ 1300 char-height))
  (setq width  (/ 2400 char-width))
  (set-frame-position (selected-frame) 3 3)
  ;;( set-frame-height 20)
  ;;( set-frame-width 40)
  ( set-frame-size (selected-frame) width lines)

)


(global-set-key [f7]   'set-frame-work)
(global-set-key [S-f7] 'set-frame-mac)
(global-set-key [C-f7] 'set-frame-work-hp)

;;(tool-bar-mode nil nil (tool-bar))
(tool-bar-mode -1)
(menu-bar-mode nil)

(setq x-fixed-font-alist
   '("Font menu"
     ("Mine"
      ("Small-1" "-misc-fixed-*-*-*-*-*-60-*-*-*-*-*-*")
      ("Small-2" "-misc-fixed-*-*-*-*-*-70-*-*-*-*-*-*")
      ("Small-3" "-misc-fixed-*-*-*-*-*-80-*-*-*-*-*-*")
      ("Small-4" "-misc-fixed-*-*-*-*-*-90-*-*-*-*-*-*")
      ("Small-5" "-misc-fixed-*-*-*-*-*-100-*-*-*-*-*-*")
      ("Small-6" "-misc-fixed-*-*-*-*-*-110-*-*-*-*-*-*")
     )
     ("Misc"
      ("Default" "-Adobe-Courier-Medium-R-Normal--12-120-75-75-M-70-ISO8859-1")
      ("fixed" "fixed")
      ("6x10" "-misc-fixed-medium-r-normal--10-*-*-*-c-60-iso8859-1" "6x10")
      ("6x12" "-misc-fixed-medium-r-semicondensed--12-*-*-*-c-60-iso8859-1" "6x12")
      ("6x13" "-misc-fixed-medium-r-semicondensed--13-*-*-*-c-60-iso8859-1" "6x13")
      ("7x13" "-misc-fixed-medium-r-normal--13-*-*-*-c-70-iso8859-1" "7x13")
      ("7x14" "-misc-fixed-medium-r-normal--14-*-*-*-c-70-iso8859-1" "7x14")
      ("8x13" "-misc-fixed-medium-r-normal--13-*-*-*-c-80-iso8859-1" "8x13")
      ("9x15" "-misc-fixed-medium-r-normal--15-*-*-*-c-90-iso8859-1" "9x15")
      ("10x20" "-misc-fixed-medium-r-normal--20-*-*-*-c-100-iso8859-1" "10x20")
      ("11x18" "-misc-fixed-medium-r-normal--18-*-*-*-c-110-iso8859-1" "11x18")
      ("12x24" "-misc-fixed-medium-r-normal--24-*-*-*-c-120-iso8859-1" "12x24")
      ("")
      ("clean 5x8" "-schumacher-clean-medium-r-normal--8-*-*-*-c-50-iso8859-1")
      ("clean 6x8" "-schumacher-clean-medium-r-normal--8-*-*-*-c-60-iso8859-1")
      ("clean 8x8" "-schumacher-clean-medium-r-normal--8-*-*-*-c-80-iso8859-1")
      ("clean 8x10" "-schumacher-clean-medium-r-normal--10-*-*-*-c-80-iso8859-1")
      ("clean 8x14" "-schumacher-clean-medium-r-normal--14-*-*-*-c-80-iso8859-1")
      ("clean 8x16" "-schumacher-clean-medium-r-normal--16-*-*-*-c-80-iso8859-1")
      ("")
      ("sony 8x16" "-sony-fixed-medium-r-normal--16-*-*-*-c-80-iso8859-1")
      ("lucidasanstypewriter-12" "-b&h-lucidatypewriter-medium-r-normal-sans-*-120-*-*-*-*-iso8859-1")
      ("lucidasanstypewriter-bold-14" "-b&h-lucidatypewriter-bold-r-normal-sans-*-140-*-*-*-*-iso8859-1")
      ("lucidasanstypewriter-bold-24" "-b&h-lucidatypewriter-bold-r-normal-sans-*-240-*-*-*-*-iso8859-1"))
     ("Courier"
      ("8" "-adobe-courier-medium-r-normal--*-80-*-*-m-*-iso8859-1")
      ("10" "-adobe-courier-medium-r-normal--*-100-*-*-m-*-iso8859-1")
      ("12" "-adobe-courier-medium-r-normal--*-120-*-*-m-*-iso8859-1")
      ("14" "-adobe-courier-medium-r-normal--*-140-*-*-m-*-iso8859-1")
      ("18" "-adobe-courier-medium-r-normal--*-180-*-*-m-*-iso8859-1")
      ("24" "-adobe-courier-medium-r-normal--*-240-*-*-m-*-iso8859-1")
      ("8 bold" "-adobe-courier-bold-r-normal--*-80-*-*-m-*-iso8859-1")
      ("10 bold" "-adobe-courier-bold-r-normal--*-100-*-*-m-*-iso8859-1")
      ("12 bold" "-adobe-courier-bold-r-normal--*-120-*-*-m-*-iso8859-1")
      ("14 bold" "-adobe-courier-bold-r-normal--*-140-*-*-m-*-iso8859-1")
      ("18 bold" "-adobe-courier-bold-r-normal--*-180-*-*-m-*-iso8859-1")
      ("24 bold" "-adobe-courier-bold-r-normal--*-240-*-*-m-*-iso8859-1")
      ("8 slant" "-adobe-courier-medium-o-normal--*-80-*-*-m-*-iso8859-1")
      ("10 slant" "-adobe-courier-medium-o-normal--*-100-*-*-m-*-iso8859-1")
      ("12 slant" "-adobe-courier-medium-o-normal--*-120-*-*-m-*-iso8859-1")
      ("14 slant" "-adobe-courier-medium-o-normal--*-140-*-*-m-*-iso8859-1")
      ("18 slant" "-adobe-courier-medium-o-normal--*-180-*-*-m-*-iso8859-1")
      ("24 slant" "-adobe-courier-medium-o-normal--*-240-*-*-m-*-iso8859-1")
      ("8 bold slant" "-adobe-courier-bold-o-normal--*-80-*-*-m-*-iso8859-1")
      ("10 bold slant" "-adobe-courier-bold-o-normal--*-100-*-*-m-*-iso8859-1")
      ("12 bold slant" "-adobe-courier-bold-o-normal--*-120-*-*-m-*-iso8859-1")
      ("14 bold slant" "-adobe-courier-bold-o-normal--*-140-*-*-m-*-iso8859-1")
      ("18 bold slant" "-adobe-courier-bold-o-normal--*-180-*-*-m-*-iso8859-1")
      ("24 bold slant" "-adobe-courier-bold-o-normal--*-240-*-*-m-*-iso8859-1"))))

(set-face-background 'region "black")               
(set-face-foreground 'region "cadetblue")                
(set-face-background 'highlight "black")            
(set-face-foreground 'highlight "gray")             
(set-face-background 'secondary-selection "gray")    
(set-face-foreground 'secondary-selection "black")   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-fine-diff-B ((t (:background "blue"))))
 '(org-table ((((class color) (min-colors 88) (background dark)) (:foreground "gray16"))))
 '(region ((t (:foreground "firebrick4" :inverse-video t :slant italic :weight extra-bold :height 1.1))))
 '(web-mode-html-tag-face ((t (:foreground "cyan")))))

(setq ediff-grab-mouse t)
(setq ediff-split-window-function (quote split-window-horizontally))
(setq ediff-window-setup-function (quote ediff-setup-windows-plain))
(winner-mode)
(add-hook 'ediff-after-quit-hook-internal 'winner-undo)

(defun lq ()
  (interactive)
  (get-buffer-create "*LIST-QUOTA*")
  (if (string-equal (substring (expand-file-name default-directory) 0 4) "/afs") 
        (progn 
          (call-process "fs" nil "*LIST-QUOTA*" nil "lq")
          (switch-to-buffer "*LIST-QUOTA*")
          )
        (progn 
          (call-process "gsa" nil "*LIST-QUOTA*" nil "quota" "list" "--path" ".")
          (switch-to-buffer "*LIST-QUOTA*")
          )
        )
)

(defun la ()
  (interactive)
  (get-buffer-create "*LIST-ACL*")
  (if (string-equal (substring (expand-file-name default-directory) 0 4) "/afs") 
        (progn 
          (call-process "fs" nil "*LIST-ACL*" nil "la")
          (switch-to-buffer "*LIST-ACL*")
          )
        (progn 
          (call-process "gsa" nil "*LIST-ACL*" nil "acl" "list" "--path" ".")
          (switch-to-buffer "*LIST-ACL*")
          )
        )
)

(defun saw ()
  (interactive)
  (get-buffer-create "*SET-ACL*")
  (call-process "fs" nil "*SET-ACL*" nil "setacl" "-dir" "." "-acl" "jengel" "write")
  (switch-to-buffer "*SET-ACL*")
)

(defun san ()
  (interactive)
  (get-buffer-create "*SET-ACL*")
  (call-process "fs" nil "*SET-ACL*" nil "setacl" "-dir" "." "-acl" "jengel" "none")
  (switch-to-buffer "*SET-ACL*")
)

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
     (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

(defun count-words-region (start end)
  "Print number of words in the region."
  (interactive "r")
  (message "Region has %d words" (count-words start end)))


(defun count-words (start end)
  "Return number of words between START and END."
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (setq temp 0)
      (while (forward-word 1)
        (setq temp (+ 1 temp)))))
  temp)

(defun count-chars-region (start end)
  "Print number of chars in the region."
  (interactive "r")
  (message "Region has %d chars" (count-chars start end)))

(defun count-chars (start end)
  "Return number of words between START and END."
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (goto-char (point-min))
      (setq temp 0)
      (while (forward-char 1)
        (setq temp (+ 1 temp)))))
  temp)

(require 'adoc-mode)
(add-to-list
  'auto-mode-alist (cons "\\.adoc\\'" 'adoc-mode))
(add-to-list
  'auto-mode-alist (cons "\\.db\\'" 'sqlite-dump))


(autoload 'my-adoc-additions "adoc-extension")
(add-hook 'adoc-mode-hook 'my-adoc-additions)

(setq helm-dash-common-docsets '(Emacs_Lisp))
(setq helm-dash-docsets '(Emacs_Lisp))
;;(setq helm-dash-docsets-path "~/.emacs.d/docsets")

(defun buffer-exists (bufname)  
  (not (eq nil (get-buffer bufname)))
)

(defun shell-cte ( cte-win-name )
  (interactive "sEnter the cte window you wish to open: ")
  (setq buff-name (concat "*" cte-win-name "-cte-shell*"))
  (if (buffer-exists buff-name)
      (switch-to-buffer buff-name)
    (progn
     (shell buff-name)
     (let* ((proc (get-buffer-process (current-buffer)))
            (pmark (process-mark proc))
            (started-at-pmark (= (point) (marker-position pmark))))
       (save-excursion
         (comint-send-string proc "~/bin/cteWin " )
         (comint-send-string proc  cte-win-name)
         (comint-send-string proc "\n")
         (comint-send-string proc "cteAlac")
         (comint-send-string proc "\n")
         )
       )
     )
    )
)

(progn
  ;; "change keybindings for shell related modes."
  (require 'shell)
  ;;  (define-key comint-mode-map (kbd "M-p") 'recenter) ; was comint-previous-input
 ;;  (define-key comint-mode-map (kbd "M-n") 'nil) ; was comint-next-input
 ;;  (define-key comint-mode-map (kbd "M-r") 'kill-word) ; was comint-previous-matching-input
 ;;  (define-key comint-mode-map (kbd "M-s") 'other-window) ; was comint-next-matching-input

   ;; rebind displaced commands that i still want a key
  (define-key comint-mode-map [S-up] 'comint-previous-input)
  (define-key comint-mode-map [S-down] 'comint-next-input)
  (define-key comint-mode-map [C-up] nil)
  (define-key comint-mode-map [C-down] nil)
      
   ;;   (define-key comint-mode-map (kbd "S-<f11>") 'comint-previous-matching-input)
;;   (define-key comint-mode-map (kbd "S-<f12>") 'comint-next-matching-input)
)

(line-number-mode)
