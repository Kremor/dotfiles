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

;; Company
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (use-package company-tern
    :ensure t
    :config
    (add-to-list 'company-backends 'company-tern)
    (add-hook 'rjsx-mode-hook (lambda ()
                                (tern-mode)
                                (company-mode)))))

;; Column enforce mode
(use-package column-enforce-mode
  :ensure
  :config
  (setq column-enforce-column 80)
  (global-column-enforce-mode))

;; Elpy
(use-package elpy
  :ensure t
  :config
  (elpy-enable))

;; JS Mode
(use-package rjsx-mode
  :ensure t
  :config
  (setq js-indent-level 2)
  (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
  (use-package indium
    :ensure t)
  (use-package prettier-js
    :ensure t
    :config
    (add-hook 'rjsx-mode-hook 'prettier-js-mode)))

;; Magit
(use-package magit
  :ensure t)

;; NeoTree
(use-package neotree
  :ensure t
  :config
  (global-set-key [f8] 'neotree-toggle)
  (setq neo-theme 'arrow))

;; Which Key
(use-package which-key
  :ensure t)

;; Spell Check
(use-package wucuo
  :ensure t
  :config
  (wucuo-start)
  (setq ispell-extra-args "--run-together"))
