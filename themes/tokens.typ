// themes/tokens.typ
// Design tokens for the Bit theme.

#let bit-green = rgb("#006633")
#let bit-green-dark = rgb("#004020")
#let bit-green-light = rgb("#dfeee6")
#let bit-green-pale = rgb("#edf6f1")

#let text-dark = rgb("#111111")
#let text-light = white

// Header and footer bar heights (fixed, em-based).
#let header-height = 2.35em
#let footer-height = 0.85em

// Content area insets — the theme converts these into page margins:
//   margin.top    = content-top-inset
//   margin.bottom = footer-height + content-bottom-inset
//   margin.x      = content-x-margin
// The header bar lives in the top margin and the footer in the bottom
// margin, so content-top-inset must be larger than header-height for
// body text to start below the green header bar.
#let content-x-margin = 1.7em
#let content-top-inset = 3.25em
#let content-bottom-inset = 1.0em

// Progress bar (optional, below the header bar) thickness.
#let progress-bar-height = 3pt

// Footnote styling — applied via set/show rules in the theme init.
#let footnote-font-size = 8pt
#let footnote-clearance = 0.35em
#let footnote-gap = 0.2em
#let footnote-indent = 1em

// Font sizes.
#let header-title-size = 22pt
#let header-subtitle-size = 16pt
#let body-font-size = 20pt
#let body-leading = 1.25em
#let footer-font-size = 12pt

// Title slide — vertical positions measured from the physical page top.
// Each element is placed via place(top + center, dy: ...).
#let title-slide-title-y = 3em
#let title-slide-info-y = 8em
#let title-slide-logo-y = 14em

#let title-slide-info-gap = 0.75em
#let title-slide-author-size = 1.05em
#let title-slide-institute-size = 0.85em
#let title-slide-date-size = 0.8em

// Section divider slide — title vertical position and font size.
#let section-slide-title-y = 9em
#let section-slide-title-size = 36pt

// Footer segment fills — three subtle green shades for the 3-column
// Beamer-style footline.  Left and right are darker; center is lighter.
#let footer-left-fill = rgb("#004020")
#let footer-center-fill = rgb("#005a2c")
#let footer-right-fill = rgb("#006633")

// Footer column layout — left and right are fixed widths, center flexes.
#let footer-columns = (34%, 1fr, 32%)

// Footer right segment spacing.
#let footer-right-inset = 0.9em
#let footer-date-page-gap = 3.6em

// Logo sizing — each token controls one specific placement.
//   header-logo-height          — normal slide header bar logo.
//   title-logo-height           — title slide main logo (bit_logo.pdf).
//   title-institute-logo-height — title slide institution mark (header.svg).
#let header-logo-height = 2.0em
#let title-logo-height = 6em
#let title-institute-logo-height = 1.6em
