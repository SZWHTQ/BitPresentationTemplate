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

// Bundled asset accessors.
//
// These are functions, not bare `image(...)` bindings, on purpose:
// a module-level `image("...")` is evaluated eagerly at import time and
// would fail to load if the file were ever missing, breaking `import *`
// for everyone.  Wrapping each asset in a function makes loading lazy —
// the file is only read when the accessor is actually called.
//
// The paths resolve relative to THIS file, so they stay correct whether
// the theme is vendored or consumed as a published package, regardless
// of the user's working directory.
//
//   #import "@preview/bit-presentation-template:0.1.0": bit-logo, bit-emblem
//   config-info(logo: bit-logo())
#let bit-logo() = image("assets/bit_logo.pdf")
#let bit-emblem() = image("assets/header.svg")

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
//
// Pipeline note: the header bar and footer are merged into the page
// configuration via `config-page(header: ..., footer: ...)`, following
// the structure of Touying's built-in themes (e.g. `university`).  They
// must NOT be emitted as content inside the slide body, and the body
// must NOT contain a `set page(...)` rule — either would force a page
// break and split the frame title from the frame body.
#let slide(
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  title: auto,
  subtitle: none,
  ..bodies,
) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }
  self.store.subtitle = subtitle
  let header(self) = {
    set std.align(top)
    grid(
      rows: (auto, auto),
      row-gutter: 0pt,
      render-header(self),
      if self.store.progress-bar {
        components.progress-bar(
          height: progress-bar-height,
          self.colors.secondary,
          self.colors.tertiary,
        )
      },
    )
  }
  let footer(self) = {
    set std.align(bottom)
    footer-content(self)
  }
  let self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )
  let new-setting = body => {
    set text(size: body-font-size, fill: text-dark)
    set par(leading: body-leading)
    show: setting
    body
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
// the page top.  Uses a zero-margin page with an absolutely placed
// footer overlay, since all elements are positioned absolutely.
//
// Counted as slide 1 by default.  To exclude it from numbering:
//   #title-slide(config: config-common(freeze-slide-counter: true))
#let title-slide(config: (:), ..args) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt, header: none, footer: none),
    config,
  )
  let info = self.info + args.named()

  let body = {
    render-footer(self)

    // Green rounded title box
    place(top + center, dy: title-slide-title-y, rect(
      width: title-slide-title-box-width,
      fill: title-slide-title-box-fill,
      radius: title-slide-title-box-radius,
      inset: title-slide-title-box-inset,
      align(center, text(fill: text-light, size: title-slide-title-size, weight: "bold", info.title)),
    ))

    // Author / institution / date
    place(top + center, dy: title-slide-info-y, align(center)[
      #grid(
        columns: (auto,),
        row-gutter: title-slide-author-institute-gap,
        align: center,
        
        text(size: title-slide-author-size, fill: text-dark, info.author),
        
        if "title-institute-logo" in self.store and self.store.title-institute-logo != none {
          box(height: title-institute-logo-height, self.store.title-institute-logo)
        } else if info.institution != none {
          text(size: title-slide-institute-size, fill: text-dark, info.institution)
        },
        
        if info.date != none and info.date != auto {
          text(size: title-slide-date-size, fill: text-dark.lighten(35%), utils.display-info-date(self))
        },
      )
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
// page top.  Uses a zero-margin page with an absolutely placed footer
// overlay.  No normal header bar is shown on section divider slides.
#let new-section-slide(
  config: (:),
  level: 1,
  numbered: true,
  body,
) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(margin: 0pt, header: none, footer: none),
  )
  let slide-body = {
    render-footer(self)
    place(top + center, dy: section-slide-title-y, align(center)[
      #set text(size: section-slide-title-size, fill: section-slide-title-fill, weight: "bold")
      #utils.display-current-heading(level: level, numbered: numbered)
      #v(section-slide-rule-gap)
      #block(height: section-slide-rule-height, width: section-slide-rule-width, fill: section-slide-rule-fill)
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
    config-page(margin: 0pt, header: none, footer: none),
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

// Focus slide — a full-bleed green slide for a single emphasized
// takeaway (Beamer's "standout" frame).  The content is rendered large,
// centered, and in the light-on-green palette.  No header bar; the
// footer overlay is kept for continuity.
//
// Usage:
//   #focus-slide[The key result is X.]
//   #focus-slide(size: 48pt)[Big idea]
#let focus-slide(config: (:), size: 40pt, body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-page(
      fill: bit-green,
      margin: 0pt,
      header: none,
      footer: none,
    ),
    config,
  )
  let slide-body = {
    render-footer(self)
    pad(
      bottom: content-bottom-inset,
      {
        set std.align(center + horizon)
        set text(fill: text-light, size: size, weight: "bold")
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
// Implemented as a single normal slide so the title bar and the outline
// content always stay on the same page.  Uses Typst's built-in `outline`
// to list `= Section` headings.
//
// The header title defaults to the localized "toc" label (目录 / Contents,
// per the theme `lang`).  Pass an explicit `title:` to override it for a
// single slide.
#let toc-slide(title: toc-title, depth: toc-depth) = {
  let resolved-title = if title == auto {
    self => self.store.labels.toc
  } else {
    title
  }
  slide(title: resolved-title)[
    #set text(size: toc-body-font-size)
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
//       logo: bit-logo(),
//     ),
//     // Optional: separate header emblem
//     // config-store(
//     //   header-logo: bit-emblem(),
//     // ),
//   )
//
// The date defaults to the current build date (datetime.today()).
// Override it by passing `date:` in your `config-info(...)` call.
//
// Layout model: normal slides use real page margins — the green header
// bar lives in the top margin and the three-segment footer lives in
// the bottom margin, both configured through Touying's `config-page`.
// Body content (including footnotes) flows in the content area between
// them, so default Typst footnotes appear above the footer bar.
#let bit-theme(
  aspect-ratio: "16-9",
  progress-bar: false,
  institution: [北京理工大学],
  logo: bit-logo(),
  header-logo: auto,
  title-institute-logo: bit-emblem(),
  lang: "zh",
  labels: (:),
  ..args,
  body,
) = {
  // Localized UI labels.  Built-in tables cover zh/en; `labels` lets the
  // user override any individual key (e.g. labels: (toc: [Agenda])).
  let default-labels = (
    zh: (toc: [目录]),
    en: (toc: [Contents]),
  )
  let base = default-labels.at(lang, default: default-labels.en)
  let resolved-labels = base + labels

  show: touying-slides.with(
    config-page(
      ..utils.page-args-from-aspect-ratio(aspect-ratio),
      header-ascent: 0em,
      footer-descent: 0em,
      margin: (
        top: content-top-inset,
        bottom: footer-height + content-bottom-inset,
        x: content-x-margin,
      ),
    ),
    config-common(
      slide-fn: slide,
      new-section-slide-fn: new-section-slide,
    ),
    config-methods(
      init: (self: none, body) => {
        set text(size: body-font-size, fill: text-dark)
        set par(leading: body-leading)
        // Default footnote styling — compact size with consistent
        // spacing above the bottom margin (and thus the footer bar).
        set footnote.entry(
          clearance: footnote-clearance,
          gap: footnote-gap,
          indent: footnote-indent,
        )
        show footnote.entry: set text(size: footnote-font-size)
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
      title: auto,
      subtitle: none,
      progress-bar: progress-bar,
      header-logo: header-logo,
      title-institute-logo: title-institute-logo,
      lang: lang,
      labels: resolved-labels,
    ),
    // Theme defaults for info fields.  Each is overridden by the
    // user-supplied config-info(...) in `..args` if present, since later
    // args win the merge.
    //   date        — current build date.
    //   logo        — title-slide main logo.
    //   institution — footer + title-slide institution text.
    config-info(
      date: datetime.today(),
      logo: logo,
      institution: institution,
    ),
    ..args,
  )
  body
}
