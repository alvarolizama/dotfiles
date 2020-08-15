(require 'package)

(when (>= emacs-major-version 26)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  )

(setq package-check-signature nil)

(package-initialize)
(package-refresh-contents)
(package-install 'use-package)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Base config
(setq inhibit-startup-message t)

;; Hide the bell in the center of screen
(setq ring-bell-function 'ignore)
(column-number-mode t)
(global-hl-line-mode 1)

;; Transparent title bar
(when (memq window-system '(mac ns))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

;; line numbers
(global-display-line-numbers-mode)

;; Fix size of scroll
(setq scroll-step 1
      scroll-conservatively  10000)

;; Fira Code
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
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )
             ))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; Spanish Layout
(setq default-input-method "spanish-prefix")


;; Packages
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package better-defaults
  :ensure t
  :config
  (menu-bar-mode 1))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tomorrow-night t))

(use-package zoom-window
  :config
  (global-set-key (kbd "C-x C-z") 'zoom-window-zoom)
  (custom-set-variables
   '(zoom-window-mode-line-color "Black")))

(use-package doom-modeline
  :ensure t
  :defer t
  :custom
  (doom-modeline-modal-icon t)
  (doom-modeline-height 25)
  (doom-modeline-indent-info t)
  (doom-modeline-github t)
  :hook
  (after-init . doom-modeline-mode))

(use-package dashboard
  :ensure t
  :config
  (setq dashboard-banner-logo-title "Welcome to a coding session!")
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((recents . 10)))
  (dashboard-setup-startup-hook))

(use-package helm
  :ensure t
  :diminish ""
  :custom
  (helm-M-x-use-completion-styles nil)
  (helm-split-window-inside-p t)
  :bind (:map helm-map
              ("<tab>" . 'helm-execute-persistent-action))
  :config
  (require 'helm-config)
  (helm-mode 1))

(with-eval-after-load 'helm
  (add-hook 'helm-major-mode-hook
                (lambda ()
                (setq auto-composition-mode nil)))
  (add-to-list 'display-buffer-alist
               '("\\`\\*helm.*\\*\\'"
                 (display-buffer-in-side-window)
                 (inhibit-same-window . t)
                 (window-height . 0.4))))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (modify-syntax-entry ?_ "w")
  (add-hook 'prog-mode-hook #'(lambda ()
                                (modify-syntax-entry ?_ "w")))
  (use-package evil-nerd-commenter
    :ensure t
    :config
    (evilnc-default-hotkeys)
    (global-set-key (kbd "C-\-") 'evilnc-comment-operator))
  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-key
      "SPC" 'helm-M-x
      "[" 'counsel-fzf
      "]" 'counsel-ag
      "b" 'counsel-buffer-or-recentf
      ";" 'cd
      "'" 'magit
      "a" 'org-agenda
      "r" 'counsel-bookmark
      "t" 'multi-vterm-dedicated-toggle
      "p" 'treemacs
      "d" 'make-directory
      "f" 'find-file
      )))

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0.1
        company-tooltip-limit 10
        company-minimum-prefix-length 3)
  :hook (after-init . global-company-mode))

(use-package multi-vterm
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

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode 1))

(use-package autopair
  :config
  (autopair-global-mode))

(use-package yasnippet
  :config
  (yas-global-mode 1))

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

(use-package which-key
  :ensure t
  :diminish ""
  :config
  (which-key-mode)
  (which-key-setup-minibuffer))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-github t)
 '(doom-modeline-height 25)
 '(doom-modeline-indent-info t)
 '(doom-modeline-modal-icon t)
 '(helm-M-x-use-completion-styles nil t)
 '(helm-completion-style (quote emacs))
 '(helm-split-window-inside-p t)
 '(org-agenda-files
   (quote
    ("~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/projects.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/manuales.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/inbox.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/howtos.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/blogs.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/notes.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/Notes/agenda.org")))
 '(package-selected-packages
   (quote
    (org-bullets magithub multi-vterm vterm elixir-yasnippets yasnippet-snippets autopair yasnippet dashboard treemacs-projectile treemacs-magit treemacs-evil treemacs projectile-direnv projectile ghub git-gutter elixir-mode web-mode markdown-mode helm evil-leader evil-nerd-commenter evil company exec-path-from-shell counsel zoom-window magit doom-themes doom-modeline pbcopy better-defaults use-package)))
 '(projectile-completion-system (quote helm))
 '(projectile-keymap-prefix "p")
 '(projectile-switch-project-action (quote helm-ls-git-ls))
 '(web-mode-enable-current-column-highlight t t)
 '(web-mode-enable-current-element-highlight t t)
 '(zoom-window-mode-line-color "Black"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
