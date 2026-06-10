# Makefile for the Bit theme (bit-presentation-template).
#
# Targets:
#   make install          — install the package to the @local Typst namespace
#   make uninstall        — remove the installed @local package
#   make compile-example  — compile examples/replica.typ
#   make compile-main     — compile main.typ
#   make watch-example    — watch-compile examples/replica.typ
#   make all              — compile both documents
#   make clean            — remove generated PDFs

TYPST   ?= typst
NAME    := bit-presentation-template
VERSION := 0.1.0

# Typst's local package namespace lives under the platform data dir:
#   macOS:  ~/Library/Application Support/typst/packages/local
#   Linux:  $XDG_DATA_HOME/typst/packages/local  (default ~/.local/share)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
  DATA_DIR := $(HOME)/Library/Application Support/typst
else
  DATA_DIR := $(if $(XDG_DATA_HOME),$(XDG_DATA_HOME),$(HOME)/.local/share)/typst
endif
LOCAL_PKG_DIR := $(DATA_DIR)/packages/local/$(NAME)/$(VERSION)

.PHONY: all install uninstall compile-example compile-main watch-example watch-main clean

all: compile-example compile-main

# Install into the local package namespace so `@local/$(NAME):$(VERSION)`
# resolves and the entry points compile without `--root`.  Mirrors the
# `exclude` list in typst.toml.
install:
	rm -rf "$(LOCAL_PKG_DIR)"
	mkdir -p "$(LOCAL_PKG_DIR)"
	rsync -a \
	  --exclude 'examples' \
	  --exclude 'main.typ' \
	  --exclude 'main.pdf' \
	  --exclude 'Makefile' \
	  --exclude '.github' \
	  --exclude '.gitignore' \
	  --exclude '.git' \
	  ./ "$(LOCAL_PKG_DIR)/"
	@echo "Installed $(NAME):$(VERSION) to the @local namespace."

uninstall:
	rm -rf "$(LOCAL_PKG_DIR)"
	@echo "Removed $(NAME):$(VERSION) from the @local namespace."

compile-example:
	$(TYPST) compile examples/replica.typ

compile-main:
	$(TYPST) compile main.typ

watch-example:
	$(TYPST) watch examples/replica.typ

watch-main:
	$(TYPST) watch main.typ

clean:
	rm -f main.pdf examples/replica.pdf
