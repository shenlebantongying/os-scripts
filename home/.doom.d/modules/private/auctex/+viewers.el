;;; lang/latex/+viewers.el -*- lexical-binding: t; -*-

(dolist (viewer (reverse +latex-viewers))
  (pcase viewer
    (`skim
     (when-let
         (app-path
          (and IS-MAC
               (file-exists-p! (or "/Applications/Skim.app"
                                   "~/Applications/Skim.app"))))
       (add-to-list 'TeX-view-program-selection '(output-pdf "Skim"))
       (add-to-list 'TeX-view-program-list
                    (list "Skim" (format "%s/Contents/SharedSupport/displayline -b %%n %%o %%b"
                                         app-path)))))

    (`sumatrapdf
     (when (and IS-WINDOWS
                (executable-find "SumatraPDF"))
       (add-to-list 'TeX-view-program-selection '(output-pdf "SumatraPDF"))))

    (`okular
     (when (executable-find "okular")
       ;; Configure Okular as viewer. Including a bug fix
       ;; (https://bugs.kde.org/show_bug.cgi?id=373855).
       (add-to-list 'TeX-view-program-list '("Okular" ("okular --noraise --unique file:%o" (mode-io-correlate "#src:%n%a"))))
       (add-to-list 'TeX-view-program-selection '(output-pdf "Okular"))))

    (`zathura
     (when (executable-find "zathura")
       (add-to-list 'TeX-view-program-selection '(output-pdf "Zathura"))))

    (`evince
     (when (executable-find "evince")
       (add-to-list 'TeX-view-program-selection '(output-pdf "Evince"))))))
