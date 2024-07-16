// University theme - modified to fit BUAA
// Inspired by https://github.com/QuadnucYard/touying-theme-seu

#import "@preview/touying:0.4.2": *

#let ustcblue=rgb("#034ea1")

/**
 * Creates a navigation bar component for the "touying" application.
 * 
 * @param self - The self parameter.
 * @returns The generated navigation bar component.
 */
 //横向导航栏
#let ustc-nav-bar(self: none) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none).map(section => (
    section,
    section.children,
  )).flatten().filter(item => item.kind == "section")
  final-sections = final-sections.filter(section => section.loc != none).map(section => (
    section,
    section.children,
  )).flatten().filter(item => item.kind == "section")
  let current-index = current-sections.len() - 1

  set text(size: 1em)
  for (i, section) in final-sections.enumerate() {
    set text(fill: if i != current-index {
      gray
    } else {
      white
    })
    box(inset: 1em)[#link(section.loc, utils.section-short-title(section))<touying-link>]
  }
})

/**
 * Defines the `buaa-outline` function which generates an outline for the `touying-progress-with-sections` state.
 * 
 * @param self - The current state of the outline.
 * @returns The generated outline with links to sections.
 */
 //章节目录页（）
#let buaa-outline(self: none) = states.touying-progress-with-sections(dict => {
  let (current-sections, final-sections) = dict
  current-sections = current-sections.filter(section => section.loc != none).map(section => (
    section,
    section.children,
  )).flatten().filter(item => item.kind == "section")
  final-sections = final-sections.filter(section => section.loc != none).map(section => (
    section,
    section.children,
  )).flatten().filter(item => item.kind == "section")
  let current-index = current-sections.len() - 1

  for (i, section) in final-sections.enumerate() {
    if i == 0 {
      continue
    }
    set text(fill: if current-index == 0 or i == current-index {
      self.colors.primary
    } else {
      self.colors.primary.lighten(80%)
    })
    block(
      spacing: 1.5em,
      [#link(section.loc, utils.section-short-title(section))<touying-link>],
    )
    if  i == current-index {
      block(height: 2pt, width: 100%, spacing: 0pt, utils.call-or-display(self, self.buaa-progress-bar))
    }
  }
})

/**
 * Defines a slide with customizable properties.
 *
 * @param self - The slide object.
 * @param title - The title of the slide.
 * @param subtitle - The subtitle of the slide.
 * @param header - The header of the slide.
 * @param footer - The footer of the slide.
 * @param display-current-section - Whether to display the current section.
 * @param args - Additional arguments for the slide.
 * @returns The slide object with the specified properties.
 */
#let slide(
  self: none,
  title: auto,
  subtitle: auto,
  header: auto,
  footer: auto,
  display-current-section: auto,
  ..args,
) = {
  if title != auto {
    self.buaa-title = title
  }
  if subtitle != auto {
    self.buaa-subtitle = subtitle
  }
  if header != auto {
    self.buaa-header = header
  }
  if footer != auto {
    self.buaa-footer = footer
  }
  if display-current-section != auto {
    self.buaa-display-current-section = display-current-section
  }
  (self.methods.touying-slide)(
    ..args.named(),
    self: self,
    title: title,
    setting: body => {
      show: args.named().at("setting", default: body => body)
      align(horizon, body)
    },
    ..args.pos(),
  )
}

/**
 * Defines a function `title-slide` that generates a title slide for a presentation.
 * 
 * @param self - The current state of the presentation.
 * @param args - Additional arguments for the title slide.
 * @returns The generated title slide content.
 */
