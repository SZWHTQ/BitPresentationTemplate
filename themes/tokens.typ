// themes/tokens.typ
// Design tokens for the Bit theme.

// 1. Palette
// Base colors and semantic fills used across normal slides, title slides,
// section slides, footer, header, blocks, and footnotes.
#let bit-green = rgb("#006633")
#let bit-green-dark = rgb("#004020")
#let bit-green-light = rgb("#dfeee6")
#let bit-green-pale = rgb("#edf6f1")

#let text-dark = rgb("#111111")
#let text-light = white

#let page-background-fill = white
#let header-fill = bit-green
#let footer-left-fill = rgb("#004020")
#let footer-center-fill = rgb("#005a2c")
#let footer-right-fill = rgb("#006633")
#let block-title-fill = bit-green-dark
#let block-body-fill = bit-green-pale
#let block-border-fill = bit-green

// 2. Global typography
// Defaults for normal slide body text. Region-specific sizes live with the
// region they control.
#let body-font-size = 20pt
#let body-leading = 1.25em

// 3. Page frame and content area
// Normal slides use Touying page margins for body content. The header and
// footer live in the page header/footer areas, so the top and bottom insets
// reserve space for those bars outside the normal content flow.
#let content-x-margin = 1.7em
#let content-top-inset = 3.25em
#let content-bottom-inset = 1.0em

// 4. Header
// Controls the green header bar on normal slides. The progress bar is
// visually attached below this header when enabled.
#let header-height = 2.35em
#let header-title-size = 22pt
#let header-subtitle-size = 16pt
#let header-logo-height = 2.0em
#let header-x-inset-left = 1.1em
#let header-x-inset-right = 1.0em
#let header-title-subtitle-gap = 0.6em
#let progress-bar-height = 3pt

// 5. Footer
// Controls the three-segment footer on normal slides and the overlaid footer
// on title, section, ending, and focus slides.
#let footer-height = 0.85em
#let footer-font-size = 12pt
#let footer-columns = (34%, 1fr, 32%)
#let footer-x-inset = 0.8em
#let footer-right-inset = 0.9em
#let footer-date-page-gap = 3.6em

// 6. Title slide
// Controls fixed-position title slide regions: title box, author/institute/date
// information, and logos.
#let title-slide-title-y = 3em
#let title-slide-info-y = 8em
#let title-slide-logo-y = 14em
#let title-slide-title-box-width = 95%
#let title-slide-title-box-radius = 0.45em
#let title-slide-title-box-inset = (x: 1.5em, y: 1.2em)
#let title-slide-title-box-fill = bit-green
#let title-slide-title-size = header-title-size
#let title-slide-author-size = 1.05em
#let title-slide-institute-size = 0.85em
#let title-slide-date-size = 0.8em
#let title-slide-author-institute-gap = 0.75em
#let title-slide-institute-date-gap = 0.75em
#let title-logo-height = 6em
#let title-institute-logo-height = 1.6em

// 7. Section divider slide
// Controls automatic level-1 section divider slides.
#let section-slide-title-y = 9em
#let section-slide-title-size = 36pt
#let section-slide-title-fill = bit-green
#let section-slide-rule-gap = 0.5em
#let section-slide-rule-height = 2.5pt
#let section-slide-rule-width = 40%
#let section-slide-rule-fill = bit-green

// 8. TOC slide
// Controls the generated table-of-contents slide. Styling is intentionally
// minimal because the TOC is rendered as a normal content slide.
#let toc-body-font-size = body-font-size
#let toc-depth = 1
#let toc-title = auto

// 9. Blocks and callouts
// Controls green-block, alert-block, example-block, and the shared block-env
// primitive.
#let block-above = 1em
#let block-below = 1em
#let block-radius = 0.3em
#let block-border-thickness = 0.5pt
#let block-title-height = 1.35em
#let block-title-x-inset = 0.7em
#let block-title-text-fill = text-light
#let block-title-text-weight = "bold"
#let block-body-inset = (
  left: 0.8em,
  right: 0.8em,
  top: 0.7em,
  bottom: 0.7em,
)
#let alert-block-title-fill = bit-green-dark
#let alert-block-body-fill = bit-green-light
#let alert-block-border-fill = bit-green-dark
#let example-block-title-fill = bit-green
#let example-block-body-fill = bit-green-pale
#let example-block-border-fill = bit-green

// 10. Footnotes
// Compact footnote styling for normal slides. Footnotes remain in the content
// area above the footer rather than relying on extra body padding.
#let footnote-font-size = 8pt
#let footnote-clearance = 0.35em
#let footnote-gap = 0.2em
#let footnote-indent = 1em

// 11. Logos and assets
// No global logo sizing lives here right now. Header and title slide logo sizes
// are region-specific and are defined in their sections above.

// 12. Compatibility aliases
// Deprecated alias. Use `title-slide-author-institute-gap`.
#let title-slide-info-gap = title-slide-author-institute-gap
