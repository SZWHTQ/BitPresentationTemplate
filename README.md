# bit-presentation-template

A green university-style Beamer theme for [Touying](https://github.com/touying-typ/touying) 0.7.4.

## Install locally

The theme is a Typst package.  Install it into your local package
namespace once, then import it from any document with no `--root` flag:

```bash
make install      # copies the package to the @local Typst namespace
```

To remove it again: `make uninstall`.

## Quick start

```typst
#import "@local/bit-presentation-template:0.1.0": *

#show: bit-theme.with(
  aspect-ratio: "16-9",
  progress-bar: false,
  config-info(
    title: [My Presentation],
    author: [Author Name],
    institution: [Institution],
    date: datetime(year: 2026, month: 6, day: 9),
    // logo defaults to the bundled bit_logo.pdf; pass `logo: none` to drop it.
  ),
)

#title-slide()
#toc-slide()

= Section

== Frame Title

Frame content.
```

## Two authoring modes

### Recommended: heading-based

Use Typst headings to create slides.  Touying automatically maps `=`
to section dividers and `==` to normal content frames.

```typst
= Section Name

== Slide Title

Slide body content goes here.

== Another Slide

More content.
```

- `= Section` — starts a new section and triggers a section divider
  slide (green title, centered, one page).
- `== Frame Title` — creates one normal content slide containing both
  the title (in the top header bar) and the following body content.
  The title and body are never split across pages.

### Advanced: explicit `#slide()`

The explicit form is an escape hatch for slides that need a subtitle,
a manual title override, or no header bar at all.  Prefer headings for
ordinary content slides.

For slides that need a subtitle or special layout, use the explicit form:

```typst
#slide(title: [Frame Title], subtitle: [Optional subtitle])[
  Frame content.
]
```

Pass `title: none` to suppress the header bar:

```typst
#slide(title: none)[
  #align(horizon)[Thanks!]
]
```

All standard Touying `slide` arguments (`config`, `repeat`, `setting`,
`composer`) are forwarded transparently.

## API reference

### `bit-theme`

The main theme function.  Use with `#show: bit-theme.with(...)`.

| Parameter | Default | Description |
|---|---|---|
| `aspect-ratio` | `"16-9"` | Slide aspect ratio |
| `progress-bar` | `false` | Show a thin progress bar below the header |
| `institution` | `北京理工大学` | Default institution (overridden by `config-info`) |
| `logo` | `bit_logo.pdf` | Default title-slide logo (overridden by `config-info`) |
| `lang` | `"zh"` | UI label language (`"zh"` or `"en"`) — see [Localization](#localization) |
| `labels` | `(:)` | Per-key label overrides, e.g. `(toc: [Agenda])` |
| `..args` | — | Forwarded to `touying-slides.with()` |

### `title-slide`

Renders a centered deep-green rounded title box with author,
institution, date, and logo.  Counted as slide 1 by default.

To exclude it from numbering:

```typst
#title-slide(config: config-common(freeze-slide-counter: true))
```

### `toc-slide`

Generates an automatic table-of-contents slide from `= Section`
headings using Typst's built-in `outline`.  Title bar and outline
content render together on a single page.

```typst
#toc-slide()           // localized title (目录 / Contents per `lang`)
#toc-slide(title: [Outline], depth: 2)
```

### `ending-slide`

Convenience wrapper for the final "thanks" slide.  Content is centered
and the slide counter is frozen (not counted).

```typst
#ending-slide[谢谢!]
```

### `focus-slide`

A full-bleed green emphasis slide (Beamer's "standout" frame) for a
single key takeaway.  Content is large, centered, and light-on-green.

```typst
#focus-slide[The key result is X.]
#focus-slide(size: 48pt)[Bigger text]
```

### Block components

A flexible callout block with three ready-made variants plus a
configurable core.

```typst
#green-block[Lemma 1][ Content ... ]   // titled (positional, back-compat)
#green-block[ Content ... ]            // no title bar

#alert-block(title: [Caution])[ ... ]     // high emphasis
#example-block(title: [Example])[ ... ]   // low emphasis

// Fully configurable core:
#block-env(title: [Custom], bar-fill: red, body-fill: red.lighten(80%))[ ... ]
```

`block-env` parameters: `title` (default `none`), `bar-fill`,
`body-fill`, `border`.

### Optional header logo

By default the header shows `self.info.logo`.  To use a different
image in the header (e.g. `header.svg` as a wordmark), pass
`header-logo` via `config-store`:

```typst
#show: bit-theme.with(
  config-info(
    // logo defaults to the bundled bit_logo.pdf.
  ),
  config-store(
    header-logo: bit-emblem(),   // use header.svg as the header wordmark
  ),
)
```

The title slide always uses `self.info.logo`.

The bundled assets are exposed as the lazy accessors `bit-logo()`
(bit_logo.pdf) and `bit-emblem()` (header.svg).  They are functions, so
importing the theme never force-loads the files — call them only where
you want the image.

## Files

| File | Purpose |
|---|---|
| `lib.typ` | Package entry point — re-exports the full API |
| `typst.toml` | Package manifest |
| `themes/bit.typ` | Theme implementation — `bit-theme`, `slide`, `title-slide`, `toc-slide`, `ending-slide`, `focus-slide`, asset accessors |
| `themes/tokens.typ` | Design tokens — colors, sizes, spacing |
| `themes/components.typ` | Reusable components — `render-header`, `footer-content`, `render-footer`, `block-env`, `green-block`, `alert-block`, `example-block` |
| `themes/assets/bit_logo.pdf` | Default logo (title slide and headers) |
| `themes/assets/header.svg` | Optional header emblem |
| `examples/replica.typ` | Full demo presentation |
| `main.typ` | Minimal smoke-test entry point |

## Compile

Install the package first (`make install`), then compile with no
`--root` flag:

```bash
typst compile examples/replica.typ
typst compile main.typ

# Or use the Makefile:
make compile-example  # installs first, then compiles
make compile-main     # installs first, then compiles
make watch-example    # installs first, then watches
make all          # both decks
make clean        # remove generated PDFs
```

## Design tokens

See `themes/tokens.typ` for all tunable values:

| Token | Default | Usage |
|---|---|---|
| `bit-green` | `rgb("#006633")` | Primary brand color |
| `bit-green-dark` | `rgb("#004020")` | Footer bar, block title bar |
| `bit-green-light` | `rgb("#dfeee6")` | Accent backgrounds |
| `bit-green-pale` | `rgb("#edf6f1")` | Block body background |
| `header-height` | `2.35em` | Header bar height (fixed) |
| `footer-height` | `0.85em` | Footer bar height (fixed) |
| `content-x-margin` | `1.7em` | Horizontal page margin for body content |
| `content-top-inset` | `3.25em` | Top page margin — must be > `header-height` |
| `content-bottom-inset` | `1.0em` | Extra bottom margin above the footer bar |
| `progress-bar-height` | `3pt` | Progress bar thickness (below the header) |
| `header-title-size` | `22pt` | Slide title text in header |
| `header-subtitle-size` | `16pt` | Subtitle text in header |
| `body-font-size` | `20pt` | Default body text |
| `body-leading` | `1.25em` | Body text line spacing |
| `footer-font-size` | `12pt` | Footer text |
| `footnote-font-size` | `8pt` | Footnote entry text size |
| `footnote-clearance` | `0.35em` | Space between body text and footnote separator |
| `footnote-gap` | `0.2em` | Gap between consecutive footnotes |
| `footnote-indent` | `1em` | Indentation of footnote body from marker |
| `title-slide-title-y` | `4em` | Title box distance from page top |
| `title-slide-info-y` | `8em` | Author / institution / date distance from page top |
| `title-slide-logo-y` | `16em` | Logo distance from page top |
| `section-slide-title-y` | `9em` | Section title distance from page top |
| `section-slide-title-size` | `36pt` | Section divider title font size |
| `footer-left-fill` | `rgb("#004020")` | Left footer segment fill (darkest) |
| `footer-center-fill` | `rgb("#005a2c")` | Center footer segment fill (medium) |
| `footer-right-fill` | `rgb("#006633")` | Right footer segment fill (lightest) |
| `footer-columns` | `(34%, 1fr, 32%)` | Footer column widths |
| `header-logo-height` | `2.0em` | Normal slide header bar logo |
| `title-logo-height` | `4em` | Title slide main logo (e.g. bit_logo.pdf) |
| `title-institute-logo-height` | `1.6em` | Title slide institution mark (e.g. header.svg) |

## Logo configuration

Three independent logo slots are available:

| Slot | Token | Config key | Typical asset |
|---|---|---|---|
| Header bar logo | `header-logo-height` | `config-store(header-logo: ...)` | `header.svg` |
| Title slide main logo | `title-logo-height` | `config-info(logo: ...)` | `bit_logo.pdf` |
| Title slide institution mark | `title-institute-logo-height` | `config-store(title-institute-logo: ...)` | `header.svg` |

Recommended setup:

```typst
config-info(
  logo: image("themes/assets/bit_logo.pdf", height: title-logo-height),
)

config-store(
  header-logo: image("themes/assets/header.svg", height: header-logo-height),
  title-institute-logo: image("themes/assets/header.svg", height: title-institute-logo-height),
)
```

By default `title-institute-logo` is set to `header.svg`, so the title
slide shows that emblem.  Pass `title-institute-logo: none` via
`config-store` to fall back to plain institution text from
`config-info(institution: ...)`.

## Layout model

Normal content slides follow the structure of Touying's built-in themes
(e.g. `university`): the header and footer are merged into the page
configuration through `config-page(header: ..., footer: ...)` inside the
slide function, and the slide body is passed to `touying-slide`
unchanged.  No `set page(...)` rules or absolute header/footer overlays
are emitted inside the slide body — that would force a page break and
split the frame title from the frame body.

- **Page margins (normal slides)**: `top: content-top-inset`,
  `bottom: footer-height + content-bottom-inset`, `x: content-x-margin`.
- **Header**: lives in the top margin.  Touying's zero-margin-header
  mechanism stretches it to the full page width, so the green bar is
  full-bleed.  Title and logo are vertically centered within
  `header-height`.
- **Footer**: lives in the bottom margin via the Touying page footer
  (`config-page(footer: ...)`), aligned to the physical bottom edge and
  stretched full-bleed the same way.
- **Body**: flows in the content area between the margins.  Default
  Typst `#footnote[...]` entries belong to the body flow and render at
  the bottom of the content area, above the footer bar.
- **Special slides** (title, section divider, ending): use a zero-margin
  page (`config-page(margin: 0pt, header: none, footer: none)`) with
  absolutely positioned content and the `render-footer(self)` overlay.

## Footnote support

Default Typst `#footnote[...]` footnotes are supported on normal content
slides: they render at the bottom of the content area, above the footer
bar, with the following styling (configurable in `themes/tokens.typ`):

| Token | Default | Usage |
|---|---|---|
| `footnote-font-size` | `8pt` | Footnote entry text size |
| `footnote-clearance` | `0.35em` | Space between body text and footnote separator |
| `footnote-gap` | `0.2em` | Gap between consecutive footnotes |
| `footnote-indent` | `1em` | Indentation of footnote body from marker |

Footnote support is currently limited by the footer being a page-margin
footer: footnotes sit directly above the bottom margin (i.e. above the
footer bar plus `content-bottom-inset`), not flush against the footer
bar itself.  This is a cosmetic gap, accepted in favor of a correct
heading/frame pipeline.

The three-segment footer rendering is split into two functions:

- **`footer-content(self)`** — returns the pure three-segment footer
  content (three colored `rect` blocks in a `grid`).  Used as the
  Touying page footer on normal slides.  Does not call `place(...)`.
- **`render-footer(self)`** — wraps `footer-content(self)` in a
  `place(bottom + left, ...)` for special slides (title, section,
  ending) that use zero-margin absolute layouts.

## Date default

The theme defaults to `datetime.today()` (the current build date).
To set a fixed date, pass it explicitly:

```typst
config-info(
  date: datetime(year: 2026, month: 6, day: 9),
)
```

## Localization

UI labels (currently just the table-of-contents title) follow the
`lang` parameter.  Built-in tables cover `"zh"` (default, 目录) and
`"en"` (Contents).  Override individual labels with `labels`:

```typst
#show: bit-theme.with(
  lang: "en",                  // 目录 → Contents
  labels: (toc: [Agenda]),     // or override a single key
  config-info(...),
)
```

A per-slide override is still available: `#toc-slide(title: [Outline])`.

## Handling content overflow

A single slide does not auto-shrink to fit oversized content.  Options,
in order of preference:

1. **Split the content** across multiple `==` slides — the cleanest fix.
2. **Reduce text size locally** for one dense slide:
   `#slide(title: [...])[ #set text(size: 16pt); ... ]`.
3. **Scale a single large element** (a wide table or figure) to the
   content width:
   ```typst
   #scale(x: 80%, y: 80%, reflow: true)[ #big-table ]
   ```

## Known limitations

- **Footnote placement is approximate:** Footnotes render above the
  bottom margin, so there is a small gap (`content-bottom-inset`)
  between the footnote block and the footer bar.  Footnote placement
  has not been fully verified beyond "renders above the footer on
  normal slides" — do not rely on pixel-exact positioning.
- **No auto-fit for long content:** A single slide does not shrink to
  fit oversized body text — see [Handling content overflow](#handling-content-overflow).
- **Subtitle only via explicit `#slide()`:** Markdown headings do not
  carry subtitle information.  Use `#slide(title: ..., subtitle: ...)`
  when you need a subtitle.
- **`== Heading` size limit:** Very long heading text may overflow the
  header bar.  Keep slide titles concise.
- **`toc-slide` depends on `outline`:** The table of contents reads
  from `= Section` headings.  If `outline()` returns empty (e.g. all
  sections follow the TOC slide), Typst may need a second compilation
  pass to resolve references.
- **Special slides use overlay footer:** Title, section, and ending
  slides use the absolute `place(bottom + left, ...)` overlay for the
  footer.  Footnotes inside these special slides may overlap the
  footer.  Only normal content slides (via `== Heading` or `#slide()`)
  place footnotes above the footer.
