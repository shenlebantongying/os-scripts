(use-package! dashboard
  :custom
  (dashboard-page-separator "\n")
  :config
  (dashboard-setup-startup-hook)
  ;; no shits
  (setq dashboard-banner-logo-title nil)
  (setq dashboard-startup-banner nil)
  (setq dashboard-set-navigator nil)
  (setq dashboard-init-info nil)
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((bookmarks . 50)
                          (recents . 30)
                          (projects . 100)))
  (setq dashboard-set-heading-icons nil)
  (setq dashboard-set-file-icons nil)
)
