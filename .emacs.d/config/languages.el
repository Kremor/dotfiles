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

;; HTML
;; vscode-html-languageserver required
;; $> npm install -g vscode-html-languageserver-bin
(add-hook 'html-mode #'lsp)

;; Javascript
;; typescript-language-server required
;; $> npm install -g typescript-language-server
(add-hook 'js-mode-hook #'lsp)

;; Python
;; python-language-server must be installed
;; $> pacman -S python-language-server
(load "~/.emacs.d/config/packages/lsp-python-ms/lsp-python-ms.el")
(use-package lsp-python-ms
  :after lsp-python-ms
  :ensure nil
  :hook (python-mode . lsp)
  :config
  ;; python-language-server binary
  (setq lsp-python-ms-executable "/usr/bin/pyls")
  )

;; Rust
;; rls must be installed
;; $> rustup component add rls rust-analysis rust-src
(use-package rust-mode
  :defer t
  :hook (rust-mode . lsp)
  )

;; Vue
(use-package vue-mode
  :defer t
  :hook (vue-mode . lsp)
  )
