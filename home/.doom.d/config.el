
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

(menu-bar-mode)
; (tool-bar-mode)

(setq display-line-numbers-type t)

(setq +doom-dashboard-functions
  '(doom-dashboard-widget-shortmenu))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "slbtty"
      user-mail-address "shenlebantongying@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-theme 'modus-operandi)
(setq doom-font (font-spec :family "JetBrains Mono" :size 12.0))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; mac related bindings
(when IS-MAC
  (setq
   mac-function-modifier 'hyper)
  (map!
   "H-w" #'previous-line
   "H-s" #'next-line
   "H-a" #'backward-char
   "H-d" #'forward-char
   "H-q" #'backward-word
   "H-e" #'forward-word
   "H-2" #'scroll-down
   "H-x" #'scroll-up
   )
  )

;; generic
(map!
 "s-o" #'find-file-at-point
 "s-t" #'+neotree/open
 ;; wasd
 "s-w" #'previous-line
 "s-s" #'next-line
 "s-a" #'backward-char
 "s-d" #'forward-char
 ;; q - e
 "s-q" #'backward-word
 "s-e" #'forward-word

 ;; org
 "s-l" #'org-preview-latex-fragment

 "<f5>" #'+vterm/toggle
 )

;; override some defaults
;; (use-package! treemacs
;;   :config
;;   (setq treemacs-follow-mode t
;;         treemacs-position 'right))

;; Scheme

(setq geiser-smart-tab-mode t)
(after! geiser
  (setq geiser-guile-binary (executable-find "guile3")))

(after! python
  (setq python-shell-interpreter "ipython3"))

(after! centaur-tabs
   (setq centaur-tabs-height 1)
)

(after! doom-modeline
  (setq doom-modeline-height 1)
  )

(setq org-directory "~/workbench-universe/")
