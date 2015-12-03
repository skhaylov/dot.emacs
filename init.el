(require 'package)
(package-initialize)

;; Getting more packages
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "https://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("870a63a25a2756074e53e5ee28f3f890332ddc21f9e87d583c5387285e882099" "118717ce0a2645a0cf240b044999f964577ee10137b1f992b09a317d5073c02d" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "3ed645b3c08080a43a2a15e5768b893c27f6a02ca3282576e3bc09f3d9fa3aaa" "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132" "76659fd7fc5ce57d14dfb22b30aac6cf0d4eb0a279f4131be3945d3cfff10bc6" "9b402e9e8f62024b2e7f516465b63a4927028a7055392290600b776e4a5b9905" default)))
 '(magit-revert-buffers t)
 '(msb-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "microsoft" :family "Consolas for Powerline"))))
 '(flycheck-error ((t (:background "#b22222" :underline (:color "#ccc" :style wave)))))
 '(flycheck-warning ((t (:background "#d2691e" :underline (:color "#ffffff" :style wave)))))
 '(flymake-errline ((((class color)) (:background "tomato4"))))
 '(flymake-warnline ((((class color)) (:background "chocolate3"))))
 '(highlight-indentation-face ((t (:inherit fringe)))))


;; linum
(global-linum-mode t)

;; Global set window keys
(global-set-key (kbd "C-c u") 'windmove-up)
(global-set-key (kbd "C-c d") 'windmove-down)
(global-set-key (kbd "C-c l") 'windmove-left)
(global-set-key (kbd "C-c r") 'windmove-right)

;; Python hooks
(elpy-enable)
(global-set-key (kbd "C-c t") 'elpy-test-django-runner)


;; SQL
(add-hook 'sql-interactive-mode-hook
	  (lambda ()
	    (toggle-truncate-lines t)))


(defun my-sql-connect (product connection)
  (setq sql-product product)
  (sql-connect connection))


(defun django-settings-module ()
  "Get Django settings module"
  (getenv "DJANGO_SETTINGS_MODULE") )

(defun django-settings-conf ()
  "Get Django settings key with value"
  (concat "--settings=" (django-settings-module)) )

;; projects hooks
(defun elpy-django-test-full (top file module test)
  "Run Django tests for whole project"
  (interactive (elpy-test-at-point))
  (let (conf)
    (setq conf (django-settings-conf))
    (elpy-test-run top
		 "python" "manage.py" "test" "--noinput" conf ;; "--keepdb"
		 )) )

(defun elpy-django-test-single-app (top file module test)
  "Run Django test for single application"
  (defun get-app (app)
    (interactive (list (read-string "Django app name: ")))
    (message app) )

  (interactive (elpy-test-at-point))
  (let (app conf)
    (setq app (call-interactively 'get-app))
    (setq conf (django-settings-conf))
    (elpy-test-run top
		   "python" "manage.py" "test" "--noinput" conf  app;; "--keepdb"
    		   )) )


;; ELPY KBD
(global-set-key (kbd "<f5>") 'elpy-django-test-full)
(global-set-key (kbd "<f6>") 'elpy-django-test-single-app)

;; Disable autosave
(setq backup-inhibited t)
(setq auto-save-default nil)

;; IDO
(ido-mode t)

;; Delete trailing whitespace
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; WEB-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(defun my-web-mode-hook ()
  ;; indentation
  ;; HTML offset indentation
  (setq web-mode-markup-indent-offset 2)
  ;; CSS offset indentation
  (setq web-mode-code-indent-offset 2)
  ;; Script offset indentation (for JavaScript, Java, PHP, etc.)
  (setq web-mode-css-indent-offset 2)
  ;; HTML content indentation
  (setq web-mode-indent-style 2)

  ;; padding
  ;; For <style> parts
  (setq web-mode-style-padding 1)
  ;; For <script> parts
  (setq web-mode-script-padding 1)
  ;; For multi-line blocks
  (setq web-mode-block-padding 0))

(add-hook 'web-mode-hook 'my-web-mode-hook)


;; MAGIT
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x c o") 'magit-branch-and-checkout)
(global-set-key (kbd "C-x p c") 'magit-push-current)
(magit-revert-buffers t)

;; JS2
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; NEO tree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; RFringe
(require 'rfringe)

;; Recentf
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key [M-f12] 'recentf-open-files)

;; fixme
(fixme-mode t)

;; Customize style
(load-theme 'zenburn t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq line-number-mode t)
(setq column-number-mode t)
(setq inhibit-startup-message t) ;; hide the startup message

;; Compile.el
(setq compilation-scroll-output t)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; (elpy-use-ipython)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
