;;; -*- lexical-binding: t; -*-

(defun +consult-word-at-point ()
  "Use current word as initial term"
  (interactive)
  (consult-line (current-word) nil))

;; context menu mode
(context-menu-mode)
(defun context-menu-my (menu click)
  "Polulate MENU with command to consult word"
  ;;(mouse-set-point click)
  (define-key-after menu [consult-word-at-point]
    '(menu-item "Consult word ..." consult-word-at-point
                :help "Consult word at point"))
  menu)

(add-to-list 'context-menu-functions
             #'context-menu-ffap)
(add-hook 'context-menu-functions
          #'context-menu-my)

;; helper
(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))

(defun select-match-parens ()
  (interactive)
  (set-mark (point))
  (goto-match-paren 1))

(defun crux-rename-file-and-buffer ()
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


(defun +reload-file ()
  "reload file from the disk (not auto-save) without confirm"
  (interactive)
  (revert-buffer t t t)
  (message "%s" "File reloaded."))

(defun xah-open-in-external-app (&optional Fname)
  "Open the current file or dired marked files in external app.
When called in emacs lisp, if Fname is given, open that.

URL `http://xahlee.info/emacs/emacs/emacs_dired_open_file_in_ext_apps.html'
Version: 2019-11-04 2023-04-05 2023-06-26"
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
       ((string-equal system-type "windows-nt")
        (let ((xoutBuf (get-buffer-create "*xah open in external app*"))
              (xcmdlist (list "PowerShell" "-Command" "Invoke-Item" "-LiteralPath")))
          (mapc
           (lambda (x)
             (message "%s" x)
             (apply 'start-process (append (list "xah open in external app" xoutBuf) xcmdlist (list (format "'%s'" (if (string-match "'" x) (replace-match "`'" t t x) x))) nil)))
           xfileList)
          ;; (switch-to-buffer-other-window xoutBuf)
          )
        ;; old code. calling shell. also have a bug if filename contain apostrophe
        ;; (mapc (lambda (xfpath) (shell-command (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'" (shell-quote-argument (expand-file-name xfpath)) "'"))) xfileList)
        )
       ((string-equal system-type "darwin")
        (mapc (lambda (xfpath) (shell-command (concat "open " (shell-quote-argument xfpath)))) xfileList))
       ((string-equal system-type "gnu/linux")
        (mapc (lambda (xfpath)
                (call-process shell-file-name nil 0 nil
                              shell-command-switch
                              (format "%s %s"
                                      "xdg-open"
                                      (shell-quote-argument xfpath))))
              xfileList))
       ((string-equal system-type "berkeley-unix")
        (mapc (lambda (xfpath) (let ((process-connection-type nil)) (start-process "" nil "xdg-open" xfpath))) xfileList))))))

(defun +kill-process-at-point ()
  (interactive)
  (let ((process (get-text-property (point) 'tabulated-list-id)))
    (cond ((and process
                (processp process))
           (delete-process process)
           (revert-buffer))
          (t
           (error "no process at point!")))))

(defun +merriam-webster-dict-at-point ()
  "Search the word at point"
  (interactive)
  (+xah-open-in-external-app (concat "https://www.merriam-webster.com/dictionary/" (current-word)))
  )

(defun +open-dir-in-external-file-manager ()
  "Open file in external program"
  (interactive)
  (+xah-open-in-external-app (file-name-directory (buffer-file-name))))

(defun +shell-command-on-region-or-line ()
  "Run selected text or use the current line."
  (interactive)
  (shell-command
   (if (use-region-p)
       ;; current selection
       (buffer-substring (region-beginning) (region-end))
     ;; current line
     (thing-at-point 'line t))))
