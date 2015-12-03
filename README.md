# README

## How to setup your emacs environment

* create backup of your .emacs and .emacs.d file/folder and move them to some another
* clone repository to your home directory
* create ~/.emacs file and put "(load-file "~/.emacs.d/init.el")" to it
* start your emacs

## Packages

All emacs packages are already in repository. You need install git > 1.9.1. You can
use ppa:git-team/ppa for ubuntu.

## Using Django specific commands

This is a my .emacs file content for Django support
```lisp
(setq sql-connection-alist
      '((lxc-chain-db (sql-product 'mysql)
			(sql-port 3306)
			(sql-user "root")
			(sql-server "127.0.0.1")
			(sql-password "12345")
			(sql-database "chain"))
	) )

(defun chain-db ()
  (interactive)
  (my-sql-connect 'mysql 'lxc-chain-db))

(defun site-do-init ()
  (interactive)
  (elpy-set-project-root "~/projects/freelance/my/site_do/")
  (pyvenv-workon "django")
  (setenv "DJANGO_SETTINGS_MODULE" "settings")
  (setq elpy-test-django-runner-command '("python" "manage.py" "test" "--noinput"))
  (setq elpy-set-test-runner '("Django Discover"))
  )

(defun django-seo-init ()
  (interactive)
  (elpy-set-project-root "~/projects/freelance/my/django_seo")
  (pyvenv-workon "django")
  (setenv "DJANGO_SETTINGS_MODULE" "settings")
  (setq elpy-test-django-runner-command '("python" "manage.py" "test" "--noinput"))
  (setq elpy-set-test-runner '("Django Discover"))
  )

(defun otdamknigi-init ()
  (interactive)
  (elpy-set-project-root "~/projects/freelance/my/otdamknigi/otdamknigi/")
  (pyvenv-workon "otdamknigi")
  (setenv "DJANGO_SETTINGS_MODULE" "settings")
  (setq elpy-test-django-runner-command '("python" "manage.py" "test" "--noinput"))
  (setq elpy-set-test-runner '("Django Discover"))
  )

(defun chain-reviews-init ()
  (interactive)
  (elpy-set-project-root "~/projects/freelance/my/chain_reviews/chain_reviews/")
  (pyvenv-workon "chain_reviews")
  (setenv "DJANGO_SETTINGS_MODULE" "chain_reviews.settings")
  (setq elpy-test-django-runner-command '("python" "manage.py" "test" "--noinput"))
  (setq elpy-set-test-runner '("Django Discover"))
  )


(load-file "~/.emacs.d/init.el")
```