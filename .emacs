(require 'package)

(when (>= emacs-major-version 26)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )
  (package-install 'use-package)
(setq package-check-signature nil)

(when (not package-archive-contents)
  (package-refresh-contents))

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))


;; Quelpa to install plugins from github
(use-package quelpa-use-package
  :ensure t
  :init (setq quelpa-update-melpa-p nil)
  :config (quelpa-use-package-activate-advice))

;; Disable startup message
(setq inhibit-startup-message t)

;; Hide the bell in the center of screen
(setq ring-bell-function 'ignore)
(column-number-mode t)
(global-hl-line-mode 1)

;; Hide line numbers on some modes 
(global-display-line-numbers-mode 1)
(add-hook 'notdeft-mode-hook
          (lambda (&optional dummy)
            (display-line-numbers-mode -1)))
(add-hook 'vterm-mode-hook
          (lambda (&optional dummy)
            (display-line-numbers-mode -1)))
(add-hook 'dired-mode-hook
          (lambda (&optional dummy)
            (display-line-numbers-mode -1)))

;; Keybinds
(global-set-key (kbd "C-c t") 'multi-vterm-dedicated-toggle)
(global-set-key (kbd "C-c v t") 'multi-vterm)
(global-set-key (kbd "C-c v p") 'multi-vterm-prev)
(global-set-key (kbd "C-c v n") 'multi-vterm-next)
(global-set-key (kbd "C-c ]") 'counsel-fzf)
(global-set-key (kbd "C-c [") 'counsel-ag)
(global-set-key (kbd "C-c b s") 'counsel-switch-buffer)
(global-set-key (kbd "C-c b o") 'counsel-switch-buffer-other-window)
(global-set-key (kbd "C-c f d") 'counsel-dired)
(global-set-key (kbd "C-c f r") 'counsel-recentf)
(global-set-key (kbd "C-c o c") 'counsel-org-capture)

;; Fix size of scroll
(setq scroll-step 1
      scroll-conservatively  10000)

;; Fira Code setup
(when (window-system)
  (set-frame-font "Fira Code"))
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               ;(46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)"))
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; Spanish Layout
(setq default-input-method "spanish-prefix")

;; Disable backup
(setq backup-inhibited t)

;; Disable auto save
(setq auto-save-default nil)

;; Electric pair
(electric-pair-mode nil)
(setq electric-pair-preserve-balance nil)

;; Copypaste
(setq x-select-enable-clipboard t)

;; Languages support
(use-package web-mode
  :ensure t
  :custom
  (web-mode-enable-current-element-highlight t)
  (web-mode-enable-current-column-highlight t)
  :mode (("\\.html\\'" . web-mode)
         ("\\.html.eex\\'" . web-mode)
         ("\\.html.leex\\'" . web-mode)))

(use-package elixir-mode
  :ensure t
  :config
  (add-hook 'elixir-mode-hook
          (lambda () (add-hook 'before-save-hook 'elixir-format nil t))))


;; Theme & Styles
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-dark+ t))

(use-package doom-modeline
  :ensure t
  :defer t
  :custom
  (doom-modeline-modal-icon t)
  (doom-modeline-height 25)
  (doom-modeline-indent-info t)
  (doom-modeline-github t)
  :config
  (setq doom-modeline-buffer-file-name-style 'relative-to-project)
  (setq doom-modeline-workspace-name t)

  :hook
  (after-init . doom-modeline-mode))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to a new coding session!"
        dashboard-center-content t
        dashboard-startup-banner 'logo
        dashboard-set-footer nil
        dashboard-items '((recents . 10)))
  (dashboard-setup-startup-hook))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode 1)
)
(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'column
        highlight-indent-guides-auto-enabled t)
  (set-face-background 'highlight-indent-guides-even-face "dimgray")
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray")
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))


;; Core Tools
(use-package better-defaults
  :ensure t
  :config
  (menu-bar-mode 1))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package zoom-window
  :ensure t
  :config
  (global-set-key (kbd "C-x C-z") 'zoom-window-zoom)
  (custom-set-variables
   '(zoom-window-mode-line-color "Black")))

(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1
        company-tooltip-limit 10
        company-minimum-prefix-length 3)
  :hook (after-init . global-company-mode))

(use-package which-key
  :ensure t
  :diminish ""
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

(use-package counsel
  :ensure t)

(use-package magit
  :ensure t)

(use-package magithub
  :ensure t)

(use-package yasnippet
  :ensure t)

(use-package yasnippet-snippets
  :ensure t)

(yas-global-mode 1)

;; Terminal
(use-package multi-vterm
  :ensure t
  :config
  (setq system-uses-terminfo nil
      multi-term-program "/bin/zsh"
      term-suppress-hard-newline t
      multi-term-switch-after-close nil
      term-char-mode-point-at-process-mark nil)
  (add-hook 'term-mode-hook
                      (lambda ()
                          (dolist
                                  (bind
                                      '(("C-<backspace>" . term-send-backward-kill-word)
                                      ("C-<delete>" . term-send-forward-kill-word)

                                      ("C-<left>" . term-send-backward-word)
                                      ("C-<right>" . term-send-forward-word)
                                      ("C-c C-j" . term-line-mode)
                                      ("C-c C-k" . term-char-mode)
                                      ("C-r" . term-send-reverse-search-history)
                                      ("C-v" . scroll-up)
                                      ("C-y" . term-paste)
                                      ("C-z" . term-stop-subjob)
                                      ("C-p" . term-send-prior)
                                      ("C-n" . term-send-next)
                                      ("M-p" . scroll-up-line)
                                      ("M-n" . scroll-down-line)
                                      ("M-DEL" . term-send-backward-kill-word)
                                      ("M-d" . term-send-forward-kill-word)
                                      ("M-r" . isearch-backward)
                                      ("M-s" . term-send-forward-kill-word)))
                            (add-to-list 'term-bind-key-alist bind))))
  (add-hook 'term-mode-hook '(lambda () (toggle-truncate-lines 1))))

;; Org Mode
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
