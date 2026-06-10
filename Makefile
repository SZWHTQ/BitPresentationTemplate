# Makefile for the Bit theme.
#
# Targets:
#   make compile-example  — compile examples/replica.typ
#   make compile-main     — compile main.typ
#   make watch-example    — watch-compile examples/replica.typ
#   make all              — compile both documents

TYPST ?= typst

.PHONY: all compile-example compile-main watch-example watch-main

all: compile-example compile-main

compile-example:
	$(TYPST) compile examples/replica.typ --root .

compile-main:
	$(TYPST) compile main.typ --root .

watch-example:
	$(TYPST) watch examples/replica.typ --root .

watch-main:
	$(TYPST) watch main.typ --root .
