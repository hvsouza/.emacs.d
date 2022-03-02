(setq inhibit-startup-message t)
(setq-default cursor-type 'bar)

;; to remove tabs and replace by space
(setq-default indent-tabs-mode nil)

;; I've setup my custom file in another directory
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)


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
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; make buffer C-x C-b much better
(defalias 'list-buffers 'ibuffer-other-window)

;; allow to undo buffer stuffs... C-c left
(winner-mode 1)

;; ;; counsel for file -> From youtube tutorial
;; (use-package counsel
;;   :ensure t
;;   :bind
;;   (("M-y" . counsel-yank-pop)
;;    :map ivy-minibuffer-map
;;    ("M-y" . ivy-next-line)))

;; ;; ivy for swiper (i dont really know) -> From youtube tutorial
;; (use-package ivy
;;   :ensure t
;;   :diminish (ivy-mode)
;;   :bind (("C-x b" . ivy-switch-buffer))
;;   :config
;;   (ivy-mode 1)
;;   (setq ivy-use-virtual-buffers t)
;;   (setq ivy-count-format "%d/%d ")
;;   (setq ivy-display-style 'fancy)
;;   )


;; ;; for searching -> from youtube tutorail
;; (use-package swiper
;;   :ensure t
;;   :bind (("C-r" . swiper-isearch)
;; 	 ("C-s" . swiper-isearch)
;; 	 ("C-f" . swiper-isearch)
;; 	 ("C-x C-f" . counsel-find-file)
;; 	 ("C-c C-r" . ivy-resume)
;; 	 ("M-x" . counsel-M-x)
;; 	 )
;;   :config
;;   (progn
;;     (ivy-mode 1)
;;     (setq ivy-use-virtual-buffers t)
;;     (setq ivy-display-style 'fancy)
;;     (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
;;     (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial)
;;     (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
;;     (setq ivy-sort-matches-functions-alist '((t . nil)
;;                                          (ivy-switch-buffer . ivy-sort-function-buffer)
;;                                          (counsel-find-file . ivy-sort-function-buffer)))

;;     ))



;; _______________ from https://panadestein.github.io/emacsd/

(use-package ivy
  :ensure t
  :diminish
  :bind
  (("C-s" . swiper-isearch))
  (("C-f" . swiper-isearch))
  :config
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1)
  ;; (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-partial))

(use-package swiper
  :ensure t)

(use-package counsel
  :ensure t
  :after ivy
  :hook
  (after-init . counsel-mode)
  :config (counsel-mode)
  :bind
  ("M-x" . counsel-M-x)
  ("C-x b" . counsel-ibuffer)
  ("C-M-l" . counsel-imenu)
  ("C-x C-f" . counsel-find-file)
  ;; ("<f1> v" . counsel-describe-variable)
  ;; ("<f1> f" . counsel-descbinds-function)
  )

(use-package ivy-prescient
  :ensure t
  :after counsel
  :config
  (ivy-prescient-mode 1))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (setq ivy-configure
        (plist-put ivy-rich-display-transformers-list
                   'ivy-switch-buffer
                   '(:columns
                     ((ivy-rich-candidate (:width 40))
                      (ivy-rich-switch-buffer-indicators
                       (:width 4 :face error :align right))
                      (ivy-rich-switch-buffer-major-mode
                       (:width 12 :face warning))
                      (ivy-rich-switch-buffer-project
                       (:width 15 :face success))
                      (ivy-rich-switch-buffer-path
                       (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path
                                            x (ivy-rich-minibuffer-width 0.3))))))))))

(use-package all-the-icons-ivy
  :ensure t
  :demand t)


;; __________________________
  
;; undo for normal people
(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

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


;; flycheck for completion and correction
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))






;; Line numbering
(global-display-line-numbers-mode)
;; (setq display-line-numbers-type 'relative)


;; saving backup files in a fixed directory
(setq backup-directory-alist `(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 5   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;; saving auto-save in a fixed directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-saves/" t)))

;; show parentheses stuff
(show-paren-mode 1)
(setq show-paren-delay 0)
(setq blink-matching-paren 'show)
;;(setq blink-matching-paren-distance nil)

(use-package smartparens
:ensure t
  :hook (prog-mode . smartparens-mode)
  :custom
  (sp-escape-quotes-after-insert nil)
  :config
  (require 'smartparens-config)
  :bind
  ;; ("C-x ," . sp-backward-sexp)
  ;; ("C-x ." . sp-forward-sexp)
  )
(show-paren-mode t)


;; Making org-mode wrap line
(defun org-line-wrap ()
  (spacemacs/toggle-visual-line-navigation-on)
  (setq-local word-wrap nil))

(add-hook 'org-mode-hook 'org-line-wrap)

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )


(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)))

(add-hook 'c++-mode-hook
	  (lambda () (local-set-key (kbd "C-d") #'comment-or-uncomment-region-or-line)))
(global-set-key (kbd "C-d") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-S-d") 'comment-or-uncomment-region-or-line)


(global-set-key (kbd "C-b") 'duplicate-line)


;; Loading code for display indentation lines
(add-to-list 'load-path "~/.emacs.d/Highlight-Indentation-for-Emacs")
(require 'highlight-indentation)
(setq highlight-indentation-overlay-string "|")
(highlight-indentation-mode t)
(add-hook 'org-mode-hook 'highlight-indentation-mode)
(add-hook 'emacs-lisp-mode-hook 'highlight-indentation-mode)
(add-hook 'c++-mode-hook 'highlight-indentation-mode)
(add-hook 'sh-mode-hook 'highlight-indentation-mode)
