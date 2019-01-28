;; load base config
(load "~/.emacs.d/config/base.el")

;; load custom functions
(load "~/.emacs.d/config/functions.el")

;; load packages
(load "~/.emacs.d/config/packages.el")

;; =============================================================================
;; Settings that can not be part of base.el for various reasons.
;; E.g. Needs to be loaded after packages.el
;; =============================================================================

;; Hide vertical borders
(set-face-foreground 'vertical-border (face-background 'default))
;; Disables scroll bar
(scroll-bar-mode -1)


;; =============================================================================
;; Key bindings
;; =============================================================================

;; Ivy key bindings
(general-define-key
 "C-s" 'swiper
 "M-x" 'counsel-M-x)

(general-define-key
 :prefix "C-c"
 "b" 'ivy-switch-buffer
 "/" 'counsel-git-grep
 "f" '(:ignore t: :which-key "files")
 "ff" 'counsel-find-file
 "fr" 'counsel-recentf
 "p" '(:ignore t :which-key "project")
 "pf" '(counsel-git :which-key "find file in git dir"))

;; Replace go to start and end of buffer
(general-define-key
 "C-," 'beginning-of-buffer
 "C-." 'end-of-buffer)

;; Key bindings for custom functions
(general-define-key
 "M-<down>" 'my-move-line-down
 "M-<up>" 'my-move-line-up)

;; =============================================================================
;; Auto generated code
;; =============================================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (counsel avy general which-key wucuo use-package sublimity srcery-theme rjsx-mode prettier-js neotree magit indium elpy company-tern company-anaconda column-enforce-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
