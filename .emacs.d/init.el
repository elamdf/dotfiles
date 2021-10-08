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
(require 'use-package)

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
 '(org-export-backends '(ascii beamer html icalendar latex odt))
 '(package-selected-packages
   '(undo-tree org-gcal org-roam org-bullets ox-twbs git magit request exwm sml-modeline evil-collection pdf-tools ivy evil ##)))
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
(global-undo-tree-mode)
(evil-set-undo-system 'undo-tree)

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
(require 'mailcap)
(add-to-list 'mailcap-user-mime-data
             '((type . "application/pdf")
               (viewer . doc-view-mode)))

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(defun slock ()
  (interactive)
  (call-process "slock"))
(global-set-key [(super backspace)] 'slock)
(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/org/"
         :publishing-directory "~/public_html/"
         :publishing-function org-twbs-publish-to-html
         :with-sub-superscript nil
         )))
(defun my-org-publish-buffer ()
  (interactive)
  (save-buffer)
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))
(setq initial-major-mode 'org-mode)
(setq debug-on-error nil)
(setq org-html-postamble nil)
; make twbs automatically show up in org dispatch menu
(require 'ox-twbs)

;fontify code in code blocks
(setq org-src-fontify-natively t)


; highlight and fontify latex text in org mode
(setq org-highlight-latex-and-related '(latex script entities))

; map tab to normal org mode thing in org mode
(evil-define-key 'normal org-mode-map (kbd "<tab>") #'org-cycle)


;org roam stuff
(use-package org-roam
	     :ensure t
	     :init
	     (setq org-roam-v2-ack t)
	     :custom
	     (org-roam-directory "~/notes")
	     :bind (("C-c n l" . org-roam-buffer-toggle)
		    ("C-c n f" . org-roam-node-find)
		    ("C-c n i" . org-roam-node-insert))
	     :config
	     (org-roam-setup))
(org-roam-db-autosync-mode)
(setq org-roam-dailies-directory "~/daily")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d>\n"))))
(global-set-key (kbd "C-c d") 'org-roam-dailies-goto-today)
; id 567385695919-padclu7ct58rgjvhefgctuq6fqnjf69k.apps.googleusercontent.com
; secret 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
; calid ZWxhbWRmQGJlcmtlbGV5LmVkdQ
;(require 'org-gcal)
; For "Elam's classes F21"
;(setq org-gcal-client-id "567385695919-padclu7ct58rgjvhefgctuq6fqnjf69k.apps.googleusercontent.com"
;      org-gcal-client-secret "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"
;      org-gcal-fetch-file-alist '(("c_f3di6iun1mdd429u9uf9h643h4@group.calendar.google.com" .  "~/schedule.org")
;                                  ))
