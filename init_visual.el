;;;; Emacs looks and feel

;;; Font
(when (emacs-osx-p)
 (set-face-attribute 'default nil
                     :family "Consolas" :height 120 :weight 'normal)
 (setq default-frame-alist '((width . 100)
                             (height . 65))))

(when (emacs-bloomberg-p)
  (setq default-frame-alist
        (append `(;;(font . ,(choose-frame-font))
                  (font . "Monospace 12")
                  ;;(font . "-*-verdana-medium-r-*-*-12-*-*-*-*-*-*-*")
                  ;;(font . "-*-consolas-medium-r-*-*-*-*-*-*-*-*-*-*")
                  ;;(font . "-*-courier-*-r-*-*-14-*-*-*-*-*-*-*")
                  (width . 120)
                  (height . 65)
                  (vertical-scroll-bars . right)
                  (internal-border-width . 0)
                  ;;(border-width . 0)
                  (horizontal-scroll-bars . t))
                default-frame-alist)))

;;; Remove the toolbar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

;;; Remove the menu bar
;;(menu-bar-mode -1)

;;; Remove welcome message
(setq inhibit-startup-message t)

;;; Disable blinking cursor
(when (fboundp 'blink-cursor-mode)
  (blink-cursor-mode -1))

;;; Display column number and line numbers
(column-number-mode 1)
(if (boundp 'global-linum-mode)
    (global-linum-mode t))

;;; Highlight cursor
(global-hl-line-mode 1)

;;; Smooth scrolling
(setq scroll-step 1)
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-up-aggressively 0
      scroll-down-aggressively 0
      scroll-preserve-screen-position t)

;;; Scrollbar on the right
;;(setq scroll-bar-mode-explicit t)
;;(set-scroll-bar-mode `right)

;;; Syntax highlighing
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration
      '((emacs-lisp-mode . t)
        (c-mode . t)
        (C++-mode . 1) ;; t or 1 or 2
        (t . t)))

(when (emacs-24-p)
  ;; Lazy font-lock to avoid the bug in Emacs 24
  (cond ((fboundp 'jit-lock-mode)
         (setq jit-lock-chunk-size 5000
               jit-lock-context-time 0.2
               jit-lock-defer-time .1
               jit-lock-stealth-nice 0.2
               jit-lock-stealth-time 5
               jit-lock-stealth-verbose nil)
         (jit-lock-mode t))
        ((fboundp 'turn-on-lazy-shot)
         (add-hook 'font-lock-mode-hook 'turn-on-lazy-shot))
        ((fboundp 'turn-on-lazy-lock)
         (add-hook 'font-lock-mode-hook 'turn-on-lazy-lock)
         (setq lazy-lock-stealth-time 10)
         (setq lazy-lock-minimum-size 10000)))
  ;;(setq fci-always-use-textual-rule t)
  )

;;; Better frame title with buffer name
(setq frame-title-format (concat "%b - emacs@" system-name))

;;; Disable beep
;;(setq visual-bell t)

;;; Colorize selection
(transient-mark-mode 'on)

;;; Show matching parentheses
(show-paren-mode t)

;;; Mouse selection
(setq x-select-enable-clipboard t)

;;; Full screen
(when (and (emacs-24-p) (emacs-osx-p))
  (defun toggle-fullscreen ()
    "Toggle full screen"
    (interactive)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))
