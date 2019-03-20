;; -*- eval: (read-only-mode 1) -*-

;; ~/.emacs.d/config.el -- Emacs configurations

;; Generated by Emacs Modular Configuration version 0.1
;; DO NOT EDIT THIS FILE.
;; Edit the files under '~/.emacs.d/config' directory tree, 
;; then run within emacs 'M-x emc-merge-config-files'

;; ############################################################################
;; Config file: ~/.emacs.d/config/autocomplete.el
;;; auto-complete ---- configuration for autocompletion using auto-complete

;;; Commentary:

;;; Code:
(use-package auto-complete
  :ensure t
  :defer t
  :config
  (ac-config-default)

  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")

  (add-to-list 'ac-modes 'terraform-mode)

  (setq ac-use-menu-map t)
  (setq ac-menu-height 20)
  (setq ac-auto-show-menu 0.3)
  (setq ac-use-fuzzy t)
  (setq ac-disable-faces nil)
  )

;; Hack. ac-dabbrev.el is placed at lisp/ac-dabbrev.el
(require 'ac-dabbrev)
(add-to-list 'ac-sources 'ac-source-dabbrev)

(provide 'autocomplete)
;;; autocomplete.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/company.el
;;; company --- configuration for autcompletion using company-mode

;;; Commentary:

;;; Code:
;; (use-package company
;;   :ensure t
;;   )

;; (add-hook 'after-init-hook 'global-company-mode)

;; (provide 'company)
;;; company.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/editor.el
;;; editor --- configuration for emacs editor.

;;; Commentary:

;;; Code:

(server-start)

(setq column-number-mode t)

(blink-cursor-mode 0)

(savehist-mode t)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; Tab behaviour
(setq-default c-basic-offset 4)
(setq tab-width 4)
(setq tab-always-indent 'complete)
(setq-default indent-tabs-mode nil)

;; Scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Don't accelerate scrolling
(setq mouse-wheel-progressive-speed nil)

;; Scroll window under mouse
(setq mouse-wheel-follow-mouse 't)

(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq scroll-margin 1
      scroll-conservatively 0
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01)

;; Hide Scroll Bar
(scroll-bar-mode -1)

;; Hide Tool Bar
(tool-bar-mode -1)

;; Hide Menu Bar
(menu-bar-mode -1)

;; Colour theme
;; (use-package darktooth-theme
;;   :ensure t
;;   :config
;;   (load-theme 'darktooth))

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material t))


;; #################################################
;; Custom key bindings

;; Bind M-x to smex
;; (use-package smex
;;   :ensure t
;;   :config
;;   (global-set-key (kbd "M-x") 'smex))


;; Backspace settings
(global-set-key (kbd "C-?") 'help-command)
;; (global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)


;; Rename both file and buffer
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(global-set-key (kbd "C-x C-r") 'rename-file-and-buffer)

(global-set-key (kbd "C-c d") 'delete-trailing-whitespace)

(global-auto-revert-mode t)

(use-package fill-column-indicator
  :ensure t
  :functions turn-on-fci-mode
  :defer t
  :config
  (setq fci-rule-column 120)
  (turn-on-fci-mode))

(setq visible-bell 'nil)
(setq ring-bell-function 'ignore)

(toggle-truncate-lines 1)

(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        (forward-line)))

(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)

(set-face-attribute 'default nil :height 115)
(set-face-attribute 'default nil :width 'normal)
(set-face-attribute 'default nil :weight 'normal)

(provide 'editor)
;;; editor.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/erlang.el
;;; erlang --- configuration for erlang

;;; Commentary:

;;; Code:

(setq-default erlang-root-dir "/usr/local/bin")


(add-hook 'erlang-mode-hook (lambda () (electric-indent-local-mode -1)))

(add-hook 'erlang-mode-hook 'erlang-setup
          (defun erlang-setup ()
            'auto-complete-mode 1
            (setq-default erlang-electric-semicolon-insert-blank-lines 1)
            (setq-default erlang-argument-indent 4)))

;;; erlang.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/go.el
;;; go --- configuration for golang

;;; Commentary:

;;; Code:

(use-package exec-path-from-shell
  :ensure t
  :defer t
  :functions exec-path-from-shell-copy-env
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "GOROOT")
    (exec-path-from-shell-copy-env "GOPATH")))


(use-package go-mode
  :ensure t
  :defer t
  :mode "\\.go\\'"
  :config
  (setq gofmt-command "gofmt")

  (defun goimports-fmt ()
    "Hack to use goimports to auto add/remove unsued imports."
    (interactive)
    (setq gofmt-command "goimports")
    (gofmt)
    (setq gofmt-command "gofmt"))

  (defun go-mode-setup ()
    "Enable configurations for go."
    (add-hook 'before-save-hook 'gofmt-before-save)
    (add-hook 'go-mode-hook (lambda () (local-set-key (kbd "C-.") 'godef-jump)))
    (add-hook 'go-mode-hook (lambda () (local-set-key (kbd "C-u C-.") 'godef-jump-other-window)))
    (add-hook 'go-mode-hook (lambda () (local-set-key (kbd "C-,") 'xref-pop-marker-stack)))
    (add-hook 'go-mode-hook (lambda () (local-set-key (kbd "C-c v") 'goimports-fmt)))
    (set-register ?e "if err != nil {
		return err
	}")
    (set-fill-column 100))

  (add-hook 'go-mode-hook 'go-mode-setup))

(use-package go-eldoc
  :ensure t
  :defer t
  :config
  (go-eldoc-setup))


(use-package go-autocomplete
  :ensure t
  :defer t
  :config
  (require 'auto-complete-config)
  (ac-config-default))

(use-package golint
  :ensure t
  :defer t)

(use-package go-guru
  :ensure t
  :defer t)

(use-package go-playground
  :ensure t
  :defer t)


(provide 'go)
;;; go.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/helm.el
;;; helm --- configuration for navigating in emacs.

;;; Commentary:

;;; Code:

;; Config from http://tuhdo.github.io/helm-intro.html
;; I have some personaltweaks here.
(use-package helm
  :ensure t
  :defer t
  :functions helm-autoresize-mode
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)

         ("C-c SPC" . helm-all-mark-rings)
         ("C-x b" . helm-mini)

         ("C-x C-f" . helm-find-files)
         ("C-c m" . helm-command-prefix)

         :map helm-command-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-i" . helm-execute-persistent-action)
         ("g" . helm-grep-do-git-grep)

         :map helm-read-file-map
         ("<backspace>" . dwim-helm-find-files-up-one-level-maybe)
         ("DEL" . dwim-helm-find-files-up-one-level-maybe)
         ("<return>" . helm-execute-persistent-action)
         ("RET" . helm-execute-persistent-action)

         :map helm-find-files-map
         ("<backspace>" . dwim-helm-find-files-up-one-level-maybe)
         ("DEL" . dwim-helm-find-files-up-one-level-maybe)
         ("<return>" . helm-execute-persistent-action)
         ("RET" . helm-execute-persistent-action)
         :map helm-map
         ("<return>" . helm-maybe-exit-minibuffer)
         ("RET" . helm-maybe-exit-minibuffer))

  :config
  (require 'helm-config)
  (global-unset-key (kbd "C-x c"))
  (setq helm-split-window-inside-p t
        helm-ff-file-name-history-use-recentf t

        helm-ff-skip-boring-files t

        helm-scroll-amount 8
        helm-autoresize-max-height 25
        helm-autoresize-min-height 1)

  (helm-autoresize-mode t)

  (setq helm-locate-fuzzy-match t
        helm-M-x-fuzzy-match t
        helm-lisp-fuzzy-completion t
        helm-apropos-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        ;; helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t)

  ;; Make helm-find-files behave like ido-find-file
  ;; https://github.com/hatschipuh/ido2helm#file-navigation
  (defun dwim-helm-find-files-up-one-level-maybe ()
    (interactive)
    (if (looking-back "/" 1)
        (call-interactively 'helm-find-files-up-one-level)
      (delete-backward-char 1)))

  (defun dwim-helm-find-files-navigate-forward (orig-fun &rest args)
    "Adjust how helm-execute-persistent actions behaves, depending on context"
    (if (file-directory-p (helm-get-selection))
        (apply orig-fun args)
      (helm-maybe-exit-minibuffer)))

  (advice-add 'helm-execute-persistent-action
              :around #'dwim-helm-find-files-navigate-forward)

  ;; (semantic-mode 1)

  (helm-mode 1))

;; helm-flycheck
(use-package helm-flycheck
  :ensure t
  :defer t
  :bind ("C-c f" . helm-flycheck)
  :config
  (global-flycheck-mode t))

;; helm-swoop
;; (use-package helm-swoop
;;   :ensure t
;;   :bind ("C-s" . helm-swoop)
;;   :config
;;   (setq helm-swoop-split-with-multiple-windows t
;;         helm-swoop-use-fuzzy-match t)
;;   )


(use-package ag
  :ensure t
  :defer t)
(use-package helm-ag
  :ensure t
  :defer t)

(provide 'helm)
;;; helm.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/ledger.el
;;; ledger --- configuration for ledger-mode.

;;; Commentary:

;;; Code:

;; (autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
;; (add-to-list 'load-path
;;              (expand-file-name "/path/to/ledger/source/lisp/"))
;; (add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(use-package ledger-mode
  :ensure t
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode)))

;;; ledger.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/magit.el
;;; magit ---- configuratio for magit

;;; Commentary:

;;; Code:

(use-package magit
  :ensure t
  :defer t
  :bind (("C-c i" . magit-status))
  :config
  (setq magit-diff-refine-hunk t)
  )

;;; magit.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/misc.el
;;; misc --- configuration too tiny to deserve its own file. Kitchen sink.

;;; Commentary:

;;; Code:

(use-package restart-emacs
  :ensure t
  :defer t)

(use-package ssh-config-mode
  :ensure t
  :defer t)

(use-package dockerfile-mode
  :ensure t
  :defer t)

(setq-default js-indent-level 2)

(use-package abbrev
  :diminish abbrev-mode
  :defer t
  :config
  ;; stop asking whether to save newly added abbrev when quitting emacs
  (setq save-abbrevs nil)
  (setq-default abbrev-mode t)

  (define-abbrev-table 'global-abbrev-table
    '(
      ;; math/unicode symbols
      ("8N" "ℕ")
      ("8R" "ℝ")
      ("8Sig" "Σ")
      ("8bot" "⟂")
      ("8gam" "Γ")
      ("8in" "∈")
      ("8inf" "∞")
      ("8inr" "₹")
      ("8lam" "λ")
      ("8lar" "←")
      ("8luv" ":hearts:")
      ("8meh" "¯\\_(ツ)_/¯")
      ("8nin" "∉")
      ("8no" ":x:")
      ("8ok" "✓")
      ("8rar" "→")
      ("8rs" "₹")
      ("8sig" "σ")
      ("8smly" ":relaxed:")
      ("8star" "★")
      ("8t" "#+TITLE:")
      ("8tau" "τ")

      ;; email
      ("8me" "indradhanush.gupta@gmail.com")
      ("8i" "Indradhanush Gupta")

      ;; normal english words
      ("8alt" "alternative")
      ("8char" "character")
      ("8def" "definition")
      ("8bg" "background")
      ("8kb" "keyboard")
      ("8ex" "example")
      ("8env" "environment")
      ("8var" "variable")
      ("8cp" "computer")

      ;; Common words and phrases used in day to day programming
      ("8hw" "Hello, World!")
      ("8emacs" "/home/dhanush/.emacs.d/")
      ("8volk" "/home/dhanush/kinvolk/")
      ("8godev" "/home/dhanush/go/src/github.com/"))))

(provide 'misc)
;;; misc.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/modeline.el
;;; modeline --- configuration for modeline customizations

;;; Commentary:

;;; Code:


;; Custom mode-line settings. Just some of my own tweaks added to
;; content form http://emacs-fu.blogspot.in/2011/08/customizing-mode-line.html
;; use setq-default to set it for /all/ modes
(setq-default mode-line-format
  (list
    ;; the buffer name; the file name as a tool tip
    '(:eval (propertize " %b " 'face 'font-lock-keyword-face
        'help-echo (buffer-file-name)))

    ;; line and column
    "(" ;; '%02' to set to 2 chars at least; prevents flickering
      (propertize "%02l" 'face 'font-lock-type-face) ","
      (propertize "%02c" 'face 'font-lock-type-face)
    ") "

    '(which-function-mode ("" which-func-format "--"))

    ;; relative position, size of file
    "["
    (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
    "/"
    (propertize "%I" 'face 'font-lock-constant-face) ;; size
    "] "

    ;; the current major mode for the buffer.
    "["

    '(:eval (propertize "%m" 'face 'font-lock-string-face
              'help-echo buffer-file-coding-system))
    "] "


    "[" ;; insert vs overwrite mode, input-method in a tooltip
    '(:eval (propertize (if overwrite-mode "Ovr" "Ins")
              'face 'font-lock-preprocessor-face
              'help-echo (concat "Buffer is in "
                           (if overwrite-mode "overwrite" "insert") " mode")))

    ;; was this buffer modified since the last save?
    '(:eval (when (buffer-modified-p)
              (concat ","  (propertize "Mod"
                             'face 'font-lock-warning-face
                             'help-echo "Buffer has been modified"))))

    ;; is this buffer read-only?
    '(:eval (when buffer-read-only
              (concat ","  (propertize "RO"
                             'face 'font-lock-type-face
                             'help-echo "Buffer is read-only"))))
    "] "

    '(vc-mode vc-mode)
    ;; add uptime
    " "
    ;; '(:eval (propertize (emacs-uptime "Uptime:%d days")
    ;;          'face 'font-lock-preprocessor-face
    ;;          ))

    " --"
    ;; i don't want to see minor-modes; but if you want, uncomment this:
    ;; minor-mode-alist  ;; list of minor modes
    "%-" ;; fill with '-'
    ))


(provide 'modeline)
;;; modeline.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/navigation.el
;;; navigation --- configuration for navigating in emacs.

;;; Commentary:

;;; Code:

;; Key bindings for window navigation.
(global-set-key (kbd "s-p") `windmove-up)
(global-set-key (kbd "s-n") `windmove-down)
(global-set-key (kbd "s-f") `windmove-right)
(global-set-key (kbd "s-b") `windmove-left)

;; This makes sense because s-' is bound to next-multiframe-window
(global-set-key (kbd "s-;") `previous-multiframe-window)

;; Buffer navigation.
(global-set-key (kbd "C-c n") 'next-buffer)
(global-set-key (kbd "C-c p") 'previous-buffer)
(global-set-key (kbd "s-u") 'revert-buffer)

;; Custom key-bindings for switching between frames to match OSX
;; shortcut of switching between windows of the same application.
(global-set-key (kbd "M-`") 'ns-next-frame)
(global-set-key (kbd "M-~") 'ns-prev-frame)

;; show-paren-mode customizations
(setq show-paren-style 'mixed)
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Smartparens
(use-package smartparens
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "M-s-f") 'sp-forward-sexp)
  (global-set-key (kbd "M-s-b") 'sp-backward-sexp))

(global-set-key (kbd "M-s-a") 'beginning-of-defun)
(global-set-key (kbd "M-s-e") 'end-of-defun)

(global-subword-mode 1)

;; Yafolding
(use-package yafolding
  :ensure t
  :defer t
  :config
  (global-set-key (kbd "C-c h") 'yafolding-hide-element)
  (global-set-key (kbd "C-c s") 'yafolding-show-element)
  (global-set-key (kbd "C-c M-h") 'yafolding-hide-all)
  (global-set-key (kbd "C-c M-s") 'yafolding-show-all))

;; Multiple Line Edit mode.
(require 'multiple-line-edit)

;; Key bindings for multiple-line-edit mode.
(global-set-key (kbd "C-c e") 'mulled/edit-trailing-edges)
(global-set-key (kbd "C-c a") 'mulled/edit-leading-edges)

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind (("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))

(use-package find-file-in-repository
  :ensure t
  :defer t
  :bind ("C-x f" . find-file-in-repository))

(use-package swiper
  :ensure t
  :bind ("C-s" . swiper))

(use-package ivy-hydra
  :ensure t
  :defer t)

(use-package counsel
  :ensure t
  :defer t
  :config
  (setq-default ivy-calling "c")
  :bind ("C-c g" . counsel-git-grep))

(use-package rotate
  :ensure t
  :defer t)

(provide 'navigation)
;;; navigation.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/osx.el
;;; osx --- OSX specific configurations.

;;; Commentary:

;;; Code:

(use-package exec-path-from-shell
  :ensure t
  :defines mac-option-key-is-meta mac-command-key-is-meta mac-command-modifier mac-option-modifier
  :functions exec-path-from-shell-copy-env
  :defer t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-copy-env "PATH")

    ;; Bugfix for Kill a line on OSX; Comment out on Linux.
    (setq save-interprogram-paste-before-kill nil)

    ;; Remap command to behave as Meta and Option as Super.
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier 'super)))

(provide 'osx)
;;; osx.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/python.el
;;; python --- configuration for python

;;; Commentary:

;;; Code:

(use-package python-mode
  :ensure t
  :defer t
  :config
  (require 'python-mode))

(use-package virtualenv
  :ensure t
  :defer t)

(use-package jedi
  :ensure t
  :defer t
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  ;; (jedi:install-server)

  ;; redefine jedi's C-. (jedi:goto-definition)
  ;; to remember position, and set C-, to jump back
  (add-hook 'python-mode-hook
            '(lambda ()
               (local-set-key (kbd "C-.") 'jedi:goto-definition)
               (local-set-key (kbd "C-,") 'jedi:goto-definition-pop-marker)
               ;; (local-set-key (kbd "C-c d") 'jedi:show-doc)
               (local-set-key (kbd "C-<tab>") 'jedi:complete)))
  )

(use-package virtualenvwrapper
  :ensure t
  :defer t
  :defines eshell-prompt-function project-venv-name
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell)
  (setq venv-location "~/.venv/")
  (setq eshell-prompt-function
        (lambda ()
          (concat venv-current-name " $ ")))

  (add-hook 'python-mode-hook
            (lambda () (hack-local-variables)
              (venv-workon project-venv-name)))
  )


(set-register ?i "import ipdb; ipdb.set_trace()")


(use-package pip-requirements
  :ensure t
  :defer t
  :config
  (add-hook 'pip-requirements-mode-hook #'pip-requirements-auto-complete-setup))

(provide 'python)
;;; python.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/startup.el
;;; startup --- configuration for emacs startup

;;; Commentary:

;;; Code:

(server-start)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Ensure that windows like magit-status split vertically instead of horizontally
(setq split-height-threshold nil)

(provide 'startup)
;;; startup.el ends here
;; ############################################################################


;; ############################################################################
;; Config file: ~/.emacs.d/config/terraform.el
;;; terraform --- configuration for terraform-mode


;;; Commentary:

;;; Code:

(use-package terraform-mode
  :ensure t
  :defer t
  :config
  (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
  (add-hook 'terraform-mode-hook
            (lambda () (local-set-key (kbd "C-M-\\") 'terraform-format-buffer))))

;;; terraform.el ends here
;; ############################################################################


;; ~/.emacs.d/config.el ends here
