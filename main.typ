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
    institution: [北京理工大学],
  ),
)

#title-slide()

#toc-slide()

= 使用示例

== Hello

Welcome to the Bit Theme for Touying!

This is a green university-style presentation theme.

== Using Blocks

#green-block[Note][
  You can use `green-block` for theorems, lemmas, and highlighted content.
]

== Footnote Test

Text with a footnote#footnote[Footnote text.]

More body text here to ensure the content area is well
populated.#footnote[A second footnote for spacing verification.]

== Block Footnote Test

#green-block[Note][
  Content with a footnote#footnote[Footnote text inside a green block.]
  inside the green-block environment.
]

= 总结

== Thanks

谢谢!
