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

;; Start and end of buffer
(global-unset-key (kbd "M-<"))
(global-unset-key (kbd "M->"))
(global-set-key (kbd "C-,") 'beginning-of-buffer)
(global-set-key (kbd "C-.") 'end-of-buffer)

;; Custom functions

(global-set-key (kbd "M-<up>") 'my-move-line-up)
(global-set-key (kbd "M-<down>") 'my-move-line-down)

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
    (which-key wucuo use-package sublimity srcery-theme rjsx-mode prettier-js neotree magit indium elpy company-tern company-anaconda column-enforce-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
