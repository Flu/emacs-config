
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
                         ("melpa" . "https://melpa.org/packages/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (slack slim-mode slime-company slime doom-modeline spaceline-all-the-icons spaceline sublimity sunshine vimish-fold company neotree org-link-minor-mode nlinum company-irony company-irony-c-headers irony doom-themes))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(setf global-prettify-symbols-mode t)

(load-theme 'doom-Iosvkem t)
(doom-themes-visual-bell-config)
;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)

;; Making emacs more minimalistic
(setq inhibit-startup-screen t)
(tool-bar-mode -1)
(ido-mode t)
(global-linum-mode)
(set-frame-parameter nil 'fullscreen 'maximized)

;; Org stuff, please don't touch, thancc
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; Neotree config - use F8 to toggle, although it should be toggled by default
(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)(
global-set-key [f8] 'neotree-toggle)

;; For company-mode (completion anytime)
(add-hook 'after-init-hook 'global-company-mode)

;; Weather informaton stuff
(require 'sunshine)
(setq sunshine-location "Bucharest,RO")
(setq sunshine-appid "a8bff8612f152563a2b4f6bd6d9cd576")
(setq forecast-units "metric")

;; Vimmish mode
(require 'vimish-fold)
(vimish-fold-global-mode 1)

;; Sublimity mode
(require 'sublimity)
(require 'sublimity-scroll)
(sublimity-mode 1)

;; Spaceline
;(require 'spaceline-config)
;(spaceline-emacs-theme)

;; Doom-modeline
(require 'doom-modeline)
(doom-modeline-mode 1)

(defun switch-to-other-buffer()
  "Switches to the most recent buffer"
  (switch-to-buffer (other-buffer))
  )

;; Custom functions for day-to-day operations

(defmacro get-file-type(filepath)
  `(pathname-type (pathname ,filepath)))

(defun meow-previous-buffer()
  "Function that mewos the most recent buffer. What that means, you shall see."
  (interactive)
  (switch-to-other-buffer)
   (while (<= 0 iter)
	(setq iter (- iter 1))
	(save-excursion (goto-char (point-max)) (insert "meow meow meow meow\n")))
   (switch-to-other-buffer)
   (message "I meowed your buffer, you are welcome"))

(defun meow-current-buffer()
  "Function that mewos the current buffer. What that means, you shall see."
  (interactive)
  (setq iter 200)
  (while (<= 0 iter)
	(setq iter (- iter 1))
	(save-excursion (goto-char (point-max)) (insert "meow meow meow meow\n")))
  (message "I meowed your buffer, you are welcome"))

(defun c-template-text()
  "Puts the default text in a buffer destined for C or C++ code, so I don't have to."
  (interactive)
  (setq cpp-template "#include <iostream>\nusing namespace std;\n\nint main() {\n\n\n}\n")
  (setq c-template "#include <stdlib.h>\n#include <stdio.h>\n\nint main() {\n\n\n}\n")
  
  (setq filename (buffer-file-name))
  (message filename)
  (cond
   ((string-suffix-p ".cpp" filename)
    (insert cpp-template))
   ((string-suffix-p ".c" filename)
    (insert c-template))
   (t
    (message "It's not a C++ nor a C file"))))

;; Slime
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq slime-contribs '(slime-fancy))

;; Python mode
(setq python-shell-interpreter "python3")

;; Custom key bindings
(global-set-key (kbd "M-f") 'sunshine-forecast)
(global-set-key (kbd "C-c m c") 'meow-current-buffer)
(global-set-key (kbd "C-c m p") 'meow-previous-buffer)
(global-set-key (kbd "C-c p p") 'c-template-text)
