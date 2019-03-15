(require 'general)

;;remaps undo
(general-define-key
 "C-z" 'undo)

;; Ivy key bindings
(general-define-key
 "C-s" 'swiper
 "M-x" 'counsel-M-x
 )

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

;; Remaps keys to be more space centric
(general-unbind "C-SPC")
(general-define-key
 :prefix "C-x"
 "SPC" 'set-mark-command)
(general-define-key
 :prefix "C-SPC"

 ;; bookmarks
 "m" '(:ignore t :which-key "bookmarks")
 "ml" '(bookmark-bmenu-list :which-key "list")
 "mm" '(bookmark-set :which-key "set")


 ;; buffers
 "b" '(:ignore t :which-key "buffers")
 "bb" '(ivy-switch-buffer :which-key "switch")
 "bk" '(kill-this-buffer :which-key "kill")
 "bl" '(list-buffers :which-key "list")

 ;; code
 "c" '(:ignore t :which-key "code")
 "cc" '(comment-or-uncomment-region :which-key "un/comment")
 "cg" '(goto-line :which-key "go to line")

 ;; files
 "f" '(:ignore t :which-key "files")
 "ff" '(counsel-find-file :which-key "find file")
 "fr" '(counsel-recentf :which-key "find recent")
 "fs" '(save-buffer :which-key "save")

 ;; Major modes
 ;; "m" '(:ignore t :which-key "major mode")

 ;; Projectile
 "p" '(:ignore t :which-key "projectile")
 "pd" '(projectile-find-dir :which-key "find dir")
 "pf" '(projectile-find-file :which-key "find file")
 "po" '(projectile-switch-project :which-key "open project")
 "pp" '(projectile-discover-projects-in-directory :which-key "discover projects")

 ;; version control
 "v" '(:ignore t :which-key "git")
 "vb" '(:ignore t :which-key "branch")
 "vbb" '(magit-branch-create :which-key "create")
 "vbc" '(magit-branch-and-checkout :which "create anc checkout")
 "vc" '(magit-checkout :which-key "checkout")
 "vf" '(magit-fetch-from-upstream :which-key "fetch branch")
 "vg" '(magit :which-key "magit")
 "vp" '(magit-push-current-to-upstream :which-key "push upstream")
 "vq" '(magit-pull-from-upstream :which-key "pull upstream")

 ;; windows
 "w" '(:ignore t :which-key "windows")
 "wd" '(delete-window :which-key "delete window")
 "wf" '(:ignore t :which-key "frames")
 "wfd" '(delete-frame :which-key "delete frame")
 "wff" '(make-frame :which-key "make frame")
 "wfj" '(delete-other-window :which-key "delete others")
 "wfo" '(other-frame :which-key "other frame")
 "wh" '(split-window-below :which-key "split horizontally")
 "wj" '(delete-other-windows :which-key "delete others")
 "wo" '(other-window :which-key "other window")
 "wv" '(split-window-right :which-key "split vertically")

 ;; help
 "?" '(:ignore t :which-key "help")
 "?k" '(describe-key :which-key "describe key")
 "?e" '(info-emacs-manual :which-key "emacs manual")
 "?f" '(describe-function :which-key "describe function")
 "?i" '(info :which-key "info")
 "?v" '(describe-variable :which-key "describe variable")
 "??" '(help :which-key "help")
 )
