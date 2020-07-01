;;; lsf.el --- For looking at the jobs you have in the LSF grid

;; Copyright (C) 2018 Jim Engel
;;
;; Author: Jim Engel, Robert Perricone
;; URL: http://github.ibm.com/EDA/lsf.el
;; Package-Version: 20131029.1434
;; Version: 0.1
;; Keywords: lsf jobs batch
;; Created: 2018-12-12
;; Package-Requires: ())

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Interact with LSF from within Emacs, with ease!

;; M-x get-jobs to get started. From there hit C-h b.
;; M-x get-jobs-user to get started. From there hit C-h b.

;;; Installation:

;; Use ELPA. (http://tromey.com/elpa/install.html) ?????????

;; If installing by hand, place on your load path and
;; put this in your init file:

;; (load-file lsf.el)


;;; TODO:


;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(defvar lsf-configs-dir "~/.emacs.d/lsf-configs/"
  "Place to hold the lsf config files used to setup an lsf job"
  )
(defvar lsf-default-queue	 "lowpriority"
  "The default lsf queue"
  )
(defvar lsf-default-project	 "EDA"
  "The default lsf project"
  )
(defvar lsf-default-group	 "eda_timing"
  "The default lsf group"
  )
(defvar lsf-default-numProc	 "1"
  "The default number of cpus"
  )
(defvar lsf-default-numMem	 "1"
  "The default memor size in gb"
  )
(defvar lsf-default-wallTime	 "719:00"
  "The default wall time. 30 days"
  )
(defvar lsf-default-os	         "linux"
  "The default operating system"
  )


(setq lsf-buffer-hash (make-hash-table :test 'equal))



(defun lsf-jobs ( )
  "Get the LSF job for the current user."
  (interactive)

  (use-local-map lsf-mode-map)
  (setq mode-name "lsf")
  (setq major-mode 'lsf-mode)

  (switch-to-buffer "*lsf jobs*")
  (setq buffer-read-only nil)
  (erase-buffer)

  (insert "List of lsf jobs\n")
  (insert "        (K) kill job, (o) detailed job info, (g) refresh\n\n")
  

  
  (setq command (concat "bjobs -o 'jobid: user: stat: queue: from_host: exec_host: job_name: submit_time:15 finish_time:'"))
  (setq output (shell-command-to-string command))
  (insert output)

  (newline 2)

  (setq command (concat "bjobs -sum"))
  (setq output (shell-command-to-string command))
  (insert output)

  (lsf-mode)
  (setq buffer-read-only t)
  
)

(defun lsf-jobs-user ( )
  "Get the LSF job for specified user."
  (interactive)

  (setq theUser      (read-string "Enter the user name: "))
  
  (use-local-map lsf-mode-map)
  (setq mode-name "lsf")
  (setq major-mode 'lsf-mode)

  (setq bufferName (concat "*" theUser " lsf jobs*"))
  
  (switch-to-buffer bufferName)
  (setq buffer-read-only nil)
  (erase-buffer)

  
  (setq command (concat "bjobs -u " theUser " -o 'jobid: user: stat: queue: from_host: exec_host: job_name: submit_time:15 finish_time:'"))
  (setq output (shell-command-to-string command))
  (insert output)

  (newline 2)

  (setq command (concat "bjobs -sum -u " theUser))
  (setq output (shell-command-to-string command))
  (insert output)

  (lsf-mode)
  (setq buffer-read-only t)
  
)


;;(defun job-expire ()
;;  "Get information on when the job will expire."
;;  (interactive)
;;  ;;(setq theRevision (thing-at-point 'word 'no-properties))
;;
;;  (beginning-of-line)
;;  (search-forward " ")
;;  (backward-char 1)
;;  (setq job-number (thing-at-point 'word))
;;  (message job-number)
;;
;;  (switch-to-buffer (concat "*lsf job " job-number "time remaining*"))
;;  (setq buffer-read-only nil)
;;  
;;  (setq command (concat "bjobs -o 'jobid: time_left: finish_time:' " job-number))
;;  (setq output (shell-command-to-string command))
;;  
;;  (insert output)
;;  (setq buffer-read-only t)
;;
;;  )

(defun buf-list ()
  "Get information on when the job will expire."
  (interactive)
  (message "%S" (buffer-list))
  )


(defun lsf-machines ()
  "Get information on the grid. like all machine info, and machine summary."
  (interactive)

  (setq theSearch (read-string "Enter the thing to search for or .*, .* is the default "))
  (if (equal theSearch nil)
      (setq theSearch ".*")
    )
  (switch-to-buffer (concat "*Machine info**"))
  (setq buffer-read-only nil)
  (erase-buffer)
  
  (beginning-of-buffer)
  (setq command "lsload -l  | grep linux | grep xeon | wc -l")
  (setq x86Machines ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep xeon | grep hton | wc -l")
  (setq hton ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep xeon | grep htoff | wc -l")
  (setq htoff ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power8 | wc -l")
  (setq power8Machines ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power8 | grep off | wc -l")
  (setq smt8_0 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power8 | grep smt2 | wc -l")
  (setq smt8_2 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power8 | grep smt4 | wc -l")
  (setq smt8_4 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power8 | grep smt8 | wc -l")
  (setq smt8_8 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power9 | wc -l")
  (setq power9Machines ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power9 | grep off | wc -l")
  (setq smt9_0 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power9 | grep smt2 | wc -l")
  (setq smt9_2 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power9 | grep smt4 | wc -l")
  (setq smt9_4 ( string-trim (shell-command-to-string command)))
  (setq command "lsload -l  | grep linux | grep power9 | grep smt8 | wc -l")
  (setq smt9_8 ( string-trim (shell-command-to-string command)))
  (insert "------------------Summary of Linux Machines------------------\n")
  (insert "Arch      Total      HT_ON      HT_OFF\n")
  (insert (format "x86       %-4s       %-4s       %-4s\n" x86Machines hton htoff))
  (newline 1)
  (insert "Arch      Total      SMT0      SMT2      SMT4      SMT8\n")
  (insert (format "LoP-8     %-4s       %-4s      %-4s      %-4s      %-4s\n" power8Machines smt8_0 smt8_2 smt8_4 smt8_8))
  (insert (format "LoP-9     %-4s       %-4s      %-4s      %-4s      %-4s\n" power9Machines smt9_0 smt9_2 smt9_4 smt9_8))
  (insert "-------------------------------------------------------------\n")
  
  
  (newline 2)
  
  (setq command (concat "lsload -l | grep -E '" theSearch "'"))
  (setq output (shell-command-to-string command))
  (insert output)
  
  (setq buffer-read-only t)
  (beginning-of-buffer)
  
  )



(defun lsf-queues ()
  "Get information on the lsf queues available."
  (interactive)

  (switch-to-buffer (concat "*LSF queue info**"))
  (setq buffer-read-only nil)
  (erase-buffer)

  
  (setq command (concat "bqueues"))
  (setq output (shell-command-to-string command))
  
  (insert output)
  (setq buffer-read-only t)
  (beginning-of-buffer)
  
  )

(defun lsf-qstat ()
  "Get information on the lsf queues usage."
  (interactive)

  (switch-to-buffer (concat "*LSF qstat info**"))
  (setq buffer-read-only nil)
  (erase-buffer)

  
  (setq command (concat "qstat"))
  (setq output (shell-command-to-string command))
  
  (insert output)
  (setq buffer-read-only t)
  (beginning-of-buffer)
  
  )


(defun lsf-job-info ()
  "Get more information on the job."
  (interactive)
  ;;(setq theRevision (thing-at-point 'word 'no-properties))
  (beginning-of-line)
  (search-forward " ")
  (backward-char 1)
  (setq job-number (thing-at-point 'word))
  (message job-number)

  (setq command (concat "bjobs -l " job-number))
;;  (message command1)
  (setq output (shell-command-to-string command))
  
  (switch-to-buffer (concat "*lsf job " job-number "info**"))
  (insert output)
  (setq buffer-read-only t)

  )

(defun lsf-job-kill ()
  "Kill the particular lsf job."
  (interactive)
  ;;(setq theRevision (thing-at-point 'word 'no-properties))
  (beginning-of-line)
  (search-forward " ")
  (backward-char 1)
  (setq job-number (thing-at-point 'word))
  (message job-number)

  (setq command (concat "bkill " job-number))
  (setq output (shell-command-to-string command))
  (message output)

  (setq bufToKill (gethash job-number lsf-buffer-hash))
  ;;(message bufToKill)

  (if (not (equal bufToKill nil))
      (kill-buffer-no-query bufToKill)
    )

  
  (beginning-of-line)
  )

(defun lsf-jobs-kill-region ( startPos endPos )
  "Get a list of job ids within region."
  (interactive "r")
  ;;(message "%S" startPos )
  ;;(message "%S" endPos )
  (save-excursion 
    (goto-char startPos)
    (beginning-of-line)
    (setq job-numbers "")
    (while ( < (point) endPos )
      (setq job-numbers (concat job-numbers " "(thing-at-point 'word)))
      (next-line)
      )
    )
  (message job-numbers)
  (setq command (concat "bkill " job-numbers))
  (deactivate-mark)
  (setq output (shell-command-to-string command))
  (message output)
  
)


(defun lsf-shell ( &optional config )
  "Open a shell with a lsf grid machine in it. If a config name is passed then that will be used.
Otherwise it will prompt based on some defaults"
  (interactive)

  (setq lsf-queue	 lsf-default-queue)
  (setq lsf-project	 lsf-default-project)
  (setq lsf-group	 lsf-default-group)
  (setq lsf-numProc	 lsf-default-numProc)
  (setq lsf-numMem	 lsf-default-numMem)
  (setq lsf-wallTime	 lsf-default-wallTime)
  (setq lsf-osname	 (concat "(osname==" lsf-default-os ")"))
  (setq lsf-type	 " && (type==")
  (setq lsf-htstate	 " && (htstate==smt")
  (setq lsf-cputype	 " && (cputype==")
  (setq lsf-uid 	 (getenv "USER"))
  
  (setq lsf-machType "")
  (setq lsf-machName "")
  (setq lsf-win-name "")



  (if (equal config nil)
      (progn 
	(setq lsf-machType (read-string "Enter machine type x86, lop: "))
  
	(if (string-equal lsf-machType "lop" )
	    (progn
	      (setq lsf-htstate (concat lsf-htstate (read-string "Enter smt value, off, 2, 4, 8: ") ")" ))
	      (setq lsf-cputype (concat lsf-cputype (read-string "Enter machine power8, power9: ") ")"  ))
	      (setq lsf-type    (concat lsf-type "POWER" ")"))
	      (setq lsf-machType "lop")
	      )
	  (progn
	    (setq lsf-htstate "" )
	    (setq lsf-cputype "" )
	    (setq lsf-type  (concat lsf-type "X86_64" ")"))
	    (setq lsf-machType "x86")
	    )
	  )
	
	(setq-local lsf-machDebug (read-string "Debug y/n : "))
	(if (string-equal lsf-machDebug "y" )
	    (progn
	      (setq-local lsf-machName (read-string "Enter the machine name: "))
	      (setq lsf-queue "debug")
	      )
	  ;;    (progn 
	  ;;      (message "Wrong inputs")
	  ;;      (user-error "Wrong inputs")
	  ;;      )
	  )
	(setq lsf-mach-options (concat "select[ " lsf-osname lsf-type lsf-cputype lsf-htstate  "]"))
	)
    (progn
      (load-file (concat lsf-configs-dir config))

      (setq lsf-queue   lsf-form-queue)
      (setq lsf-project lsf-form-project)
      (setq lsf-group   lsf-form-group)
      (setq lsf-numProc lsf-form-cpus)
      (setq lsf-numMem  lsf-form-memory)
      
      (setq lsf-mach-options (concat "select[ " lsf-form-options  "]"))

      )
    )

  (setq lsf-buff-name (concat "*lsf-shell_" lsf-machType "_" (format-time-string "%Y-%m-%d_%T")))

  (message lsf-buff-name)
  
  (setq lsf-bsub-command (concat "bsub -Is -q " lsf-queue " -J " lsf-uid " -G " lsf-group " -P " lsf-project " -n " lsf-numProc " -M " lsf-numMem " -W " lsf-wallTime " -R \"" lsf-mach-options "\" /bin/ksh"))

  (message lsf-bsub-command )

  (add-hook 'comint-output-filter-functions '(lambda ( txt )
					       ;;(message (concat "{{{" txt "}}}"))
					       (if ( string-match "Job <" txt)
						   (progn
						     (setq-local jobId (replace-regexp-in-string "esub.grid Completed" "" txt))
						     (setq-local jobId (replace-regexp-in-string "Job <" "" jobId))
						     (setq-local jobId (string-trim (replace-regexp-in-string ">.*\\\n.*" "" jobId)))
						     ;;(setq-local jobId (replace-regexp-in-string "<<Waiting for dispatch \\.\\.\\.>>" "" jobId))
						     )
						 )
					       (if ( string-match "<<Starting" txt)
						   (progn
						     (setq-local machId (replace-regexp-in-string "<<Starting on " "" txt))
						     (setq-local machId ( string-trim (replace-regexp-in-string ">>" "" machId)))
						     ;;(message (concat "Jobid ---" jobId "---"))
						     ;;(message (concat "Machine ---" machId "---" ))
						     (setq lsf-new-buff-name (concat lsf-buff-name "_" machId "_" jobId "*"))
						     (rename-buffer lsf-new-buff-name)
						     (puthash jobId lsf-new-buff-name lsf-buffer-hash)
						     ;;(rename-buffer (concat machId " " jobId))
						     )
						 )
					       )
	    )
  ;;(add-hook 'comint-output-filter-functions 'lsf-set-buffer-name txt lsf-buff-name  )
  ;;(if (buffer-exists lsf-buff-name)
  ;;    (switch-to-buffer lsf-buff-name)
  ;;  (progn
  ;;   (shell lsf-buff-name)


  
  (if (buffer-exists "*lsf-shell*")
      (switch-to-buffer "*lsf-shell*")
    (progn
     (shell "*lsf-shell*")
     (let* ((proc (get-buffer-process (current-buffer)))
	    (pmark (process-mark proc))
	    (started-at-pmark (= (point) (marker-position pmark))))
       (save-excursion
	 ;;(comint-send-string proc "ssh edamach1.pok.ibm.com\n" )
	 (comint-send-string proc lsf-bsub-command )
	 (comint-send-string proc "\n" )
	 )
       )
     )
    )
  )

;; Mode maps for the different lsf modes. 

(defvar lsf-mode-map nil "keymap for lsf-mode")
;;(define-key lsf-mode-map (kbd "RET") 'open-issue)
(progn
  (setq lsf-mode-map (make-sparse-keymap))
  (define-key lsf-mode-map (kbd "o") 'lsf-job-info)
  (define-key lsf-mode-map (kbd "K") 'lsf-job-kill)
  (define-key lsf-mode-map (kbd "g") 'lsf-jobs)
  )

(define-derived-mode lsf-mode special-mode "lsf"
  "Major mode for interactinve with lsf."
  )


(defvar lsf-config-mode-map nil "keymap for lsf-mode")
;;(define-key lsf-mode-map (kbd "RET") 'open-issue)
(progn
  (setq lsf-config-mode-map (make-sparse-keymap))
  (define-key lsf-config-mode-map (kbd "a") 'lsf-config-form)
  (define-key lsf-config-mode-map (kbd "e") 'lsf-config-edit)
  (define-key lsf-config-mode-map (kbd "D") 'lsf-config-delete)
  (define-key lsf-config-mode-map (kbd "g") 'lsf-configs)
  (define-key lsf-config-mode-map (kbd "s") 'lsf-launch-shell)
  )

(define-derived-mode lsf-config-mode prog-mode "lsf"
  "Major mode for interactinve with lsf config files."
  )


(defun lsf-launch-shell () 
  "Find the name of the config then launch lsf-shell with that info"
  (interactive)

  (save-excursion
    (beginning-of-line)
    (forward-char 1)
    (setq selected-file (thing-at-point 'filename))
    (lsf-shell (concat lsf-configs-dir selected-file))
    ;;(lsf-configs)
    )
  
  )


;; lsf form to gather data from user.
(require 'widget)
     
(eval-when-compile
  (require 'wid-edit))

(defvar widget-example-repeat)

(defun lsf-config-delete () 
  (interactive)

  (save-excursion
    (beginning-of-line)
    (forward-char 1)
    (setq selected-file (thing-at-point 'filename))
    (delete-file (concat lsf-configs-dir selected-file))
    (lsf-configs)
    )
  
  )

(defun lsf-config-form ()
  "LSF parameters."
  (interactive)
  (switch-to-buffer "*LSF Form*")
  (kill-all-local-variables)
  (let ((inhibit-read-only t))
    (erase-buffer))
  (remove-overlays)
  (widget-insert "LSF configuration form\n\n")
  (setq lsf-form-widget-config-name (widget-create 'editable-field
				   :size 40
				   :format "LSF config name   : %v " ; Text after the field!
				   "Name"))
  (widget-insert "\n")
;;  (setq lsf-form-widget-grid (widget-create 'menu-choice
;;				   :tag "Grid              "
;;				   :value "APD"
;;				   '(choice-item "APD")
;;				   '(choice-item "EDA")
;;				   ))
  (setq lsf-form-widget-project (widget-create 'menu-choice
				   :tag "Project           "
				   :value "EDA"
				   '(choice-item "EDA")
				   '(choice-item "LSFTEST")
				   ))
  ;;       (widget-insert "\n")
  (setq lsf-form-widget-group (widget-create 'menu-choice
				 :tag "Group             "
				 :value "eda_libchar"
				 '(choice-item "eda_timing")
				 '(choice-item "eda_libchar")
				 '(choice-item "eda_circuit")
				 '(choice-item "eda_chipbe")
				 '(choice-item "eda_ops")
				 '(choice-item "eda_verif")
				 '(choice-item "eda_vendor")
				 '(choice-item "eda_enablement")
				 '(choice-item "eda_chipfe")
				 ))
  ;;       (widget-insert "\n")
  (setq lsf-form-widget-queue (widget-create 'menu-choice
				 :tag "Queue             "
				 :value "desktop"
				 '(choice-item "desktop")
				 '(choice-item "interactive")   
				 '(choice-item "normal") 
				 '(choice-item "lowpriority")   
				 '(choice-item "debug") 
				 '(choice-item "priority")      
				 '(choice-item "restricted")    
				 '(choice-item "imagetest")  
				 '(choice-item "shadow")   
				 '(choice-item "adminext")      
				 '(choice-item "admin")    
				 '(choice-item "reboot")       
				 '(choice-item "dtws")          
				 '(choice-item "tdsdiag")       
				 '(choice-item "zjenslave")     
				 '(choice-item "zjenwork")   
				 '(choice-item "suspendable")  
				 '(choice-item "susp_xsite") 
				 '(choice-item "DEFAULT")  
				 ;;				      '(editable-field :menu-tag "No option" "Thus option")
				 ))
  ;;       (widget-insert "\n")
  (setq lsf-form-widget-options (widget-create 'editable-field
				   :size 40
				   :format "LSF options       : %v " ; Text after the field!
				    "(osname==linux) && (type==POWER X86_64) && (htstate==off smt2 smt4 smt8) && (cputype==power8 power9)"))
  (widget-insert "\n")
  (setq lsf-form-widget-cpus (widget-create 'editable-field
				:size 5
				:format "Number of cpus    : %v " ; Text after the field!
				"1"))
  (widget-insert "\n")
  (setq lsf-form-widget-memory (widget-create 'editable-field
				  :size 5
				  :format "Memory in GB      : %v " ; Text after the field!
				  "1"))
  (widget-insert "\n")
  (widget-create 'push-button
                 :notify (lambda (&rest ignore)
			   (progn
			     (make-directory lsf-configs-dir t)
			     (setq lsf-config-file-name (concat lsf-configs-dir (widget-value lsf-form-widget-config-name)))
			     (append-to-file (concat "(setq lsf-form-project \"" (widget-value lsf-form-widget-project) "\")\n") nil lsf-config-file-name)
			     (append-to-file (concat "(setq lsf-form-group \"" (widget-value lsf-form-widget-group) "\")\n") nil lsf-config-file-name)
			     (append-to-file (concat "(setq lsf-form-queue \"" (widget-value lsf-form-widget-queue) "\")\n") nil lsf-config-file-name)
			     (append-to-file (concat "(setq lsf-form-options \"" (widget-value lsf-form-widget-options) "\")\n") nil lsf-config-file-name)
			     (append-to-file (concat "(setq lsf-form-cpus \"" (widget-value lsf-form-widget-cpus) "\")\n") nil lsf-config-file-name)
			     (append-to-file (concat "(setq lsf-form-memory \"" (widget-value lsf-form-widget-memory) "\")\n") nil lsf-config-file-name)
 			     (kill-buffer "*LSF Form*")
			     (lsf-configs)
			     )
			   )
  		 "Save Form"
		 )
  (use-local-map widget-keymap)
  (widget-setup)
  )


(defun lsf-config-edit ()
  "Edit the config file at point"
  (interactive)
  (save-excursion
    (beginning-of-line)
    (forward-char 1)
    (setq selected-file (thing-at-point 'filename))

    (load-file (concat lsf-configs-dir selected-file))
    (lsf-config-form) 

    (widget-value-set lsf-form-widget-config-name  selected-file )
    (widget-value-set lsf-form-widget-project  lsf-form-project )
    (widget-value-set lsf-form-widget-group    lsf-form-group   )
    (widget-value-set lsf-form-widget-queue    lsf-form-queue   )
    (widget-value-set lsf-form-widget-options  lsf-form-options )
    (widget-value-set lsf-form-widget-cpus     lsf-form-cpus    )
    (widget-value-set lsf-form-widget-memory   lsf-form-memory  )
    
    )


  )

(defun lsf-configs ()
  "List the existing config if any exist"
  (interactive)

  (make-directory lsf-configs-dir t)
  (setq lsf-config-files (directory-files lsf-configs-dir))
  (message "%S" lsf-config-files)
  
  
  (switch-to-buffer (concat "*lsf-configs*"))
  (setq buffer-read-only nil)
  (erase-buffer)
  
  (insert "List of available lsf config files\n")
  (insert "        (D) delete, (e) edit, (a) add, (s) start\n\n")
  
  (dolist (n lsf-config-files)
    (catch 'aaa
      (if (string-equal n "\.")
	  (throw 'aaa n)
	)
      (if (string-equal n "\.\.")
	  (throw 'aaa n)
	)
      (insert n)
      (insert "\n")
      )
    )
  (lsf-config-mode)
  (setq buffer-read-only t)

  
  )




