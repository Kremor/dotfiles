;; IDO
(require 'ido)
(ido-mode t)

;; Org mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Melpa
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	         '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Srcery Theme
(use-package srcery-theme
  :ensure t
  :config
  (load-theme 'srcery t))

;; Column enforce mode
(use-package column-enforce-mode
  :ensure
  :config
  (setq column-enforce-column 80)
  (global-column-enforce-mode))

;; general.el
(use-package general
  :ensure t)

;; Ivy
(use-package ivy
  :ensure t
  :commands (avy-goto-word-1)
  :config
  (use-package counsel
    :ensure t
    :config
    (counsel-mode)))

;; Key frequency
(use-package keyfreq
  :ensure t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))

;; Magit
(use-package magit
  :ensure t)

;; Super save
(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

;; Which Key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.1)
  )

;; Spell Check
(use-package wucuo
  :ensure t
  :config
  (wucuo-start)
  (setq ispell-extra-args "--run-together"))
