// examples/replica.typ
// Demo presentation for the Bit theme — heading-based authoring.
//
// Compile (no --root needed; imports the installed @local package):
//   typst compile examples/replica.typ
//
// If you have not installed the package locally yet, run `make install`
// from the repo root first (see README → "Install locally").

#import "@local/bit-presentation-template:0.1.0": *

#show: bit-theme.with(
  aspect-ratio: "16-9",
  progress-bar: false,
  config-info(
    title: [Bit Theme Demo],
    author: [Feng Kaiyu, Jiang Yingqi],
    institution: [北京理工大学],
    // Date defaults to datetime.today() from the theme.
    // Logo defaults to the bundled bit_logo.pdf; pass `logo: none` to drop it.
  ),
  // Header emblem and optional title-slide institution mark.  Both default
  // to the bundled assets; override or set to `none` to customize.
  // config-store(
  //   header-logo: bit-logo(),
  //   title-institute-logo: bit-emblem(),
  // ),
)

// ---- 1. Title slide ----

#title-slide()

// ---- 2. Table of contents ----

#toc-slide()

// ---- Section 1 ----

= 使用示例

== Introduction

This is a demonstration of the Bit theme for Touying — a green
university-style presentation theme designed for academic use.

The theme provides a clean and professional look with a deep green
header bar, a matching footer, and a set of ready-to-use components
including block environments and title slides.

The overall design is inspired by classic LaTeX Beamer themes
commonly used at Beijing Institute of Technology.

== Subtitle Demo

This slide is created by a level-2 heading.  The slide title in the
header bar is taken from the heading text automatically.

For slides that need a subtitle, use the explicit `#slide()`
form with `subtitle:`.

// Explicit slide for subtitle demonstration.
#slide(title: [Key Lemma], subtitle: [Preemptive broadcast strategy])[
  This slide demonstrates the subtitle feature.  Subtitles appear below
  the main title in a lighter shade, providing additional context for
  the slide content.

  Subtitles are optional — they are only available through the explicit
  `#slide(title: ..., subtitle: ...)` form, since Markdown headings do
  not carry subtitle information.
]

== Lemma and Formal Results

#green-block[Lemma 1 (Preemptive Broadcast)][
  In the case where dishonest nodes can only lead by at most one
  block, dishonest nodes utilizing preemptive broadcasting can
  achieve returns no less than their original strategy.
]

The lemma above characterizes the advantage dishonest participants
can gain by deviating from the honest protocol.  Even under
conservative assumptions about the adversary's capabilities,
preemptive broadcasting is never worse than following the
prescribed strategy.

== Block Variants

#green-block[Definition][
  A standard green callout for definitions and theorems.
]

#alert-block(title: [Caution])[
  A high-emphasis callout for warnings and key constraints.
]

#example-block(title: [Example])[
  A low-emphasis callout for worked examples and asides.
]


== Visual Illustrations

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.2em,
  [
    #rect(
      width: 100%,
      height: 8em,
      fill: bit-green-light,
      radius: 0.35em,
      stroke: (paint: bit-green, thickness: 1.2pt),
      align(center + horizon, text(size: 2.4em, fill: bit-green, weight: "bold")[A]),
    )
    #v(0.3em)
    #text(size: 10pt, fill: text-dark.lighten(40%))[Figure 1: System architecture]
  ],
  [
    #rect(
      width: 100%,
      height: 8em,
      fill: bit-green-pale,
      radius: 0.35em,
      stroke: (paint: bit-green, thickness: 1.2pt),
      align(center + horizon, text(size: 2.4em, fill: bit-green-dark, weight: "bold")[B]),
    )
    #v(0.3em)
    #text(size: 10pt, fill: text-dark.lighten(40%))[Figure 2: Attack scenario comparison]
  ],
)

== References

#set text(size: 13pt)

- Nakamoto, S. (2008). _Bitcoin: A Peer-to-Peer Electronic Cash System._
- Buterin, V. (2014). _Ethereum: A Next-Generation Smart Contract Platform._
- Lamport, L., Shostak, R., & Pease, M. (1982). The Byzantine Generals
  Problem. _ACM Transactions on Programming Languages and Systems._
- Castro, M., & Liskov, B. (1999). Practical Byzantine Fault Tolerance.
  _Proceedings of OSDI '99._
- Garay, J., Kiayias, A., & Leonardos, N. (2015). The Bitcoin Backbone
  Protocol. _Proceedings of EUROCRYPT 2015._

== Footnote Test

Text with a default Typst footnote#footnote[Footnote text appears above the
theme footer.] on a normal content slide.

More body text to verify that the footnote separator and footnote text
are positioned correctly above the page footer bar.#footnote[A second
footnote for multi-footnote spacing verification.]

== Block Footnote Test

#green-block[Note][
  Content with a footnote#footnote[Footnote text inside a green block.]
  inside the green-block environment.
]

// ---- Section 2 ----

= 总结

== Thanks

谢谢!

Questions and discussion are welcome.

// A full-bleed emphasis slide for the closing takeaway.
#focus-slide[Preemptive broadcasting is never worse.]

