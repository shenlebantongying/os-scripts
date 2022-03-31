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
  (setq dashboard-items '((bookmarks . 20)
                          (recents . 20)
                          (projects . 100)
                          (agenda . 100)))
  (setq dashboard-filter-agenda-entry 'dashboard-filter-agenda-by-todo)
  (setq dashboard-set-heading-icons nil)
  (setq dashboard-set-file-icons nil)
)
