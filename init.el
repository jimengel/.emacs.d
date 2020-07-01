;;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs
;; initialization from Emacs lisp embedded in literate Org-mode files.

;; Load up Org Mode and (now included) Org Babel for elisp embedded in
;; Org Mode files

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

(let* ((org-dir (expand-file-name
                 "lisp" (expand-file-name
                         "org" (expand-file-name
                                "src" dotfiles-dir))))
       (org-contrib-dir (expand-file-name
                         "lisp" (expand-file-name
                                 "contrib" (expand-file-name
                                            ".." org-dir))))
       (load-path (append (list org-dir org-contrib-dir)
                          (or load-path nil))))

  ;; load up Org-mode and Org-babel
  (require 'org-install)
  (require 'ob-tangle)
  )

;; Load any libraries (anything in extras/*.org) first, so
;; we can use it in our own files
(setq init-extras-dir (expand-file-name "extras" dotfiles-dir))
(setq init-extras-files (directory-files init-extras-dir t "\\.org$"))

(defun init-literal-load-file (file)
  "Load an org file from ~/.emacs.d/extras - assuming it contains
code blocks which can be tangled"
  (org-babel-load-file (expand-file-name file
                                         init-extras-dir)))

(mapc #'init-literal-load-file init-extras-files)


(add-to-list 'load-path init-extras-dir)

;;cl-lib-highlight

;; load up all literate org-mode files in this directory
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(markdown-mode restart-emacs magit-gh-pulls magit ztree yasnippet workgroups2 workgroups web-mode w3m solarized-theme pdf-tools neotree muse moz-controller jabber info+ helm-swoop helm-dash google-maps esup e2wm dash-at-point color-theme-sanityinc-solarized auto-complete adoc-mode ac-js2)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-fine-diff-B ((t (:background "blue"))))
 '(org-table ((((class color) (min-colors 88) (background dark)) (:foreground "gray16"))))
 '(region ((t (:foreground "firebrick4" :inverse-video t :slant italic :weight extra-bold :height 1.1))))
 '(web-mode-html-tag-face ((t (:foreground "cyan")))))
