;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;; macos titlebar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . light)) ;; or dark - depending on your theme
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Giovanni Martina"
      user-mail-address "drayah@gmail.com")

;; personal helper functions
(require 'extras "~/.doom.d/extras.el")

;; theme
(setq doom-theme 'doom-solarized-light)
(doom-themes-treemacs-config)
(doom-themes-org-config)

;; fonts
(setq doom-font (font-spec :family "SFMono Nerd Font" :size 13)
      doom-big-font (font-spec :family "SFMono Nerd Font" :size 16))

;; indent
(setq-default evil-shift-width 2
              tab-width 2)

;; don't confirm on exit
(setq confirm-kill-emacs nil)

;; don't interpret right option key
(setq ns-right-alternate-modifier 'none)

;; prettify symbols
(global-prettify-symbols-mode 1)

;; add modes for other extensions
(add-to-list 'auto-mode-alist '("\\.adoc\\'" . adoc-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.repl\\'" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.json.base\\'" . javascript-mode))

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(setq parinfer-extensions '(defaults
                            smart-tab
                            smart-yank
                            paredit
                            pretty-parens
                            evil))

;; paredit keybindings
(global-set-key (kbd "C-)") 'paredit-forward-slurp-sexp)
(global-set-key (kbd "C-(") 'paredit-backward-slurp-sexp)
(global-set-key (kbd "M-r") 'raise-sexp)

;; use a manually compiled parinfer-rust-library via:
;; cargo build --release --features emacs (with the emacs crate set to 0.18.0)
;; (since the standard one that gets downloaded automatically doesn't work on the apple m1 pro)
(use-package! parinfer-rust-mode
  :init (setq parinfer-rust-library "~/dev/parinfer-rust/target/release/libparinfer_rust.dylib")
  :hook clojure-mode)

;; cider
(setq cider-show-error-buffer nil)

(after! cider
  (set-popup-rule! "^\\*cider-repl" :side 'right :width 0.5))

;; lsp
(setq lsp-ui-doc-enable nil)
(setq lsp-lens-enable nil)
(setq ignore-lsp-dirs '("[/\\\\]\\.circleci\\'"
                        "[/\\\\]\\.clj-kondo\\'"
                        "[/\\\\]\\.github\\'"
                        "[/\\\\]\\.cpcache\\'"
                        "[/\\\\]\\.lsp\\'"
                        "[/\\\\]\\.node_modules\\'"
                        "[/\\\\]\\.shadow-cljs\\'"
                        "[/\\\\]\\resources/public/js\\'"
                        "[/\\\\]\\resources/public/css\\'"
                        "[/\\\\]target\\'"
                        "[/\\\\]diagrams\\'"
                        "[/\\\\]diagrams-output-test\\'"
                        "[/\\\\]mortician-result\\'"
                        "[/\\\\]sequence-diagrams-output\\'"
                        "[/\\\\]visual-flow\\'"))

(after! lsp-mode
  (setq lsp-file-watch-ignored-directories (append lsp-file-watch-ignored-directories
                                                   ignore-lsp-dirs)))

;; web
(after! web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

;; plantuml
(after! plantuml-mode
  (setq plantuml-default-exec-mode 'jar)
  (setq plantuml-output-type "png"))
