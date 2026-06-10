// lib.typ
// Package entrypoint for bit-presentation-template.
//
// Re-exports the full public API.  Importing this module is equivalent
// to importing themes/bit.typ (which transitively re-exports the design
// tokens from themes/tokens.typ and the components from
// themes/components.typ).
//
// Usage (as a published package):
//   #import "@preview/bit-presentation-template:0.1.0": *
//
// Usage (vendored, from the repo root):
//   #import "lib.typ": *

#import "themes/bit.typ": *
