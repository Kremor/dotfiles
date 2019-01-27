;; load base config
(load "~/.emacs.d/config/base.el")

;; load custom functions
(load "~/.emacs.d/config/functions.el")

;; load packages
(load "~/.emacs.d/config/packages.el")

;; =============================================================================
;; Miscellaneus configurations that can't be in base.el for various reasons.
;; E.g. Needs to be loaded after packages.el
;; =============================================================================

;; Hide vertical borders
(set-face-foreground 'vertical-border (face-background 'default))
;; Disables scroll bar
(scroll-bar-mode -1)
