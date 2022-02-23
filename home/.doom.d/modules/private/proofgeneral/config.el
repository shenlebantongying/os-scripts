;;; lang/coq/config.el -*- lexical-binding: t; -*-

;;;###package proof-general
;;(setq proof-splash-enable nil)

;;;###package coq
(setq-hook! 'coq-mode-hook
  ;; Doom syncs other indent variables with `tab-width'; we trust major modes to
  ;; set it -- which most of them do -- but coq-mode doesn't, so...
  tab-width proof-indent
  ;; HACK Fix #2081: Doom continues comments on RET, but coq-mode doesn't have a
  ;;      sane `comment-line-break-function', so...
  comment-line-break-function nil)

;; We've replaced coq-mode abbrevs with yasnippet snippets (in the snippets
;; library included with Doom).
;;(setq coq-mode-abbrev-table '())

;; This package provides more than just code completion, so we load it whether
;; or not :completion company is enabled.
(use-package! company-coq
  :hook (coq-mode . company-coq-mode)
  :config
  (set-popup-rule! "^\\*\\(?:response\\|goals\\)\\*" :ignore t)
  (set-lookup-handlers! 'company-coq-mode
    :definition #'company-coq-jump-to-definition
    :references #'company-coq-grep-symbol
    :documentation #'company-coq-doc)

  (setq company-coq-disabled-features '(company-defaults spinner code-folding)))
