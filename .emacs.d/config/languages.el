(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-idle-delay 0.2)
  )

(use-package company-lsp
  :ensure t
  )

(use-package lsp-mode
  :ensure t
  )

(use-package lsp-ui
  :ensure t
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable t)
  )

(use-package prettier-js
  :defer t
  )

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (setq
   projectile-project-search-path
   '("~/Development/")
   )
  )

;; Languages

;; CSS
;; vscode-css-languageserver-bin required
;; $> npm install -g vscode-css-languageserver-bin
(add-hook 'css-mode #'lsp)
(setq css-indent-offset 2)

(add-hook 'css-mode-hook 'prettier-js-mode)

;; HTML
;; vscode-html-languageserver required
;; $> npm install -g vscode-html-languageserver-bin
(add-hook 'html-mode-hook #'lsp)

;; Javascript
;; typescript-language-server required
;; $> npm install -g typescript-language-server
(setq js-indent-level 2)
(add-hook 'js-mode-hook 'prettier-js-mode)
;; (add-hook 'js-mode-hook #'lsp)
(use-package js2-mode
  :defer t
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-hook 'js2-mode-hook #'prettier-js-mode)
  ;; (add-hook 'js2-mode-hook #'lsp)
  )

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  )

(setq company-tooltip-align-annotations t)

(use-package tide
  :defer t
  :config
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'js2-mode-hook #'setup-tide-mode)
  (flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  (setq js2-strict-missing-semi-warning nil)
  )


;; LaTeX
;; auctex is required
;; $> pacman -S auctex
(defun flymake-get-tex-args (file-name)
  (list "pdflatex"
        (list "-file-line-error" "-draftmode" "-interaction=nonstop" file-name)
        )
  )

(use-package auctex
  :defer t
  :hook (LaTeX-mode . flymake)
  :config

  ;; Enables parsing
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)

  ;; Allows multi-file documents
  (setq-default TeX-master nil)
  )

(use-package company-auctex
  :defer t
  :config
  (company-auctex-init)
  )

;; Python
;; microsoft-python-language-server must be installed
(setq python-indent-offset 4)

(use-package lsp-python-ms
  :defer t
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp)))
  :config
  (setq lsp-python-ms-executable
        "/usr/bin/mspyls")
  )

;; Rust
;; rls must be installed
;; $> rustup component add rls rust-analysis rust-src
(use-package rust-mode
  :defer t
  :hook (rust-mode . lsp)
  )

;; Typescript
(use-package typescript-mode
  :defer t
  :config
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'lsp-mode)
  (setq typescript-indent-level 2)
  )

;; Vue
(use-package vue-mode
  :defer t
  ; :hook (vue-mode . lsp)
  :config
  (add-hook 'mmm-mode-hook
            (lambda ()
              (set-face-background 'mmm-default-submode-face nil)
              )
            )
  (add-hook 'vue-mode-hook #'prettier-js-mode)
  )
