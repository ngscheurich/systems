;;; ngs-core.el --- Core customizations  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 N. G. Scheurich

;; Author: N. G. Scheurich <nick@scheurich.haus>
;; URL: https://scheurich.haus/emacs
;; Package-Requires: ((emacs "29.4"))

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Core customizations for my Emacs configuration.

;;; Code:

(defvar ngs-var-dir
  (locate-user-emacs-file "var/")
  "Directory in which to store variable data files")

(defvar ngs-auto-save-list-dir
  (expand-file-name "auto-save-list/" ngs-var-dir)
  "Directory in which to store auto-save-list files")
  
(defvar ngs-auto-save-dir
  (expand-file-name "auto-save/" ngs-var-dir)
  "Directory in which to store auto-save files")

(defvar ngs-backup-dir
  (expand-file-name "backup/" ngs-var-dir)
  "Directory in which to store backup files")

(mapcar (lambda (dir)
          (unless (file-directory-p dir)
            (make-directory dir)))
        `(,ngs-var-dir
          ,ngs-auto-save-list-dir
          ,ngs-auto-save-dir
          ,ngs-backup-dir))

;; Configure Emacs
(use-package emacs
  :init
  (setopt user-full-name "Nicholas Scheurich"
          user-email-address "nick@scheurich.me"
          history-length 40
          custom-file (expand-file-name ngs-var-dir "custom.el")
	        shell-file-name (ngs-home-manager-bin "zsh")
 	        sh-shell (ngs-home-manager-bin "zsh")
	        sh-shell-file (ngs-home-manager-bin "zsh"))
  
  ;; Set modifier keys for macOS
  (if (eq system-type 'darwin)
      (setopt mac-command-modifier 'meta
        mac-right-command-modifier 'super
        mac-right-option-modifier 'hyper)))

;; Package manager
(use-package package
  :init
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  :config
  (package-initialize))

;; Work with projects
(use-package project
  :init
  (setopt project-list-file (expand-file-name ngs-var-dir "projects")))

;; Wrangle auto-save and backup files
(setq auto-save-file-name-prefix
      (concat ngs-auto-save-list-dir ".saves-"))

(setq auto-save-file-name-transforms
      `((".*" ,ngs-auto-save-dir t)))

(setq backup-directory-alist
      `((".*" . ,ngs-backup-dir)))

;; Keep track of opened files
 (use-package recentf
   :init
   (setopt recentf-save-file (expand-file-name "recentf" ngs-var-dir))
   :config (recentf-mode t))

;; Save minibuffer history
(use-package savehist
  :init
  (setopt savehist-file (expand-file-name "history" ngs-var-dir)
          history-length 40)
  :config (savehist-mode))

(provide 'ngs-core)
;;; ngs-core.el ends here