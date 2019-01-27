;; Disables toolbar
(tool-bar-mode -1)
;; Disables menu bar
(menu-bar-mode -1)

;; Enables column-number-mode
(column-number-mode t)

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
