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

- `= Section` — triggers a section divider slide (green title, centered).
- `== Frame Title` — creates a normal content slide.  The heading text
  becomes the slide title in the top header bar.

### Advanced: explicit `#slide()`

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
headings using Typst's built-in `outline`.

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
| `themes/components.typ` | Reusable components — `render-header`, `render-footer`, `green-block` |
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
| `footer-height` | `1.05em` | Footer bar height (fixed) |
| `content-x-margin` | `1.7em` | Horizontal padding for body content |
| `content-top-inset` | `3.25em` | Body top inset — must be > `header-height` |
| `content-bottom-inset` | `1.55em` | Body bottom inset — must be > `footer-height` |
| `header-title-size` | `22pt` | Slide title text in header |
| `header-subtitle-size` | `16pt` | Subtitle text in header |
| `body-font-size` | `20pt` | Default body text |
| `body-leading` | `1.25em` | Body text line spacing |
| `footer-font-size` | `14pt` | Footer text |
| `title-slide-title-y` | `7em` | Title box distance from page top |
| `title-slide-info-y` | `13em` | Author / institution / date distance from page top |
| `title-slide-logo-y` | `19em` | Logo distance from page top |
| `section-slide-title-y` | `13em` | Section title distance from page top |
| `section-slide-title-size` | `28pt` | Section divider title font size |
| `footer-left-fill` | `rgb("#004020")` | Left footer segment fill (darkest) |
| `footer-center-fill` | `rgb("#005a2c")` | Center footer segment fill (medium) |
| `footer-right-fill` | `rgb("#006633")` | Right footer segment fill (lightest) |
| `footer-columns` | `(34%, 1fr, 32%)` | Footer column widths |
| `header-logo-height` | `2.1em` | Normal slide header bar logo |
| `title-logo-height` | `3.2em` | Title slide main logo (e.g. bit_logo.pdf) |
| `title-institute-logo-height` | `2.4em` | Title slide institution mark (e.g. header.svg) |

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

The theme uses a zero-margin page with two absolutely-placed decorative
bars and a padded content area:

- **Header**: `place(top + left, dx: 0pt, dy: 0pt)` — full-bleed green
  bar at the physical top edge.  Title and logo are vertically centered.
  Height: `header-height` (2.35em).
- **Footer**: `place(bottom + left, dx: 0pt, dy: 0pt)` — full-bleed
  dark green bar at the physical bottom edge.  Content is vertically
  centered.  Height: `footer-height` (1.05em).
- **Body**: Flows normally inside `pad(top: content-top-inset,
  bottom: content-bottom-inset, x: content-x-margin)` so it never
  overlaps the header or footer.

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
- **Absolute header/footer placement:** Overly long body content on a
  single slide may still overlap the footer.  Split long content across
  multiple slides.
- **Subtitle only via explicit `#slide()`:** Markdown headings do not
  carry subtitle information.  Use `#slide(title: ..., subtitle: ...)`
  when you need a subtitle.
- **`== Heading` size limit:** Very long heading text may overflow the
  header bar.  Keep slide titles concise.
- **`toc-slide` depends on `outline`:** The table of contents reads
  from `= Section` headings.  If `outline()` returns empty (e.g. all
  sections follow the TOC slide), Typst may need a second compilation
  pass to resolve references.
