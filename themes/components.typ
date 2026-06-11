// themes/components.typ
// Reusable slide components for the Bit theme.

#import "@preview/touying:0.7.4": *
#import "tokens.typ": *

// Top header bar for normal content slides.
//
// Returns the full-width green bar content for use as the page header
// (via Touying's `config-page(header: ...)`).  Touying's
// zero-margin-header mechanism stretches the page header to the full
// page width, so no absolute placement is needed here.  Title text and
// the optional logo are vertically centered within the header bar.
//
// The title is resolved from `self.store.title`:
//   auto      — current level-2 heading (heading-based authoring).
//   none      — no header bar is rendered.
//   otherwise — the given content, or a `self => content` function.
//
// The logo is resolved as follows:
//   1. `self.store.header-logo` — if explicitly set via `config-store`.
//   2. `self.info.logo`        — when `header-logo` is `auto` or unset.
//   3. `none`                  — no logo displayed.
#let render-header(self) = {
  let title = self.store.at("title", default: auto)
  if title == none { return }
  let resolved-title = if title == auto {
    utils.display-current-heading(level: 2)
  } else {
    utils.call-or-display(self, title)
  }
  let subtitle = self.store.at("subtitle", default: none)

  let stored-header-logo = self.store.at("header-logo", default: auto)
  let header-logo = if stored-header-logo == auto {
    self.info.logo
  } else if stored-header-logo != none {
    self.store.header-logo
  } else {
    none
  }

  rect(
    width: 100%,
    height: header-height,
    fill: header-fill,
    inset: 0pt,
    box(
      width: 100%,
      height: header-height,
      inset: (left: header-x-inset-left, right: header-x-inset-right),
      grid(
        columns: (1fr, auto),
        align: (left + horizon, right + horizon),
        box(
          height: header-height,
          align(left + horizon)[
            #text(fill: text-light, size: header-title-size, weight: "bold")[#resolved-title]
            #if subtitle != none [
              #h(header-title-subtitle-gap)
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
  )
}

// Footer content — three contiguous colored segments forming a Beamer-style
// footline.  Returns pure content without any absolute placement wrapper so
// it can be used as a page footer or placed manually.
//
//   left   — author / institution    (darkest green)
//   center — presentation title      (medium green)
//   right  — date / slide counter    (lightest green)
//
// Each segment is a separate rect so the color boundaries are visible.
// Text is vertically centered within each segment.
//
// On normal slides this is used as the Touying page footer (via
// `config-page(footer: ...)`); Touying's zero-margin-footer mechanism
// stretches it to the full page width.  For special slides (title,
// section, ending) that use zero-margin absolute layouts, wrap it with
// render-footer(self) instead.
#let footer-content(self) = {
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
        pad(x: footer-x-inset,
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
  )
}

// Absolute footer overlay — wraps footer-content(self) in a full-bleed
// bottom placement.  Used by special slides (title, section, ending)
// that run on a zero-margin page with absolutely positioned content,
// where there is no bottom margin for a page footer to live in.
#let render-footer(self) = {
  place(
    bottom + left,
    dx: 0pt,
    dy: 0pt,
    footer-content(self),
  )
}

// Colored callout block for theorems, lemmas, notes, and highlights.
//
// `block-env` is the general form: an optional title bar over a tinted
// body, both colors configurable.  The named-argument API is the
// canonical one:
//
//   #block-env(title: [Lemma 1])[ ... ]            // titled
//   #block-env[ ... ]                              // no title bar
//   #block-env(title: [Warning], bar-fill: red, border: red)[ ... ]
//
#let block-env(
  body,
  title: none,
  bar-fill: block-title-fill,
  body-fill: block-body-fill,
  border: block-border-fill,
) = {
  block(
    width: 100%,
    above: block-above,
    below: block-below,
    radius: block-radius,
    stroke: (paint: border, thickness: block-border-thickness),
    fill: none,
    {
      grid(
        columns: (1fr,),
        row-gutter: 0pt,

        if title != none {
          rect(
            width: 100%,
            height: block-title-height,
            fill: bar-fill,
            radius: (top-left: block-radius, top-right: block-radius),
            inset: (x: block-title-x-inset, y: 0pt),
            align(left + horizon)[
              #text(fill: block-title-text-fill, weight: block-title-text-weight)[#title]
            ],
          )
        },

        rect(
          width: 100%,
          fill: body-fill,
          radius: if title != none {
            (bottom-left: block-radius, bottom-right: block-radius)
          } else {
            block-radius
          },
          inset: block-body-inset,
          body,
        ),
      )
    },
  )
}

// green-block — the default green callout.
//
// Backward-compatible with both the original positional title form and
// a title-less form:
//
//   #green-block[Lemma 1][ Content ... ]   // title + body
//   #green-block[ Content ... ]            // body only, no title bar
//
#let green-block(..args) = {
  let pos = args.pos()
  if pos.len() >= 2 {
    block-env(pos.at(1), title: pos.at(0))
  } else if pos.len() == 1 {
    block-env(pos.at(0))
  } else {
    panic("green-block expects [title][body] or [body]")
  }
}

// alert-block — a high-emphasis callout in the darkest green.
//
//   #alert-block(title: [Caution])[ ... ]
#let alert-block(body, title: none) = block-env(
  body,
  title: title,
  bar-fill: alert-block-title-fill,
  body-fill: alert-block-body-fill,
  border: alert-block-border-fill,
)

// example-block — a low-emphasis callout in pale green.
//
//   #example-block(title: [Example])[ ... ]
#let example-block(body, title: none) = block-env(
  body,
  title: title,
  bar-fill: example-block-title-fill,
  body-fill: example-block-body-fill,
  border: example-block-border-fill,
)
