;;; -*- mode: emacs-lisp; coding: utf-8 -*-
;;======================================================================
;; 言語・文字コード関連の設定
;;======================================================================
(when (equal emacs-major-version 21) (require 'un-define))
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq system-time-locale "C")

;;======================================================================
;; フレームサイズ・位置・色など
;;======================================================================
(when window-system
  (setq initial-frame-alist
        (append '(
                  (foreground-color . "white")          ;; 文字色
                  (background-color . "black")          ;; 背景色
                  (border-color     . "black")
                  (mouse-color      . "white")
                  (cursor-color     . "LightSeaGreen")  ;; カーソルの色
                  (width            . 181)              ;; フレームの幅
                  (height           . 61)               ;; フレームの高さ
;;                   (top              . 0)                ;; Y 表示位置
;;                   (left             . 0)                ;; X 表示位置
                  )
                initial-frame-alist))

  (setq default-frame-alist initial-frame-alist)

  (set-face-background 'region "MidnightBlue")     ;; 選択中のリージョンの色
  )

;;======================================================================
;; Misc
;;======================================================================
(setq auto-mode-alist
      (append '(("\\.h\\'"            . c++-mode)    ;; Cヘッダファイルを c++-mode で開く
                ("[Mm]akefile.master" . makefile-mode)
                ("\\.m\\'"            . octave-mode))
              auto-mode-alist))

(setq frame-title-format                  ;; フレームのタイトル指定
      (concat "%b - emacs" emacs-version "@" system-name))

(mouse-wheel-mode t)                      ;; ホイールマウスを有効にする
(global-font-lock-mode t)                 ;; 文字の色つけ
(auto-compression-mode t)                 ;; 日本語infoの文字化け防止
(transient-mark-mode t)                   ;; リージョンをハイライト表示
(delete-selection-mode t)                 ;; リージョン選択時の文字入力で選択部分を削除
(recentf-mode t)                          ;; メニューに最近使ったファイルを表示
(line-number-mode t)                      ;; カーソルのある行番号を表示
(column-number-mode t)                    ;; カーソルのある桁番号を表示
(which-function-mode t)                   ;; 現在の間数名をモードラインに表示
(size-indication-mode t)                  ;; ファイルサイズを表示

(if window-system (menu-bar-mode 1) (menu-bar-mode -1))  ;; -nw で起動したときにはメニューバーを消去
(if window-system (tool-bar-mode 1) (tool-bar-mode -1))  ;; -nw で起動したときにはツールバーを消去

(setq inhibit-startup-screen t)           ;; 起動時の*GNU Emacs*バッファの消去
(setq inhibit-startup-message t)          ;; 起動時のメッセージを非表示
(setq make-backup-files nil)              ;; バックアップファイルを作成しない
(setq auto-save-default nil)              ;; 自動保存を行わない
(setq scroll-preserve-screen-position t)  ;; スクロールしてもカーソルの位置を変えない
(setq mouse-wheel-follow-mouse t)         ;; 現在のマウスカーソルのウィンドウをスクロール
(setq kill-whole-line t)                  ;; Ctrl-Kで行末の改行を含めて行全体を削除

