;;; emacs --- My emacs configuration

;;; Commentary:

;;; Code:

(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Install use-package if it is not already installed.
;; Found this from http://cachestocaches.com/2015/8/getting-started-use-package/
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq package-menu-async t)

;; use-package configuration
(require 'use-package)
(setq use-package-verbose t)

;; Directory for storing .el files
(add-to-list 'load-path' "~/.emacs.d/lisp")

;; Store custom-set-variables and custom-set-faces in a separate file
(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

;; Emacs Modular Configuration entry point
;; Currently, each time you make a change in any of the .el files in the directory ~/.emacs.d/config/
;; you need to run M-x emc-merge-config-files
;; Note to self: I want to solve this problem by sending a PR.
(require 'emacs-modular-configuration)

;; Enable commands that are disabled by default
(put 'set-goal-column 'disabled nil)

(load "~/.emacs.d/config")

;; Store backup files in a centralized location
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Allow horizontal scrolling
(put 'scroll-left 'disabled nil)

(provide 'init)
;;; init.el ends here
