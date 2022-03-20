(use-package corfu
  :custom
  (corfu-cycle t)                
  (corfu-auto t)  
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.01)
  (corfu-separator ?\s)
  (corfu-quit-at-boundary t)
  (corfu-min-width 40)
  (corfu-on-exact-match 'insert)
  :config
  (map! :map corfu-map
        "TAB" #'corfu-insert
        "<escape>" #'corfu-quit
        "C-j" #'corfu-next
        "C-k" #'corfu-previous
        "M-d" #'corfu-doc-toggle
        "C-u" #'corfu-scroll-down
        "C-d" #'corfu-scroll-up
        ;; corfu docs
        "C-d" #'corfu-doc-toggle
        "M-j" #'corfu-doc-scroll-down
        "M-k" #'corfu-doc-scroll-up)
  :init
  (corfu-global-mode))

;; Enable Corfu completion UI
;; See the Corfu README for more configuration tips.
(use-package corfu
  :init
  (corfu-global-mode)
  (corfu-doc-mode))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
)

(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package corfu-doc
    :custom
    (corfu-doc-max-height 80))
