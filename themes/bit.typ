// themes/bit.typ
// Bit theme for Touying — a green university-style Beamer theme.
//
// Recommended (heading-based) authoring:
//   = Section
//   == Frame Title
//   Frame content.
//
// Manual (explicit) authoring is also supported:
//   #slide(title: [Frame Title])[Frame content.]

#import "@preview/touying:0.7.4": *
#import "tokens.typ": *
#import "components.typ": *

// Normal content slide.
//
// When triggered by a level-2 heading (`== Frame Title`), the title is
// resolved automatically from the heading.  You can override it with an
// explicit `title:` argument.
//
// Pass `title: none` to suppress the header bar entirely.
//
// All standard touying arguments (config, repeat, setting, composer) are
// forwarded transparently.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  title: auto,
  subtitle: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  // Resolve title: explicit argument > heading > (none / empty bar)
  let resolved-title = if title != auto {
    title
  } else {
    utils.display-current-heading(level: 2)
  }

  let new-setting = body => {
    show: setting
    // Decorative header and footer — absolutely placed at page edges.
    render-header(self, title: resolved-title, subtitle: subtitle)
    render-footer(self)
    // Body flows inside a padded area that clears the header and footer.
    set text(size: body-font-size, fill: text-dark)
    set par(leading: body-leading)
    pad(
      left: content-x-margin,
      right: content-x-margin,
      top: content-top-inset,
      bottom: content-bottom-inset,
      body,
    )
  }
  touying-slide(
    self: self,
    config: config,
    repeat: repeat,
    setting: new-setting,
    composer: composer,
    ..bodies,
  )
})

// Title slide.
//
// Renders a deep-green rounded title box with author, institution,
// date, and logo — each positioned at a fixed vertical offset from
// the page top.  Footer remains at the physical bottom.
//
// Counted as slide 1 by default.  To exclude it from numbering:
//   #title-slide(config: config-common(freeze-slide-counter: true))
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(self, config)
  let info = self.info + args.named()

  let body = {
    render-footer(self)

    // Green rounded title box
    place(top + center, dy: title-slide-title-y, rect(
      width: 78%,
      fill: bit-green,
      radius: 0.45em,
      inset: (x: 1.5em, y: 0.8em),
      align(center, text(fill: text-light, size: header-title-size, weight: "bold", info.title)),
    ))

    // Author / institution / date
    place(top + center, dy: title-slide-info-y, align(center)[
      #text(size: 1.05em, fill: text-dark, info.author)
      // Institution: prefer an image logo (via config-store) over plain text.
      #if "title-institute-logo" in self.store and self.store.title-institute-logo != none {
        v(0.4em)
        box(height: title-institute-logo-height, self.store.title-institute-logo)
      } else if info.institution != none {
        v(0.4em)
        text(size: 0.85em, fill: text-dark, info.institution)
      }
      #if info.date != none and info.date != auto {
        v(0.4em)
        text(size: 0.8em, fill: text-dark.lighten(35%), utils.display-info-date(self))
      }
    ])

    // Logo
    if info.logo != none {
      place(top + center, dy: title-slide-logo-y, box(height: title-logo-height, info.logo))
    }
  }
  touying-slide(self: self, body)
})

// Section divider slide.
//
// Triggered automatically when a level-1 heading (`= Section`) is
// encountered.  Displays the section title centered in green with a
// decorative rule, positioned at a fixed vertical offset from the
// page top.  Footer remains at the physical bottom.
//
// No normal header bar is shown on section divider slides.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  let slide-body = {
    render-footer(self)
    place(top + center, dy: section-slide-title-y, align(center)[
      #set text(size: section-slide-title-size, fill: bit-green, weight: "bold")
      #utils.display-current-heading(level: level, numbered: numbered)
      #v(0.5em)
      #block(height: 2.5pt, width: 40%, fill: bit-green)
      #body
    ])
  }
  touying-slide(self: self, config: config, slide-body)
})

// Ending slide — convenience wrapper.
//
// Usage:
//   #ending-slide[谢谢!]
//
// Centered content with the slide counter frozen (not counted).
#let ending-slide(config: (:), body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config,
  )
  let slide-body = {
    render-footer(self)
    pad(
      bottom: content-bottom-inset,
      {
        set std.align(center + horizon)
        body
      },
    )
  }
  touying-slide(self: self, slide-body)
})

// Table-of-contents slide.
//
// Usage:
//   #toc-slide()
//
// Uses Typst's built-in `outline` to generate an automatic table of
// contents from `= Section` headings.  The default title is "目录".
// Pass an explicit `title:` to override.
#let toc-slide(title: [目录], depth: 1) = {
  slide(title: title)[
    #set text(size: body-font-size)
    #outline(title: none, depth: depth)
  ]
}

// Bit theme entry point.
//
// Usage:
//   #show: bit-theme.with(
//     aspect-ratio: "16-9",
//     config-info(
//       title: [...],
//       author: [...],
//       institution: [...],
//       logo: image("themes/assets/bit_logo.pdf", height: header-logo-height),
//     ),
//     // Optional: separate header emblem
//     // config-store(
//     //   header-logo: image("themes/assets/header.svg", height: header-logo-height),
//     // ),
//   )
//
// The date defaults to the current build date (datetime.today()).
// Override it by passing `date:` in your `config-info(...)` call.
#let bit-theme(
  aspect-ratio: "16-9",
  progress-bar: false,
  institution: [北京理工大学],
  logo: image("assets/bit_logo.pdf", height: title-logo-height),
  header-logo: image("assets/bit_logo.pdf", height: header-logo-height),
  title-institute-logo: image("assets/header.svg", height: title-institute-logo-height),
  ..args,
  body,
) = {
  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      // Zero margin — header and footer are placed absolutely at the
      // physical page edges.  Body content is padded individually in
      // each slide function via content-top-inset / content-bottom-inset.
      margin: 0pt,
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: body-font-size, fill: text-dark)
        set par(leading: body-leading)
        body
      },
      alert: utils.alert-with-primary-color,
    ),
    config-colors(
      primary: bit-green,
      secondary: bit-green-dark,
      tertiary: bit-green-light,
      neutral-lightest: text-light,
      neutral-darkest: text-dark,
    ),
    config-store(
      progress-bar: progress-bar,
      header-logo: header-logo,
      title-institute-logo: title-institute-logo,
    ),
    // Default date: current build date.  Overridden by user-supplied
    // config-info(date: ...) if present (later args win in merge).
    config-info(
      date: datetime.today(),
    ),
    ..args,
  )
  body
}
