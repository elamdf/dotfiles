(call-process "/home/elamd/.local/bin/remaps")
(call-process "/home/elamd/.scripts/home")
(set-frame-parameter nil 'fullscreen 'fullboth)
(setq inhibit-startup-message t)
(setq doc-view-continuous 1)


(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina")

(load-theme 'wombat)



(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))
 '(package-selected-packages
   '(magit request exwm sml-modeline evil-collection pdf-tools ivy evil ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(evil-collection-init)

(require 'smart-mode-line)

(sml/setup)

; use ivy instead of default
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

; (latex-preview-pane-enable)
; f12 previews, shift f12 creates pdf
(defun my-latex (action)
  (interactive)
  (if (buffer-modified-p) (save-buffer))
  (let ((f1 (current-frame-configuration))
        (retcode (shell-command (concat "~/.scripts/my-latex " action " " buffer-file-truename))))
    (if (= retcode 0) (set-frame-configuration f1))))

(add-hook 'LaTeX-mode-hook (lambda ()
			     (latex-preview-pane-mode)))
(toggle-debug-on-error)
(require 'mailcap)
(add-to-list 'mailcap-user-mime-data
             '((type . "application/pdf")
               (viewer . doc-view-mode)))