;;----------------------------------------------------------------------
;; 左側に行数を表示
;;----------------------------------------------------------------------
(require 'linum)
(global-linum-mode t)
(setq linum-format "%4d ")

;;----------------------------------------------------------------------
;; 対応する括弧を強調表示
;;----------------------------------------------------------------------
(require 'paren)
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'single)

;;----------------------------------------------------------------------
;; エラー音の消去
;;----------------------------------------------------------------------
(setq visible-bell t)              ;; エラー音を鳴らす代わりに画面を点滅させる
(setq ring-bell-function 'ignore)  ;; エラー音を鳴らす関数を空の関数を割り当てる

;;----------------------------------------------------------------------
;; インデントの設定
;;----------------------------------------------------------------------
(setq-default tab-width 4)         ;; タブ幅を 4 に設定
(setq tab-stop-list                ;; タブ幅の倍数を設定
      '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)  ;; 4 の倍数で停止
      )
(setq-default indent-tabs-mode t)  ;; インデントにタブ文字を使用
;;(setq-default indent-tabs-mode nil)  ;; インデントに半角スペースを使用
(setq indent-line-function 'indent-relative-maybe)
(setq c-tab-always-indent t)       ;; Tabキーでインデントを実行
(setq c-basic-offset tab-width)    ;; c-default-style の設定によらずインデント幅はタブ一つ分
(setq c-default-style
  '((java-mode . "java")
    (awk-mode  . "awk")
    (other     . "gnu")))          ;; see, variable `c-style-alist'

;; python-modeのインデント設定
(add-hook 'python-mode-hook
		  (lambda()
			(setq indent-tabs-mode t)
			(setq indent-level 4)
			(setq python-indent 4)
			(setq tab-width 4)))

;;----------------------------------------------------------------------
;; 画面端まで到達した行の表示方法
;;----------------------------------------------------------------------
;;   non-nil : 画面端の外に向かって行を伸ばす
;;   nil     : 画面端で折り返す
(setq truncate-lines t)
(setq truncate-partial-width-windows t)

;;----------------------------------------------------------------------
;; カーソルを画面外に移動させた際のスクロールする行数
;;   0 : カーソルが中央に来る
;;----------------------------------------------------------------------
(setq scroll-step (/ (1- (window-height)) 4))   ;; 上下方向
(setq hscroll-step (/ (1- (window-width)) 4))   ;; 左右方向

;;----------------------------------------------------------------------
;; backward-delete-char-untabifyでの白文字の扱い方
;;   untabify : 空白文字を崩しながら削除
;;   hungry   : カーソル手前にある改行を除く全ての空白文字を削除
;;   all      : カーソル手前にある改行を含む全ての空白文字を削除
;;   nil      : 空白文字を特別扱いしない
;;----------------------------------------------------------------------
(setq backward-delete-char-untabify-method nil)

;;======================================================================
;; キーバインド・マウス
;;======================================================================
(global-set-key [zenkaku-hankaku] 'ignore)        ;; 『半角/全角』による日本語入力切替の停止
(global-set-key [?\S-\ ] 'toggle-input-method)    ;; 日本語入力切替

(global-set-key "\C-z" 'undo)                     ;; UNDO
(global-set-key "\C-h" 'backward-delete-char)     ;; Ctrl-Hでバックスペース
(global-set-key [backspace] 'backward-delete-char)              ;; タブを一文字として削除
(global-set-key [\C-\backspace] 'backward-delete-char-untabify) ;; タブを崩しながら削除

(global-set-key "\C-x\C-i" 'windmove-up)
(global-set-key "\C-x\C-k" 'windmove-down)
(global-set-key "\C-x\C-j" 'windmove-left)
(global-set-key "\C-x\C-l" 'windmove-right)

(global-set-key "\C-c\C-c" 'comment-region)    ;; リージョンをコメントアウト(最初にC-uとするとコメントが外される)

(global-set-key [mouse-2] 'ignore)                ;; ホイールクリック
(global-set-key [mouse-3] 'ignore)                ;; 右クリック

(defun down-slightly  () (interactive) (scroll-down 2))
(defun up-slightly    () (interactive) (scroll-up   2))
(defun down-slightly2 () (interactive) (scroll-down 4))
(defun up-slightly2   () (interactive) (scroll-up   4))

(global-set-key [mouse-4]        'down-slightly)  ;; 上スクロール
(global-set-key [mouse-5]        'up-slightly)    ;; 下スクロール
(global-set-key [double-mouse-4] 'down-slightly2) ;; 上スクロール(ダブル)
(global-set-key [double-mouse-5] 'up-slightly2)   ;; 下スクロール(ダブル)
(global-set-key [triple-mouse-4] 'down-slightly2) ;; 上スクロール(トリプル)
(global-set-key [triple-mouse-5] 'up-slightly2)   ;; 下スクロール(トリプル)
