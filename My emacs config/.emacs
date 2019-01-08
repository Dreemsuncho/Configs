(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; My macros
(fset 'my-macro
      [home ?\M-x ?f ?o ?r ?w ?a ?r ?d ?- ?w ?h tab return left S-home S-right ?\M-w down home ?\M-x ?f ?o ?r ?w ?a ?r ?d ?- ?w ?h ?i tab return left S-home S-right backspace ?\C-y])
(global-set-key (kbd "C-q") 'my-macro)

;; install packages
(defvar my-packages
  '(better-defaults
    cider
    clojure-mode
    projectile
    material-theme))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      my-packages)

(load-theme 'material t)      ; use material theme

(global-display-line-numbers-mode t) ; show line numbers globally
(global-visual-line-mode t)   ; word wrapping
(set-default-font "consolas") ; set default font
(set-cursor-color "magenta2") ; set cursor color
(electric-pair-mode t) ; auto-brackets/quotes
(show-paren-mode t) ; show matching bracket(scope)


;; #Keybindings#
(global-set-key (kbd "<C-up>") 'scroll-down-line)
(global-set-key (kbd "<C-down>") 'scroll-up-line)

(global-set-key (kbd "<M-up>") 'backward-paragraph)
(global-set-key (kbd "<M-down>") 'forward-paragraph)

; resize buffers
(global-set-key (kbd "C-M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-M-<down>") 'shrink-window)
(global-set-key (kbd "C-M-<up>") 'enlarge-window)

(global-set-key(kbd "C-u") 'upcase-dwim) ; upper-lower casing
(global-set-key(kbd "C-l") 'downcase-dwim)

(global-set-key (kbd "C-/") 'comment-line) ; comment uncomment region
(global-set-key (kbd "C-z") 'undo) ; undo
(global-set-key (kbd "C-v") 'yank) ; paste

;newline without break
(global-set-key (kbd "<S-return>") (lambda()
				     (interactive)
				     (end-of-line)
				     (newline-and-indent)))

;; #Other settings
(setq scheme-program-name "mzscheme")


;;;;;;;;;;;;;;;;;;--LIB-1-START--;;;;;;;;;;;;;;;;;;;;;;
;; Move lines and selected regions
(defun move-lines (n)
  (let ((beg) (end) (keep))
    (if mark-active 
        (save-excursion
          (setq keep t)
          (setq beg (region-beginning)
                end (region-end))
          (goto-char beg)
          (setq beg (line-beginning-position))
          (goto-char end)
          (setq end (line-beginning-position 2)))
      (setq beg (line-beginning-position)
            end (line-beginning-position 2)))
    (let ((offset (if (and (mark t) 
                           (and (>= (mark t) beg)
                                (< (mark t) end)))
                      (- (point) (mark t))))
          (rewind (- end (point))))
      (goto-char (if (< n 0) beg end))
      (forward-line n)
      (insert (delete-and-extract-region beg end))
      (backward-char rewind)
      (if offset (set-mark (- (point) offset))))
    (if keep
        (setq mark-active t
              deactivate-mark nil))))

(defun move-lines-up (n)
  "move the line(s) spanned by the active region up by N lines."
  (interactive "*p")
  (move-lines (- (or n 1))))

(defun move-lines-down (n)
  "move the line(s) spanned by the active region down by N lines."
  (interactive "*p")
  (move-lines (or n 1)))
;;;;;;;;;;;;;;;;;;--LIB-1-KBD--;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-S-<up>") 'move-lines-up)
(global-set-key (kbd "C-S-<down>") 'move-lines-down)
;;;;;;;;;;;;;;;;;;--LIB-1-END--;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;--LIB-2-START--;;;;;;;;;;;;;;;;;;;;
;duplicate current line
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank)
  )

(global-set-key (kbd "C-d") 'duplicate-line)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (material-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
