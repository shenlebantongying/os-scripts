;;; ui/modeline/config.el -*- lexical-binding: t; -*-

(use-package! doom-modeline
  :hook (after-init . doom-modeline-mode)
  :hook (doom-modeline-mode . size-indication-mode) ; filesize in modeline
  :hook (doom-modeline-mode . column-number-mode)   ; cursor column in modeline
  :init
  (unless after-init-time
    ;; prevent flash of unstyled modeline at startup
    (setq-default mode-line-format nil))
  ;; We display project info in the modeline ourselves
  (setq projectile-dynamic-mode-line nil)
  ;; Set these early so they don't trigger variable watchers
  (setq doom-modeline-github nil
        doom-modeline-mu4e nil
        doom-modeline-height 3
        doom-modeline-persp-name nil
        doom-modeline-major-mode-icon nil
        doom-modeline-buffer-file-name-style 'relative-from-project
        ;; Only show file encoding if it's non-UTF-8 and different line endings
        ;; than the current OSes preference
        doom-modeline-buffer-encoding 'nondefault
        doom-modeline-default-eol-type
        (cond (IS-MAC 2)
              (IS-WINDOWS 1)
              (0)))
  :config
  (set-face-attribute 'mode-line nil  :height 100)
  (set-face-attribute 'mode-line-inactive nil :height 100)

  ;; Fix an issue where these two variables aren't defined in TTY Emacs on MacOS
  (defvar mouse-wheel-down-event nil)
  (defvar mouse-wheel-up-event nil)

  (doom-modeline-def-modeline 'main
    '(hud window-number modals follow buffer-info remote-host buffer-position)
    '( misc-info persp-name debug repl lsp input-method indent-info buffer-encoding major-mode process vcs checker "    "))

  (add-hook '+doom-dashboard-mode-hook #'doom-modeline-set-project-modeline)

  (add-hook! 'magit-mode-hook
    (defun +modeline-hide-in-non-status-buffer-h ()
      "Show minimal modeline in magit-status buffer, no modeline elsewhere."
      (if (eq major-mode 'magit-status-mode)
          (doom-modeline-set-vcs-modeline)
        (hide-mode-line-mode))))

  ;; Some functions modify the buffer, causing the modeline to show a false
  ;; modified state, so force them to behave.
  (defadvice! +modeline--inhibit-modification-hooks-a (fn &rest args)
    :around #'ws-butler-after-save
    (with-silent-modifications (apply fn args)))
  ;;
  ;;; Extensions
  (use-package! anzu
    :after-call isearch-mode)
)
