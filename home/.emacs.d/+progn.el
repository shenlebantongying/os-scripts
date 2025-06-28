;; -*- lexical-binding: t -*-


;; Text Editing

(defun +cut-to-clipboard ()
  "replace C-w that doesn't do more."
  (interactive)
  (if (use-region-p)
      (kill-new (delete-and-extract-region (region-beginning) (region-end)))
    (message "no region.")))

(defun +kill-to-linebegin ()
  "kill from point to beginning of line."
  (interactive)
  (kill-line 0))

(defun +goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))


;; Act on section / thing at here.

(defun +shell-command-on-region-or-line ()
  "Run selected text or use the current line."
  (interactive)
  (shell-command
   (if (use-region-p)
       (buffer-substring (region-beginning) (region-end))
     (thing-at-point 'line t))))


(defun +invoke-compile-with-selection ()
  "run compile commands"
  (interactive)
  (if (use-region-p) (compile (buffer-substring (region-beginning) (region-end)))
    (message "m: no thing was selected.")))

(defun +consult-word-here ()
  "Use current word as initial term"
  (interactive)
  (consult-line (current-word) nil))

(defun +merriam-webster-dict-at-point ()
  "Search the word at point"
  (interactive)
  (+xah-open-in-external-app (concat "https://www.merriam-webster.com/dictionary/" (current-word))))


;; Acts on Buffer

(defun +reload-file ()
  "reload file from the disk (not auto-save) without confirm"
  (interactive)
  (revert-buffer t t t)
  (message "%s" "File reloaded."))

(defun +rename-file-and-buffer ()
  "Rename current buffer and if the buffer is visiting a file, rename it too."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (rename-buffer (read-from-minibuffer "New name: " (buffer-name)))
      (let* ((new-name (read-file-name "New name: " (file-name-directory filename)))
             (containing-dir (file-name-directory new-name)))
        (make-directory containing-dir t)
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun +terminal-here ()
  "Open terminal at the path of current file"
  (interactive)
  (call-process-shell-command
   (let ((pwd (expand-file-name default-directory)))
     ;;(file-name-directory buffer-file-name)
     (cond
      (IS-MAC
       (concat "/Applications/WezTerm.app/Contents/MacOS/wezterm start --new-tab --cwd " pwd))
      (IS-LINUX
       (concat "/usr/bin/kitty -1 -d " pwd))))
   nil 0))

(defun +open-here-in-external-file-manager ()
  "Open file in external program"
  (interactive)
  (+xah-open-in-external-app (file-name-directory (buffer-file-name))))


;; Utility

(defun +xah-open-in-external-app (&optional Fname)
  "Open the current file or dired marked files in external app.
URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'"
  (interactive)
  (let (xfileList xdoIt)
    (setq xfileList
          (if Fname
              (list Fname)
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list buffer-file-name))))
    (setq xdoIt (if (<= (length xfileList) 10) t (y-or-n-p "Open more than 10 files? ")))
    (when xdoIt
      (cond
       ((string-equal system-type "darwin")
        (mapc (lambda (xfpath) (shell-command (concat "open " (shell-quote-argument xfpath)))) xfileList))
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (xfpath)
                (call-process shell-file-name nil 0 nil
                              shell-command-switch
                              (format "%s %s"
                                      "xdg-open"
                                      (shell-quote-argument xfpath))))
              xfileList))))))

(defun +kill-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))
