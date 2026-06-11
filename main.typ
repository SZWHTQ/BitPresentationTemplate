// main.typ
// Minimal entry point for quick testing of the Bit theme.
//
// Compile (no --root needed; imports the installed @local package):
//   typst compile main.typ
//
// Run `make install` from the repo root first if you haven't installed
// the package to your local Typst namespace yet.

#import "@local/bit-presentation-template:0.1.0": *

#show: bit-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  config-info(
    title: [Work Progress],
    author: [Author],
    institution: [北京理工大学],
  ),
  config-store(
    heading-subtitle: true,
  ),
)

#title-slide()

#toc-slide()

= 使用示例

== Hello
=== Heading Subtitle

Welcome to the Bit Theme for Touying!

This is a green university-style presentation theme.

==

This slide has no header because the level-2 heading is empty.

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

#slide(title: none)[
  This manual slide also has no header.
]

= 总结

== Thanks

谢谢!
