(deftheme my-theme
  "Created 2015-02-27.")

(custom-theme-set-variables
 'my-theme
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "31a01668c84d03862a970c471edbd377b2430868eccf5e8a9aec6831f1a0908d" "1297a022df4228b81bc0436230f211bad168a117282c20ddcba2db8c6a200743" default)))
 '(custom-theme-load-path (quote (custom-theme-directory t "/Users/jengel/Downloads/emacs-color-theme-solarized-master")))
 '(jabber-account-list (quote (("jimengel1209@gmail.com" (:password . "m2cy&$LHXeNQ") (:network-server . "talk.google.com") (:connection-type . ssl)))))
 '(menu-prompting nil)
 '(use-dialog-box nil)
 '(use-file-dialog nil)
 '(tool-bar-mode nil))

(provide-theme 'my-theme)
