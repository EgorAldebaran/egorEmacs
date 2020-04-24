;;; package --- Summary
;;; Commentary:
;;; Main EMACS settings file, load settings from parts.
;;; Code:

(add-to-list 'load-path "-/.emacs.d")



(require 'package)

;;; éÓÔÏÞÎÉËÉ ÄÌÑ ÕÓÔÁÎÏ×ËÉ ÐÁËÅÔÏ×. äÅÌÏ × ÔÏÍ, ÞÔÏ MELPA Stable
;;; ÓÏÄÅÒÖÉÔ ÎÅ ÏÞÅÎØ Ó×ÅÖÉÅ ×ÅÒÓÉÉ, ÐÏÜÔÏÍÕ ÉÎÏÇÄÁ ÌÕÞÛÅ ÓÔÁ×ÉÔØ
;;; ÐÁËÅÔÙ ÉÚ ÏÓÎÏ×ÎÏÇÏ ÒÅÐÏÚÉÔÏÒÉÑ.

(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("melpa"        . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize nil)

;;; åÓÌÉ ÐÁËÅÔ use-package ÎÅ ÕÓÔÁÎÏ×ÌÅÎ, ÅÇÏ ÎÕÖÎÏ ÓËÁÞÁÔØ É
;;; ÕÓÔÁÎÏ×ÉÔØ
(unless (package-installed-p 'use-package)
  (message "EMACS install use-package.el")
  (package-refresh-contents)
  (package-install 'use-package))

;;; õÓÔÁÎÏ×ÉÌÉ, ÚÁÇÒÕÚÉÌÉ, ÕËÁÚÁÌÉ, ÞÔÏ ÎÅÄÏÓÔÁÀÝÉÅ ÐÁËÅÔÙ ÎÕÖÎÏ
;;; Á×ÔÏÍÁÔÉÞÅÓËÉ ÚÁÇÒÕÖÁÔØ É ÕÓÔÁÎÁ×ÌÉ×ÁÔØ.
(require 'use-package)
(setq use-package-always-ensure t)

;;; õËÁÚÙ×ÁÅÍ ÏÔËÕÄÁ ÂÒÁÔØ ÞÁÓÔÉ ÎÁÓÔÒÏÅË.
(defconst user-init-dir
  (cond ((boundp 'user-emacs-directory) user-emacs-directory)
        ((boundp 'user-init-directory) user-init-directory)
        (t "~/.emacs.d/")))

;;; æÕÎËÃÉÑ ÄÌÑ ÚÁÇÒÕÚËÉ ÎÁÓÔÒÏÅË ÉÚ ÕËÁÚÁÎÎÏÇÏ ÆÁÊÌÁ.
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file user-init-dir)))

;;; þÁÓÔÉ ËÏÎÆÉÇÕÒÁÃÉÉ. ðÏÒÑÄÏË ÎÅ ÉÍÅÅÔ ÐÒÉÎÃÉÐÉÁÌØÎÏÇÏ ÚÎÁÞÅÎÉÑ,
;;; ÏÄÎÁËÏ Ñ ÒÅËÏÍÅÎÄÕÀ ÎÅËÏÔÏÒÙÅ ÂÁÚÏ×ÙÅ ×ÅÝÉ ÐÏÍÅÝÁÔØ × ÎÁÞÁÌÏ,
;;; ÞÔÏÂÙ ÎÅ ÂÙÌÏ ÎÅÏÂÈÏÄÉÍÏÓÔÉ ×ÓÐÏÍÉÎÁÔØ ÂÁÚÏ×ÙÅ ËÏÍÁÎÄÙ EMACS
;;; ÅÓÌÉ × ÒÅÚÕÌØÔÁÔÅ ÕÌÕÞÛÅÎÉÑ ÓÌÏÍÁÅÔÓÑ ÏÄÉÎ ÉÚ ÂÁÚÏ×ÙÈ ËÏÎÆÉÇÏ×.





;;; ã×ÅÔÎÙÅ ÓËÏÂÏÞËÉ
(use-package
  rainbow-delimiters
  :init (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
        (setq rainbow-delimiters-max-face-count 9))

;;; Scrolling
(setq scroll-step               1) ;; one line
(setq scroll-margin            10) ;; scroll buffer to 10 lines at going to last line
(setq scroll-conservatively 10000)
(setq directory-free-space-args "-Pm")

;; ðÏÄÓ×ÅÔËÁ ÒÅÚÕÌØÔÁÔÏ× ÐÏÉÓËÁ É ×Ó£ ÔÁËÏÅ
(setq search-highlight        t)
(setq query-replace-highlight t)

(setq column-number-mode 1) ;; îÏÍÅÒÁ ÓÔÒÏË ÓÌÅ×Á
(setq use-dialog-box nil)   ;; îÅ ÎÕÖÎÙ ÎÁÍ ÄÉÁÌÏÇÉ, ÂÕÄÅÍ ×Ó£ ÒÕËÁÍÉ ÄÅÌÁÔØ
(setq-default tab-width          4) ;; úÁÍÅÎÉÔØ TAB ÎÁ 4 ÐÒÏÂÅÌÁ
(setq-default standart-indent    4) ;; óÔÁÎÄÁÒÔÎÙÊ ÏÔÓÔÕÐ - 4 ÐÒÏÂÅÌÁ
(setq backup-inhibited t)           ;; Backup'Ù ÔÏÖÅ ÄÅÌÁÔØ ÎÅ ÂÕÄÅÍ
(setq auto-save-default nil)        ;; á×ÔÏÓÏÈÒÁÎÅÎÉÅ ÎÅ ÎÕÖÎÏ


(setq-default c-basic-offset 4 c-indent-level 4 indent-tabs-mode nil) ;; TAB'Ù ÎÅ ÎÕÖÎÙ

(setq-default save-place t) ;; ðÏÍÎÉÔØ, ÇÄÅ ÂÙÌ ËÕÒÓÏÒ × ÐÒÏÛÌÙÊ ÒÁÚ

;;; îÁÖÁÔÉÅ Insert ÂÏÌØÛÅ ÎÅ ×ËÌÀÞÁÅÔ ÒÅÖÉÍ ÚÁÍÅÎÙ
(define-key global-map [(insert)] nil)

;;; á×ÔÏÆÏÒÍÁÔÉÒÏ×ÁÎÉÅ ÐÅÒÅÄ ÓÏÈÒÁÎÅÎÉÅÍ
(defun format-current-buffer()
  (indent-region (point-min)
                 (point-max)))
(defun untabify-current-buffer()
  (if (not indent-tabs-mode)
      (untabify (point-min)
                (point-max)))
  nil)
(add-to-list 'write-file-functions 'untabify-current-buffer)
(add-to-list 'write-file-functions 'delete-trailing-whitespace)


(desktop-save-mode 1) ;;; ðÏÍÎÉÔØ, ËÁËÉÅ ÆÁÊÌÙ ÂÙÌÉ ÏÔËÒÙÔÙ × ÐÒÏÛÌÙÊ ÒÁÚ
(fset 'yes-or-no-p 'y-or-n-p) ;;; ÷ÍÅÓÔÏ yes É no ÐÏÎÉÍÁÔØ y É n
(global-hl-line-mode 1) ;;; ðÏÄÓ×ÅÔËÁ ÔÅËÕÝÅÊ ÓÔÒÏËÉ
(global-linum-mode 1)   ;;; ðÏËÁÚÙ×ÁÔØ ÎÏÍÅÒÁ ÓÔÒÏË ×ÓÅÇÄÁ
(menu-bar-mode -1)      ;;; á ÍÅÎÀ - ÎÉËÏÇÄÁ
(scroll-bar-mode -1)    ;;; óËÒÏÌÌÂÁÒ ÎÅ ÎÕÖÅÎ
(tool-bar-mode -1)      ;;; ôÕÌÂÁÒ ÎÅ ÎÕÖÅÎ


;; éËÏÎËÉ × ÓÔÁÔÕÓ-ÂÁÒÅ
(use-package
  mode-icons
  :config (mode-icons-mode 1))

;; ðÏËÁÚÙ×ÁÔØ ÏÔÓÔÕÐÙ ×Ï ×ÓÅÈ ÒÅÖÉÍÁÈ
(use-package
  indent-guide
  :config (indent-guide-global-mode 1))


(setq frame-title-format "EgorEmacs")
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode)
(fset 'yes-or-no-p 'y-or-n-p)
(ido-mode)



(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)


;;;hello worldhwllo
(global-set-key [f5] 'call-last-kbd-macro)


(require 'dired)
(setq dired-recursive-deletes 'top)

;;(require '/home/alik/google/test/google-translate-core-test.el)
;;(global-set-key (kdb "<f5>"))


(setq imenu-auto-rescan    t)
(setq imenu-use-popup-menu nil)
(global-set-key (kbd "<f6>") 'imenu)

(show-paren-mode t)
(setq show-paren-style 'expression)

(electric-pair-mode    1)
(setq ring-bell-function 'ignore)
(setq redisplay-dont-pause t)
(setq use-dialog-box nil)

(setq display-time-24hr-format t)
(display-time-mode    t)


(require 'ido)
(ido-mode    t)
(icomplete-mode    t)
(ido-everywhere    t)
(setq ido-virtual-buffers    t)
(setq ido-enable-flex-matching    t)

(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)


(setq x-select-enable-clipboard  t)
(setq search-highlight     t)
(setq query-replace-highlight  t)

(global-set-key "\eg" 'goto-line)
(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)


(require 'package)

;; If you want to use latest version
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; If you want to use last tagged version
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(package-initialize)


(global-set-key (kbd "\ed") 'other-window)
(global-set-key (kbd "<f1>") 'html-mode)
(global-set-key (kbd "<f2>") 'php-mode)
(global-set-key (kbd "<f3>") 'js-mode)
(global-set-key (kbd "<f11>") 'shell)
(global-set-key (kbd "<f8>") 'eww)
(global-set-key (kbd "<f10>") 'google-translate-smooth-translate)
(keyboard-translate ?\C-h ?\C-?)

(set-default 'truncate-lines t)
(ac-config-default)

(defun setup-ac-for-haml ()
  ;; Require ac-haml since we are setup haml auto completion
  (require 'ac-haml)
  ;; Require default data provider if you want to use
  (require 'ac-html-default-data-provider)
  ;; Enable data providers,
  ;; currently only default data provider available
  (ac-html-enable-data-provider 'ac-html-default-data-provider)
  ;; Let ac-haml do some setup
  (ac-haml-setup)
  ;; Set your ac-source
  (setq ac-sources '(ac-source-haml-tag
                     ac-source-haml-attr
                     ac-source-haml-attrv))
  ;; Enable auto complete mode
  (auto-complete-mode))

(add-hook 'haml-mode-hook 'setup-ac-for-haml)
```




    (defun ecb-activated-in-selected-frame ()
    "A hack to use ECB in multiple frames. It first deactivates ECB, then
    activate it in current frame."
    (interactive)
    (let ((current-frame (selected-frame)))
        ; The frame foucs change when activating or deactivating ECB is weird, so
        ; activate current selected frame explicitly.
        (if (and (boundp 'ecb-minor-mode) (ecb-minor-mode))
            (ecb-deactivate)
        )
        (select-frame current-frame)
        (ecb-activate)
        )
    )





(window-numbering-mode t)


(global-set-key "\ei" '(lambda () (interactive) (insert ?\$)))
(global-set-key "\ej" '(lambda () (interactive) (list-buffers)))

;;vnak voprosa
(global-set-key "\eq" '(lambda () (interactive) (insert ?\?)))

;;new eww how
(defun eww-new ()
  (interactive)
  (let ((url (read-from-minibuffer "yee fuck the system new url: ")))
    (switch-to-buffer (generate-new-buffer "eww"))
    (eww-mode)
    (eww url)))


;;;kdb macro
(global-set-key (kbd "\eo") 'call-last-kbd-macro)
(global-set-key (kbd "\ep") 'kmacro-cycle-ring-previous)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-x C-o") 'isearch-forward)
(global-set-key (kbd "\es") 'other-window)
(global-set-key (kbd "C-o") 'other-window)
;;;kdb macro new cicle
(global-set-key (kbd "\e[") 'kmacro-cycle-ring-next)


;;kill windows and buffers
(global-set-key (kbd "<f7>") 'kill-buffer-and-window)
;;replace string
(global-set-key (kbd "<f4>") 'replace-string)

;;auto-save-default for emacs
(defun full-auto-save()
  (interactive)
  (save-excursion
    (dolist (buf (buffer-list))
      (set-buffer buf)
      (if (and (buffer-file-name) (buffer-modified-p))
          (basic-save-buffer)))))
(add-hook 'auto-save-hook 'full-auto-save)
