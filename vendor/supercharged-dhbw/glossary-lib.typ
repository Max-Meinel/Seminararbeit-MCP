#import "locale.typ": GLOSSARY
#import "shared-lib.typ": display, display-link

#let prefix = "glossary-state-"
#let glossary-state = state("glossary", none)

#let init-glossary(glossary) = {
  glossary-state.update(glossary)
}

// Display acronym. Expands it if used for the first time
#let gls(element, link: true) = {
  display("glossary", glossary-state, element, element, link: link)
}

// Print an index of all the acronyms and their definitions.
#let print-glossary(language, glossary-spacing) = {
  heading(level: 1, outlined: false, numbering: none)[#GLOSSARY.at(language)]

  context {
    let glossary = glossary-state.get()
    let glossary-keys = glossary.keys()

    // Calculate max width for all entries
    let max-width = 0pt
    for key in glossary-keys {
      if not key.starts-with("_") {
        let result = measure(key).width
        if (result > max-width) {
          max-width = result
        }
      }
    }

    // Build sections: preserve order of section markers, sort entries within each section
    let sections = ()
    let current-section-entries = ()

    for key in glossary-keys {
      if key.starts-with("_") {
        // Found a section marker
        if current-section-entries.len() > 0 {
          // Sort and save previous section
          sections.push(current-section-entries.sorted())
          current-section-entries = ()
        }
        // Add section header
        sections.push((key,))
      } else {
        // Regular entry
        current-section-entries.push(key)
      }
    }

    // Don't forget last section
    if current-section-entries.len() > 0 {
      sections.push(current-section-entries.sorted())
    }

    // Render all sections
    let section-count = 0
    for section in sections {
      for element in section {
        if element.starts-with("_") {
          // Section header
          section-count = section-count + 1
          heading(level: 2, outlined: false, numbering: none)[#element.slice(1)]
        } else {
          // Regular entry
          grid(
            columns: (max-width + 1em, auto),
            gutter: glossary-spacing,
            [*#element#label("glossary-" + element)*], [#glossary.at(element)],
          )
        }
      }
    }
  }
}