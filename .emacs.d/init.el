(set-frame-parameter nil 'fullscreen 'fullboth)
(setq inhibit-startup-message t)

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
 '(package-selected-packages '(pdf-tools ivy evil sx ##)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'evil)
(evil-mode 1)


; use ivy instead of default
(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(latex-preview-pane-enable)
; f12 previews, shift f12 creates pdf
(defun my-latex (action)
  (interactive)
  (if (buffer-modified-p) (save-buffer))
  (let ((f1 (current-frame-configuration))
        (retcode (shell-command (concat "~/bin/my-latex " action " " buffer-file-name))))
    (if (= retcode 0) (set-frame-configuration f1))))

(add-hook 'latex-mode-hook (lambda ()
      (define-key LaTeX-mode-map (kbd "<f12>") '(lambda () (interactive) (my-latex "preview")))
      (define-key LaTeX-mode-map (kbd "<S-f12>") '(lambda () (interactive) (my-latex "create")))))
; for some reason this isn't default
(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode))
