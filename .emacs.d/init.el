;; Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; First use
(when (not package-archive-contents)
  (package-refresh-contents))

;; Theme
(unless (package-installed-p 'nano-theme)
  (package-install 'nano-theme))
(load-theme 'nano-light t)

(unless (package-installed-p 'nano-modeline)
  (package-install 'nano-modeline))
(nano-modeline-mode)

;; Path
(unless (package-installed-p 'exec-path-from-shell)
  (package-install 'exec-path-from-shell))
(exec-path-from-shell-initialize)

;; Which-key
(unless (package-installed-p 'which-key)
    (package-install 'which-key))
(which-key-mode)

;; ProofGeneral
(unless (package-installed-p 'proof-general)
  (package-install 'proof-general))

;; Startup
(setq inhibit-startup-screen t)

;; MacOS
(when (eq system-type 'darwin)  
  (setq ns-use-native-fullscreen t
        mac-command-modifier 'meta
        mac-option-modifier 'none
        mac-right-option-modifier 'super))

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Auto Generated
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(nano-theme nano-modeline)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
