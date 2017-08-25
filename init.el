;; install packages
;; dracular-theme -- https://github.com/dracula
;; powerline -- https://github.com/jonathanchu/emacs-powerline
;; multiple-cursors -- https://github.com/magnars/multiple-cursors.el
;; projectile -- https://github.com/bbatsov/projectile
;; magit -- https://magit.vc/

;; init file

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(custom-safe-themes
   (quote
    ("26e02acd2ef70e7d9316a6eb1e55166702c3506ea902f729526424a069385c3d" default)))
 '(ns-auto-hide-menu-bar t)
 '(package-selected-packages (quote (powerline-evil powerline yasnippet company)))
 '(show-paren-mode t)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'after-init-hook 'global-company-mode)

;; custom theme configurations

;; barsss
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; set default font
(set-frame-font
 "-*-Menlo-normal-normal-normal-*-14-*-*-*-m-0-iso10646-1")

;; set default frame size
(setq initial-frame-alist
      '((width . 120)
	(height . 65)))

;; material theme setup
(load-theme 'material t)

;; powerline setup
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
(require 'powerline)
(setq powerline-arrow-shape 'half)
(custom-set-faces
 '(mode-line ((t (:foreground "#030303" :background "#77f442" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;; multiple cursor setup
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; company-jedi setup
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

;; magit setup
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; exec-path-from-shell setup
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; anaconda
(add-hook 'python-mode-hook 'anaconda-mode)
