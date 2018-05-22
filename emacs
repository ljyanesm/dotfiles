(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(setq user-full-name "Luis Yanes"
      user-mail-address "Luis.Yanes@earlham.ac.uk")
(load "~/.emacs.secrets" t) ;; Loading secrets such as Acct info, etc...

(setq-default indent-tabs-mode nil)

(require 'package) ;; You might already have this line
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(setq my-packages
      '(
        org-plus-contrib
        helm
        ox-reveal
        org-bullets
        auto-complete
        ispell
        yasnippet
        ))

(cl-loop for p in my-packages
           unless (package-installed-p p)
           do (package-install p))


(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)

(setq org-ditaa-jar-path "~/.emacs.d/vendor/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/.emacs.d/vendor/plantuml.jar")

(global-set-key (kbd "C-<f1>") (lambda()
			       (interactive)
			       (show-all)
			       (artist-mode)))
(global-set-key (kbd "<f1>") 'org-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote nil))
 '(delete-selection-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-dictionary "en_GB")
 '(org-html-inline-images t)
 '(org-html-table-caption-above nil)
 '(package-selected-packages
   (quote
    (yasnippet auto-complete ox-reveal org-plus-contrib org-bullets helm)))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "microsoft" :slant normal :weight normal :height 142 :width normal))))
 '(preview-reference-face ((t (:foreground "light gray")))))

(add-to-list 'load-path "/home/yanesl/.emacs.d/org-reveal/")
(require 'ox-reveal)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(setq org-directory "~/Dropbox/org-mode")
(setq org-agenda-files (list "~/Dropbox/org-mode/home.org"
			     "~/Dropbox/org-mode/work.org"))
(setq org-log-done 'time)
(setq org-agenda-span (quote fortnight))

(require 'ox-latex)
(add-to-list 'org-latex-classes 
'("smarticle" 
 "\\documentclass[10pt]{article} 
\\usepackage[utf8]{inputenc} 
\\usepackage[T1]{fontenc} 
\\usepackage{graphicx} 
\\usepackage{longtable} 
\\usepackage{hyperref}
\\usepackage[left=1in,top=1in,right=1in,bottom=1in,head=0.2in,foot=0.2in]{geometry}" 
 ("\\section{%s}" . "\\section*{%s}") 
 ("\\subsection{%s}" . "\\subsection*{%s}") 
 ("\\subsubsection{%s}" . "\\subsubsection*{%s}") 
     ("\\paragraph{%s}" . "\\paragraph*{%s}") 
     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


(setq delete-old-versions t)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

(fset 'yes-or-no-p 'y-or-n-p)

(org-babel-do-load-languages
 'org-babel-load-languages
  '( (perl . t)
     (ruby . t)
     (sh . t)
     (python . t)
     (emacs-lisp . t)
     (C . t)
     (latex . t)
     (R . t)
     (dot . t)
     (ditaa . t)
     (js . t)
     (java . t)
     (plantuml . t)
     (gnuplot . t)
   ))

(setq org-confirm-babel-evaluate nil)

;; Auto-complete
(require 'auto-complete)
(setq tab-always-indent 'complete)
(add-to-list 'completion-styles 'initials t)
(ac-config-default)


(global-set-key (kbd "C-x f") 'find-file-at-point)
(setq TeX-PDF-mode t)

(require 'recentf)
(setq recentf-max-saved-items 200
            recentf-max-menu-items 15)
(recentf-mode)

(global-set-key (kbd "RET") 'newline-and-indent)

(setq ispell-program-name "aspell"
  ispell-extra-args '("--sug-mode=ultra"))

(add-hook 'org-mode-hook
  (lambda()
    (flyspell-mode 1)))

;; YASnippet
(require 'yasnippet)
(yas-global-mode 1)

(setq-default indent-tabs-mode nil)
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;(require 'langtool)
;(setq langtool-language-tool-jar "~/.emacs.d/vendor/langtool/languagetool-commandline.jar")
;(global-set-key "\C-x4w" 'langtool-check)
;(global-set-key "\C-x4W" 'langtool-check-done)

(add-hook 'c-mode-common-hook 'google-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;pdflatex
(setq latex-run-command "pdflatex")
