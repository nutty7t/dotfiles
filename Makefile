.PHONY: hooks check encrypt decrypt

GIT_ROOT := $(shell git rev-parse --show-toplevel)

hooks:
	ln --symbolic --force \
		$(GIT_ROOT)/bin/mischief-managed \
		$(GIT_ROOT)/.git/hooks/pre-commit

check:
	./bin/mischief-managed check

encrypt:
	./bin/mischief-managed encrypt

decrypt:
	./bin/mischief-managed decrypt
