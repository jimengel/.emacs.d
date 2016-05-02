
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa"     . "http://melpa.milkbox.net/packages/"))

(load-theme 'solarized-dark t)

(require 'server)
(unless (server-running-p) (server-start))

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

(global-set-key [S-f1] 'switch-to-next-buffer)
(global-set-key [C-f1] 'switch-to-previous-buffer)
(global-set-key [\e c] 'copy-region-as-kill)

(fset 'kill-buffer-noprompt
   [24 107 return])
(global-set-key [f3] 'kill-buffer-noprompt)