#let title-slide(self: none, ..args) = {
  // Function implementation...
}
#let title-slide(self: none, ..args) = {
  // self = utils.empty-page(self)
  let info = self.info + args.named()
  info.authors = {
    let authors = if "authors" in info {
      info.authors
    } else {
      info.author
    }
    if type(authors) == array {
      authors
    } else {
      (authors,)
    }
  }
  let content = {
    if info.logo != none {
      align(center + top, info.logo)
    }
    show: align.with(center + horizon)
    block(
      fill: self.colors.primary,
      inset: 1.5em,
      radius: 0.5em,
      breakable: false,
      {
        text(size: 1.2em, fill: self.colors.neutral-lightest, weight: "bold", info.title)
        if info.subtitle != none {
          parbreak()
          text(size: 1.0em, fill: self.colors.neutral-lightest, weight: "bold", info.subtitle)
        }
      },
    )
    // authors
    grid(
      columns: (1fr,) * calc.min(info.authors.len(), 3),
      column-gutter: 1em,
      row-gutter: 1em,
      ..info.authors.map(author => text(fill: black, author)),
    )
    v(0.5em)
    // institution
    if info.institution != none {
      parbreak()
      text(size: 0.7em, info.institution)
    }
    // date
    if info.date != none {
      parbreak()
      text(size: 1.0em, utils.info-date(self))
    }
    // place(right + top, image("assets/vi/ustc_logo_side.svg",format: "svg"), dx: -1em)
  }
  (self.methods.touying-slide)(self: self, repeat: none, content)
}

#let outline-slide(self: none) = {
  // Generates an outline slide with a title and content.
  // The title is displayed as "目录" if the text language is "zh", otherwise it is displayed as "Outline".
  // The content includes alignment settings, bold text, and the buaa-outline function.
  // The outline slide is created using the touying-slide method.
  // Parameters:
  // - self: The self parameter of the outline-slide function.
  // Returns:
  // - The generated outline slide.
  self.buaa-title = context if text.lang == "zh" [目录] else [目录]
  let content = {
    set align(horizon)
    set text(weight: "bold")
    hide([-])
    buaa-outline(self: self)
  }
  (self.methods.touying-slide)(self: self, repeat: none, section: (title: context if text.lang == "zh" [目录] else [目录]), content)
}

/**
 * Defines a helper function to create a new section slide.
 *
 * @param self - The self parameter.
 * @param short-title - The short title of the section slide.
 * @param title - The title of the section slide.
 * @returns The new section slide.
 */
#let new-section-slide(self: none, short-title: auto, title) = {
  self.buaa-title = context if text.lang == "zh" [目录] else [目录]
  let content = {
    set align(horizon)
    set text(weight: "bold")
    hide([-]) // magic
    buaa-outline(self: self)
  }
  (self.methods.touying-slide)(self: self, repeat: none, section: (title: title, short-title: short-title), content)
}

/**
 * Defines a function `ending-slide` that generates an ending slide for a presentation.
 *
 * @param self - The `self` object.
 * @param title - The title of the ending slide. Optional.
 * @param body - The body content of the ending slide.
 * @returns The generated ending slide.
 */
#let ending-slide(self: none, title: none, body) = {
  let content = {
    set align(center + horizon)
    if title != none {
      block(
        fill: self.colors.tertiary,
        inset: (top: 0.7em, bottom: 0.7em, left: 3em, right: 3em),
        radius: 0.5em,
        text(size: 1.5em, fill: self.colors.neutral-lightest, title),
      )
    }
    body
  }
  (self.methods.touying-slide)(self: self, repeat: none, content)
}

/**
 * Defines a macro `slides` that generates slides based on the given parameters.
 *
 * @param self - The self parameter.
 * @param title-slide - A boolean indicating whether to include a title slide.
 * @param slide-level - The level of the slides.
 * @param args - Additional arguments.
 * @returns The generated slides.
 */
#let slides(self: none, title-slide: true, slide-level: 1, ..args) = {
  if title-slide {
    (self.methods.title-slide)(self: self)
  }
  (self.methods.touying-slides)(self: self, slide-level: slide-level, ..args)
}

