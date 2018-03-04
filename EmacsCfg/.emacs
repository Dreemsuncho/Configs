;package path
(add-to-list 'load-path "~/.emacs.d/lisp/")
;;;INSTALL PACKAGES;;;
;-------------------------------------------
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))

(package-initialize)
(put 'upcase-region 'disabled nil)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8
    multiple-cursors))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;move lines package
(require 'move-lines)
(move-lines-binding)

;;;PYTHON CONFIG
;-------------------------------------------
(elpy-enable)

; remove default elpy-kbd's
(eval-after-load "elpy"
  '(cl-dolist (key '("<M-down>" "<M-up>" "<C-up>" "<C-down>" "C->" "C-<" "C-c C-<" "C-." "C-d"))
     (define-key elpy-mode-map (kbd key) nil)))


; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;;;COSTOMIZATION;;;
;-------------------------------------------
;;THEME
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally
(global-visual-line-mode t) ;; word wrapping
(highlight-indentation-mode t)
;set font
(set-default-font "consolas")

;;CURSOR
(set-cursor-color "magenta3") ; set cursor color

;;KEYBINDINGS
;multiple cursor
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(global-set-key (kbd "C-,") 'mc/unmark-previous-like-this)
(global-set-key (kbd "C-.") 'mc/unmark-next-like-this)
;scrolling without moving cursor
(global-set-key (kbd "<C-up>") 'scroll-down-line)
(global-set-key (kbd "<C-down>") 'scroll-up-line)
;cursor jump between white-lines
(global-set-key (kbd "<M-up>") 'backward-paragraph)
(global-set-key (kbd "<M-down>") 'forward-paragraph)
;(elpy package)
;goto definition
(global-set-key (kbd "<f12>") 'elpy-goto-definition)
(global-set-key (kbd "C-S-<f12>") 'elpy-goto-definition-other-window)
(global-set-key (kbd "S-<f12>") 'xref-pop-marker-stack)
(global-set-key (kbd "M-q") 'elpy-doc)
(global-set-key (kbd "M-<f8>") 'elpy-autopep8-fix-code)
;window resize
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)
;upper-lower casing
(global-set-key(kbd "C-u") 'upcase-dwim)
(global-set-key(kbd "C-l") 'downcase-dwim)
;duplicate current line
(global-set-key (kbd "C-d") (lambda()
			      (interactive)
			      (move-beginning-of-line 1)
			      (kill-line)
			      (yank)
			      (open-line 1)
			      (next-line 1)
			      (yank)))
;newline without break
(global-set-key (kbd "<S-return>") (lambda()
				     (interactive)
				     (end-of-line)
				     (newline-and-indent)))
;comment uncomment region
(global-set-key (kbd "C-/") 'comment-line)

;; AUTOCONFIG
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ein py-autopep8 multiple-cursors material-theme flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
