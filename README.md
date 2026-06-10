# bit-theme

A green university-style Beamer theme for [Touying](https://github.com/touying-typ/touying) 0.7.4.

## Quick start

```typst
#import "@preview/touying:0.7.4": *
#import "themes/bit.typ": *

#show: bit-theme.with(
  aspect-ratio: "16-9",
  progress-bar: false,
  config-info(
    title: [My Presentation],
    author: [Author Name],
    institution: [Institution],
    date: datetime(year: 2026, month: 6, day: 9),
    logo: image("themes/assets/bit_logo.pdf", height: 2.4em),
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
#toc-slide()           // default title "目录"
#toc-slide(title: [Outline], depth: 2)
```

### `ending-slide`

Convenience wrapper for the final "thanks" slide.  Content is centered
and the slide counter is frozen (not counted).

```typst
#ending-slide[谢谢!]
```

### `green-block`

A colored block for theorems, lemmas, and highlighted content.

```typst
#green-block[Lemma 1][
  Content of the lemma ...
]
```

### Optional header logo

By default the header shows `self.info.logo`.  To use a different
image in the header (e.g. `header.svg` as a wordmark), pass
`header-logo` via `config-store`:

```typst
#show: bit-theme.with(
  config-info(
    logo: image("themes/assets/bit_logo.pdf", height: 2.4em),
  ),
  config-store(
    header-logo: image("themes/assets/header.svg", height: 2.4em),
  ),
)
```

The title slide always uses `self.info.logo`.

## Files

| File | Purpose |
|---|---|
| `themes/bit.typ` | Theme entry point — exports `bit-theme`, `slide`, `title-slide`, `toc-slide`, `ending-slide` |
| `themes/tokens.typ` | Design tokens — colors, sizes, spacing |
| `themes/components.typ` | Reusable components — `render-header`, `footer-content`, `render-footer`, `green-block` |
| `themes/assets/bit_logo.pdf` | Default logo (title slide and headers) |
| `themes/assets/header.svg` | Optional header emblem (via `config-store`) |
| `examples/replica.typ` | Full demo presentation |
| `main.typ` | Minimal smoke-test entry point |

## Compile

```bash
# From the project root:
typst compile examples/replica.typ --root .
typst compile main.typ --root .

# Or use the Makefile:
make compile-example
make compile-main
make watch-example
```

The `--root .` flag is required so that `../themes/` imports work from
the `examples/` directory.

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

If `title-institute-logo` is not set, the title slide falls back to plain
institution text from `config-info(institution: ...)`.

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

## Known limitations

- **`--root .` required:** The `../themes/` import in `examples/` crosses
  outside the default project root.  Pass `--root .` when compiling.
- **Footnote placement is approximate:** Footnotes render above the
  bottom margin, so there is a small gap (`content-bottom-inset`)
  between the footnote block and the footer bar.  Footnote placement
  has not been fully verified beyond "renders above the footer on
  normal slides" — do not rely on pixel-exact positioning.
- **Overly long body content:** On a single slide, very long body text
  overflows the content area.  Split long content across multiple
  slides.
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
