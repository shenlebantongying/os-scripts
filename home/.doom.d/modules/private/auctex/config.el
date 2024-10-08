;;; lang/latex/config.el -*- lexical-binding: t; -*-

(defconst +latex-indent-item-continuation-offset 'align
  "Level to indent continuation of enumeration-type environments.

I.e., this affects \\item, \\enumerate, and \\description.

Set this to `align' for:

  \\item lines aligned
         like this.

Set to `auto' for continuation lines to be offset by `LaTeX-indent-line':

  \\item lines aligned
    like this, assuming `LaTeX-indent-line' == 2

Any other fixed integer will be added to `LaTeX-item-indent' and the current
indentation level.

Set this to `nil' to disable all this behavior.

You'll need to adjust `LaTeX-item-indent' to control indentation of \\item
itself.")


(defvar +latex-viewers '(skim evince sumatrapdf zathura okular pdf-tools)
  "A list of enabled LaTeX viewers to use, in this order. If they don't exist,
they will be ignored. Recognized viewers are skim, evince, sumatrapdf, zathura,
okular and pdf-tools.

If no viewer is found, `latex-preview-pane-mode' is used.")

;; Packages

(add-to-list 'auto-mode-alist '("\\.tex\\'" . LaTeX-mode))

(setq TeX-parse-self t ; parse on load
      TeX-auto-save t  ; parse on save
      ;; Use hidden directories for AUCTeX files.
      TeX-auto-local ".auctex-auto"
      TeX-style-local ".auctex-style"
      TeX-source-correlate-mode t
      TeX-source-correlate-method 'synctex
      ;; Don't start the Emacs server when correlating sources.
      TeX-source-correlate-start-server nil
      ;; Automatically insert braces after sub/superscript in `LaTeX-math-mode'.
      TeX-electric-sub-and-superscript t
      ;; Just save, don't ask before each compilation.
      TeX-save-query nil)


(after! tex
  ;; Fontify common LaTeX commands.
  (load! "+fontification")
  ;; Select viewer.
  (load! "+viewers")
  ;; Do not prompt for a master file.
  (setq-default TeX-master t)
  ;; Set-up chktex.
  (setcar (cdr (assoc "Check" TeX-command-list)) "chktex -v6 -H %s")
  (setq-hook! 'TeX-mode-hook
    ;; Don't auto-fill in math blocks.
    fill-nobreak-predicate (cons #'texmathp fill-nobreak-predicate))
  ;; Enable `rainbow-mode' after applying styles to the buffer.
  (add-hook 'TeX-update-style-hook #'rainbow-delimiters-mode)
  ;; Display output of LaTeX commands in a popup.
  (set-popup-rules! '((" output\\*$" :size 15)
                      ("^\\*TeX \\(?:Help\\|errors\\)"
                       :size 0.3 :select t :ttl nil)))
  (after! smartparens-latex
    ;; We have to use lower case modes here, because `smartparens-mode' uses
    ;; the same during configuration.
    (let ((modes '(tex-mode plain-tex-mode latex-mode LaTeX-mode)))
      ;; All these excess pairs dramatically slow down typing in LaTeX buffers,
      ;; so we remove them. Let snippets do their job.
      (dolist (open '("\\left(" "\\left[" "\\left\\{" "\\left|"
                      "\\bigl(" "\\biggl(" "\\Bigl(" "\\Biggl(" "\\bigl["
                      "\\biggl[" "\\Bigl[" "\\Biggl[" "\\bigl\\{" "\\biggl\\{"
                      "\\Bigl\\{" "\\Biggl\\{"
                      "\\lfloor" "\\lceil" "\\langle"
                      "\\lVert" "\\lvert" "`"))
        (sp-local-pair modes open nil :actions :rem))
      ;; And tweak these so that users can decide whether they want use LaTeX
      ;; quotes or not, via `+latex-enable-plain-double-quotes'.
      (sp-local-pair modes "``" nil :unless '(:add sp-in-math-p))))
  ;; Hook LSP, if enabled.
  (when (featurep! +lsp)
    (add-hook! '(tex-mode-local-vars-hook
                 latex-mode-local-vars-hook)
               #'lsp!))
  (map! :localleader
        :map latex-mode-map
        :desc "View"          "v" #'TeX-view
        :desc "Compile"       "c" #'TeX-command-run-all
        :desc "Run a command" "m" #'TeX-command-master)
  (map! :after latex
        :localleader
        :map LaTeX-mode-map
        :desc "View"          "v" #'TeX-view
        :desc "Compile"       "c" #'TeX-command-run-all
        :desc "Run a command" "m" #'TeX-command-master))

(after! latex
  ;; Add the TOC entry to the sectioning hooks.
  (setq LaTeX-section-hook
        '(LaTeX-section-heading
          LaTeX-section-title
          LaTeX-section-toc
          LaTeX-section-section
          LaTeX-section-label)
        LaTeX-fill-break-at-separators nil
        LaTeX-item-indent 0)
      ;; Tell Emacs how to parse TeX files.
  (setq ispell-parser 'tex)
)


;; to future, there is a bug about truncate-lines,
;; this is a temporal solution
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (visual-line-mode -1)
            (toggle-truncate-lines 1)))

(use-package! preview
  :hook (LaTeX-mode . LaTeX-preview-setup)
  :config
  (setq-default preview-scale 1.4
                preview-scale-function
                (lambda () (* (/ 10.0 (preview-document-pt)) preview-scale)))
  ;; Don't cache preamble, it creates issues with SyncTeX. Let users enable
  ;; caching if they have compilation times that long.
  (setq preview-auto-cache-preamble nil)
  (map! :map LaTeX-mode-map
        :localleader
        :desc "Preview" "p" #'preview-at-point
        :desc "Unpreview" "P" #'preview-clearout-at-point))


(use-package! cdlatex
  :when (featurep! +cdlatex)
  :hook (LaTeX-mode . cdlatex-mode)
  :hook (org-mode . org-cdlatex-mode)
  :config
  ;; Use \( ... \) instead of $ ... $.
  (setq cdlatex-use-dollar-to-ensure-math nil)
  ;; Disabling keys that have overlapping functionality with other parts of Doom.
  (map! :map cdlatex-mode-map
        ;; Smartparens takes care of inserting closing delimiters, and if you
        ;; don't use smartparens you probably don't want these either.
        "$" nil
        "(" nil
        "{" nil
        "[" nil
        "|" nil
        "<" nil
        ;; TAB is used for CDLaTeX's snippets and navigation. But we have
        ;; Yasnippet for that.
        (:when (featurep! :editor snippets)
          "TAB" nil)
        ;; AUCTeX takes care of auto-inserting {} on _^ if you want, with
        ;; `TeX-electric-sub-and-superscript'.
        "^" nil
        "_" nil
        ;; AUCTeX already provides this with `LaTeX-insert-item'.
        [(control return)] nil))

;; BibTeX + RefTeX.
(load! "+ref")
