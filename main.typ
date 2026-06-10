// main.typ
// Minimal entry point for quick testing of the Bit theme.
//
// Compile:
//   typst compile main.typ --root .

#import "@preview/touying:0.7.4": *
#import "themes/bit.typ": *
#import "themes/tokens.typ": *

#show: bit-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  config-info(
    title: [Work Progress],
    author: [Author],
    institution: [北京理工大学]
  ),
)

#title-slide()

#toc-slide()

= 使用示例

== Hello
=== test

Welcome to the Bit Theme for Touying!

This is a green university-style presentation theme.

== Using Blocks

#green-block[Note][
  You can use `green-block` for theorems, lemmas#footnote[Footnote text], and highlighted #footnote[Another footnote] content. #lorem(30)
]

= 总结

==
#place(center + horizon, dy: 5.5cm)[
  #text(size: 36pt, weight: "bold")[谢谢]
] 