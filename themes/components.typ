// themes/components.typ
// Reusable slide components for the Bit theme.

#import "@preview/touying:0.7.4": *
#import "tokens.typ": *

// Top header bar rendered on normal content slides.
//
// Placed full-bleed at the physical top edge (x=0, y=0).  Title text
// and the optional logo are vertically centered within the header bar.
//
// The logo is resolved as follows:
//   1. `self.store.header-logo` — if set via `config-store`.
//   2. `self.info.logo`        — the default logo from `config-info`.
//   3. `none`                  — no logo displayed.
//
// Only rendered when `title` is not `none`.
#let render-header(self, title: none, subtitle: none) = {
  if title == none { return }

  let header-logo = if "header-logo" in self.store and self.store.header-logo != none {
    self.store.header-logo
  } else if self.info.logo != none {
    self.info.logo
  } else {
    none
  }

  place(
    top + left,
    dx: 0pt,
    dy: 0pt,
    rect(
      width: 100%,
      height: header-height,
      fill: bit-green,
      inset: 0pt,
      box(
        width: 100%,
        height: header-height,
        inset: (left: 1.1em, right: 1.0em),
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          box(
            height: header-height,
            align(left + horizon)[
              #text(fill: text-light, size: header-title-size, weight: "bold")[#title]
              #if subtitle != none [
                #h(0.6em)
                #text(fill: text-light.lighten(25%), size: header-subtitle-size)[#subtitle]
              ]
            ],
          ),
          box(
            height: header-height,
            align(right + horizon)[
              #if header-logo != none {
                box(height: header-logo-height, header-logo)
              }
            ],
          ),
        ),
      ),
    ),
  )
}

// Bottom footer bar rendered on every slide.
//
// Placed full-bleed at the physical bottom edge.  The footer is split
// into three contiguous colored segments (Beamer-style footline):
//   left   — author / institution    (darkest green)
//   center — presentation title      (medium green)
//   right  — date / slide counter    (lightest green)
//
// Each segment is a separate rect so the color boundaries are visible.
// Text is vertically centered within each segment.
#let render-footer(self) = {
  place(
    bottom + left,
    dx: 0pt,
    dy: 0pt,
    grid(
      columns: footer-columns,
      rows: (footer-height,),
      column-gutter: 0pt,
      row-gutter: 0pt,
      // Left segment — author / institution
      rect(
        width: 100%,
        height: footer-height,
        fill: footer-left-fill,
        inset: 0pt,
        align(center + horizon,
          pad(x: 0.8em,
            text(fill: text-light, size: footer-font-size)[
              #self.info.author
              #if self.info.institution != none [
                #sym.space (#self.info.institution)
              ]
            ],
          ),
        ),
      ),
      // Center segment — presentation title
      rect(
        width: 100%,
        height: footer-height,
        fill: footer-center-fill,
        inset: 0pt,
        align(center + horizon,
          text(fill: text-light, size: footer-font-size)[
            #self.info.title
          ],
        ),
      ),
      // Right segment — date / slide counter in a two-column grid
      rect(
        width: 100%,
        height: footer-height,
        fill: footer-right-fill,
        inset: 0pt,
        align(right + horizon,
          pad(right: footer-right-inset,
            grid(
              columns: (auto, auto),
              column-gutter: footer-date-page-gap,
              align: (center + horizon, right + horizon),
              text(fill: text-light, size: footer-font-size)[
                #utils.display-info-date(self)
              ],
              text(fill: text-light, size: footer-font-size)[
                #context [
                  #utils.slide-counter.display() / #utils.last-slide-number
                ]
              ],
            ),
          ),
        ),
      ),
    ),
  )
}

// Green block component for theorem / lemma / quote content.
//
// Usage:
//   #green-block[Lemma 1][
//     Content of the lemma ...
//   ]
// #let green-block(title, body) = {
//   block(
//     width: 100%,
//     above: 1em,
//     below: 1em,
//     radius: 0.3em,
//     stroke: (paint: bit-green, thickness: 0.5pt),
//     fill: bit-green,
//     {
//       rect(
//         width: 100%,
//         fill: bit-green-dark,
//         radius: (top-left: 0.3em, top-right: 0.3em),
//         inset: (right: 0.7em, left: 0.7em, top: 0.3em, bottom: 0.3em),
//         text(fill: text-light, weight: "bold")[#title],
//       )
//       rect(
//         width: 100%,
//         fill: bit-green-pale,
//         radius: (bottom-left: 0.3em, bottom-right: 0.3em),
//         inset: (right: 0.8em, left: 0.8em, top: 0em, bottom: 0.7em),
//         body,
//       )
//     },
//   )
// }

#let green-block(title, body) = {
  block(
    width: 100%,
    above: 1em,
    below: 1em,
    radius: 0.3em,
    stroke: (paint: bit-green, thickness: 0.5pt),
    fill: none,
    {
      grid(
        columns: (1fr,),
        row-gutter: 0pt,
        
        rect(
          width: 100%,
          height: 1.35em,
          fill: bit-green-dark,
          radius: (top-left: 0.3em, top-right: 0.3em),
          inset: (x: 0.7em, y: 0pt),
          align(left + horizon)[
            #text(fill: text-light, weight: "bold")[#title]
          ],
        ),
        
        rect(
          width: 100%,
          fill: bit-green-pale,
          radius: (bottom-left: 0.3em, bottom-right: 0.3em),
          inset: (
            left: 0.8em,
            right: 0.8em,
            top: 0.7em,
            bottom: 0.7em,
          ),
          body,
        ),
      )
    },
  )
}