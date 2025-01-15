(defun ngs-org-babel-tangle-config ()
  (message "Hello")
  (when (string-equal (buffer-file-name)
		      (file-name-concat (expand-file-name user-emacs-directory) "README.org"))
      (org-babel-tangle)))

(add-hook 'org-mode-hook (lambda ()
   (add-hook 'after-save-hook #'ngs-org-babel-tangle-config)))
