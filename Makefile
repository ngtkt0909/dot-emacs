EMACS    ?= emacs
CP        = cp -f
SRC       = ./src/.emacs.el
TGT       = ./src/.emacs.elc
TGT_HOME  = ~/.emacs.elc

.PHONY: all clean install uninstall

all:
	${EMACS} --version
	${EMACS} -batch --eval \
		"(progn \
			(setq byte-compile-warnings '(not free-vars)) \
			(setq byte-compile-error-on-warn t) \
			(batch-byte-compile))" \
		$(SRC)

clean:
	$(RM) $(TGT)

install:
	$(CP) $(TGT) $(TGT_HOME)

uninstall:
	$(RM) $(TGT_HOME)
