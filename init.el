(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; to try packages
(use-package try
  :ensure t)

;; to show options after starting typing a command
(use-package which-key
  :ensure t
  :config (which-key-mode))

;; Org-mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; to show completion for buffers and files
(setq indo-enable-flex-matching t)
(setq indo-everywhere t)
(ido-mode 1)

;; make buffer C-x C-b much better
(defalias 'list-buffers 'ibuffer-other-window)

;; allow to undo buffer stuffs... C-c left
(winner-mode 1)

;; counsel for file
(use-package counsel
  :ensure t
  )

;; ivy for swiper (i dont really know)
(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy))

;; for searching
(use-package swiper
  :ensure try
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file)
	 )
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

;; well.. auto-complete
(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; best thing in emacs..
(use-package nyan-mode
  :ensure t
  :init
    (setq nyan-animate-nyancat t)
  :config
  (nyan-mode)
  (nyan-toggle-wavy-trail)
  )






(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(nyan-mode auto-complete counsel swiper org-bullets which-key whick-key try zygospore projectile company use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Line numbering
(global-display-line-numbers-mode)
;; (setq display-line-numbers-type 'relative)


(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )

;; (define-key c++-mode-map (kbd "C-d") nil)
;; (global-unset-key (kbd "C-d"))
(add-hook 'c++-mode-hook
	  (lambda () (local-set-key (kbd "C-d") #'comment-line)))
(global-set-key (kbd "C-d") 'comment-line)
(global-set-key (kbd "C-b") 'duplicate-line)