/**
 * Registers a theme with customizable options.
 *
 * @param {Object} self - The theme object.
 * @param {string} aspect-ratio - The aspect ratio of the presentation.
 * @param {boolean} progress-bar - Whether to enable the progress bar.
 * @param {Array} footer-columns - The columns configuration for the footer.
 * @param {Function} footer-a - The function to generate content for footer column A.
 * @param {Function} footer-b - The function to generate content for footer column B.
 * @param {Function} footer-c - The function to generate content for footer column C.
 * @param {Function} footer-d - The function to generate content for footer column D.
 * @param {Object} args - Additional arguments for the theme.
 * @returns {Object} - The registered theme object.
 */
#let register(
  self: themes.default.register(),
  aspect-ratio: "16-9",
  progress-bar: true,
  footer-columns: (25%, 25%, 1fr, 5em),
  footer-a: self => self.info.author,
  footer-b: self => utils.info-date(self),
  footer-c: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-d: self => {
    states.slide-counter.display() + " / " + states.last-slide-number
  },
  ..args,
) = {
  // code implementation
}
#let register(
  self: themes.default.register(),
  aspect-ratio: "16-9",
  progress-bar: true,
  footer-columns: (25%, 25%, 1fr, 5em),
  footer-a: self => self.info.author,
  footer-b: self => utils.info-date(self),
  footer-c: self => if self.info.short-title == auto {
    self.info.title
  } else {
    self.info.short-title
  },
  footer-d: self => {
    states.slide-counter.display() + " / " + states.last-slide-number
  },
  ..args,
) = {
  // color theme
  self = (self.methods.colors)(
    self: self,
    primary: rgb("#034ea1"),
    primary-dark: rgb("#004098"),
    secondary: rgb("#ffffff"),
    tertiary: rgb("#005bac"),
    neutral-lightest: rgb("#ffffff"),
    neutral-darkest: rgb("#000000"),
  )
  // marker
  self.buaa-knob-marker = box(
    width: 0.5em,
    place(
      dy: 0.1em,
      circle(
        fill: gradient.radial(self.colors.primary.lighten(100%), self.colors.primary.darken(40%), focal-center: (30%, 30%)),
        radius: 0.25em,
      ),
    ),
  )

  // save the variables for later use
  self.buaa-enable-progress-bar = progress-bar
  self.buaa-progress-bar = self => states.touying-progress(ratio => {    
    grid(
      columns: (ratio * 100%, 1fr),
      rows: 2pt,
      components.cell(fill: self.colors.primary),
      components.cell(fill: self.colors.neutral-darkest),
    )
  })

  self.buaa-navigation = self => {
    grid(
      align: center + horizon,
      columns: (1fr, auto, auto),
      rows: 1em,
      components.cell(fill: self.colors.primary, ustc-nav-bar(self: self)),
      // block(fill: self.colors.neutral-lightest, inset: 4pt, height: 100%, image("assets/vi/ustc_logo_side.svg")),
    )
  }

  self.buaa-title = none
  self.buaa-subtitle = none
  self.buaa-footer = self => {
    let cell(fill: none, it) = rect(
      width: 100%,
      height: 100%,
      inset: 1mm,
      outset: 0mm,
      fill: fill,
      stroke: none,
      align(horizon, text(fill: self.colors.neutral-lightest, it)),
    )
    // grid(
    // align: center + horizon,
    // columns: (1fr, auto, auto),
    // rows: 1em,
    // components.cell(fill: self.colors.primary, ustc-nav-bar(self: self)),
    
    // )
    grid(
      // columns: footer-columns,
      columns:(27%,68%,5%),
      rows: (2em, auto),
      // cell(fill: self.colors.primary, utils.call-or-display(self, footer-a)),
      // cell(fill: self.colors.primary-dark, utils.call-or-display(self, footer-b)),
      // cell(fill: self.colors.primary, utils.call-or-display(self, footer-c)),
      cell(fill: self.colors.primary.lighten(10%), utils.call-or-display(self, footer-c)),
      cell(fill: self.colors.primary, ustc-nav-bar(self: self)),
      // cell(fill: self.colors.primary, utils.call-or-display(self, footer-a)),
      // cell(fill: self.colors.primary-dark.darken(20%), utils.call-or-display(self, footer-b)),
      cell(fill: self.colors.primary.darken(10%), utils.call-or-display(self, footer-d)),
    )
  }

  self.buaa-header = self => {
    if self.buaa-title != none {
      block(
        width: 100%,
        height: 2em,
        fill: gradient.linear(self.colors.primary, self.colors.neutral-lightest),
      )
      
      place(left + horizon, text(fill: self.colors.neutral-lightest, weight: "bold", size: 1.3em, self.buaa-title), dx: 1.5em)

      place(right + horizon, image("assets/img/ustc_logo_side.svg",format: "svg"), dx: -1em)
    }
  }
  // set page
  let header(self) = {
    set align(top)
    grid(
      rows: (auto, auto),
      // utils.call-or-display(self, self.buaa-navigation),
      utils.call-or-display(self, self.buaa-header),
    )
  }
  let footer(self) = {
    set text(size: .5em)
    set align(center + bottom)
    grid(
      rows: (auto, auto),
      utils.call-or-display(self, self.buaa-footer),
      if self.buaa-enable-progress-bar {
        utils.call-or-display(self, self.buaa-progress-bar)
      },
    )
  }

  self.page-args += (
    paper: "presentation-" + aspect-ratio,
    header: header,
    footer: footer,
    header-ascent: 0em,
    footer-descent: 0em,
    margin: (top: 4.5em, bottom: 3.5em, x: 2.5em),
  )
  // register methods
  self.methods.slide = slide
  self.methods.title-slide = title-slide
  self.methods.outline-slide = outline-slide
  self.methods.new-section-slide = new-section-slide
  self.methods.touying-new-section-slide = new-section-slide
  self.methods.ending-slide = ending-slide
  self.methods.slides = slides
  self.methods.touying-outline = (self: none, enum-args: (:), ..args) => {
    states.touying-outline(self: self, enum-args: (tight: false) + enum-args, ..args)
  }
  self.methods.alert = (self: none, it) => text(fill: self.colors.primary, it)

  self.methods.tblock = (self: none, title: none, it) => {
    grid(
      columns: 1,
      row-gutter: 0pt,
      block(
      fill: self.colors.primary-dark,
      width: 100%,
      radius: (top: 6pt),
      inset: (top: 0.4em, bottom: 0.3em, left: 0.5em, right: 0.5em),
      text(fill: self.colors.neutral-lightest, weight: "bold", title),
    ),
      rect(
        fill: gradient.linear(self.colors.primary-dark, self.colors.primary.lighten(90%), angle: 90deg),
        width: 100%,
        height: 4pt,
      ),
      block(
        fill: self.colors.primary.lighten(90%),
        width: 100%,
        radius: (bottom: 6pt),
        inset: (top: 0.4em, bottom: 0.5em, left: 0.5em, right: 0.5em),
        it,
      ),
    )
  }

  self.methods.init = (self: none, lang: "en", font: ("Linux Libertine",), body) => {
    set text(size: 19pt, font: font)
    set heading(outlined: false)
    set list(marker: self.buaa-knob-marker)

    show strong: it => text(weight: "bold", it)

    show figure.caption: set text(size: 0.6em)
    show footnote.entry: set text(size: 0.6em)
    show link: it => if type(it.dest) == str {
      set text(fill: self.colors.primary)
      it
    } else {
      it
    }

    show: if lang == "zh" {
      import "@preview/cuti:0.2.1": show-cn-fakebold
      show-cn-fakebold
    } else {
      it => it
    }

    set text(lang: lang)
    show figure.where(kind: table): set figure.caption(position: top)

    body
  }

  self
}
