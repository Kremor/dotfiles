;; Disables toolbar
(tool-bar-mode -1)
;; Disables scroll bar
(scroll-bar-mode -1)

;; Display line numbers
;;(global-display-line-numbers-mode)
;; Display whitespaces
;;(require 'whitespace)
;;(global-whitespace-mode)

;; Hilights the current line
(global-hl-line-mode t)

;; Spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Delete trailing whitespaces before saving
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Adds a new line to the end of the file
(setq require-final-newline "visit-save")

;; Mac OS
(when (eq system-type 'darwin)
  (setq mac-right-option-modifier 'none))

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

;; Sublimity
(use-package sublimity
  :ensure t
  :config
  ;;(require 'sublimity-scroll)
  (require 'sublimity-map)
  (require 'sublimity-attractive)
  (sublimity-mode 1)
  ;;(setq sublimity-scroll-weight 5
  ;;      sublimity-scroll-drift-length 10)
  (sublimity-attractive-hide-vertical-border)
  (sublimity-attractive-hide-bars)
  (sublimity-map-set-delay nil)
  (setq sublimity-attractive-centering-width nil)
  (setq sublimity-map-size 12)
  (setq sublimity-map-max-fraction 0.15)
  (setq sublimity-map-text-scale -12))

;; Spell Check
(use-package wucuo
  :ensure t
  :config
  (wucuo-start)
  (setq ispell-extra-args "--run-together"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rjsx-mode
     company-tern
     column-enforce-mode
     prettier-js sublimity
     use-package
     srcery-theme
     elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
