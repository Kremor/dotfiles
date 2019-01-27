(defun my-move-line-up ()
  "Move the line with the cursor up"
  (interactive)
  (let ((col (current-column)))
    ;; Exchange current and previous line
    (transpose-lines 1)
    ;; Last operation puts the point one line after our previous position
    ;; that's why we have to take two steps back
    (forward-line -2)
    (move-to-column col)))

(defun my-move-line-down ()
  "Move the line with the cursor down"
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(global-set-key (kbd "M-<up>") 'my-move-line-up)
(global-set-key (kbd "M-<down>") 'my-move-line-down)
