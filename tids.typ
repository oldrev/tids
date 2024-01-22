#import "@preview/tablex:0.0.8": tablex, hlinex, vlinex, colspanx, rowspanx
#import "@preview/cetz:0.1.2": canvas, plot

#let company_info = (
    name:           "Mingshu Semiconductors Inc.",
    logo:           "./assets/demo-logo.svg",
    website_url:    "https://github.com/oldrev",
)

#let ds_tablex_styles = (
    repeat-header: true,
    inset: 6pt,
    map-vlines: v => (..v, stroke: 0.5pt),
    map-hlines: h => (..h, stroke: 0.5pt),
)


#let tids(ds_metadata: (
        title: [YourDSTitle],
        product: [YourProductName],
        product_url: "https://github.com/oldrev/tids",
        revision: [CurrentRevision],
        publish_date: [PublishedOn]
    ), features: [], applications: [], desc: [], rev_list: [], doc: []) = {

    let fonts = (
        serif:          ("Times New Roman", "Source Serif", "Liberation Serif"),
        sans:           ("Dejavu Sans", "Arial", "Helvetica Neue", "Helvetica", "Source Sans"),
        mono:           ("Consolas", "Source Mono"),
        text:           ("Arial", "Dejavu Sans"),
        text_strong:    ("Arial", "Dejavu Sans"),
        headings:       ("Arial", "Dejavu Sans", "Helvetica Neue", "Helvetica"),
        code:           ("Source Mono"),
    )

    set text(font: fonts.text, size: 11pt)
    show link: it => text(fill: rgb("#0000FF"))[#it]
    set page(paper: "a4")

    let lastest_rev = rev_list.first()

    let outline_page() = {
        [
            #block(height: 40%, [
                #columns(2, gutter: 30pt)[
                    #outline(title: "Contents", depth: 3)
                ]
            ])

            #line(length: 100%, stroke: 1pt)

            = Revisions

            <Revisions>

            #v(1em)

            #block({
                for r in rev_list {
                    text(font: fonts.sans, weight: "semibold", [#r.rev - #r.date])
                    v(-0.65em)
                    line(length: 100%, stroke: 0.3pt)
                    v(-0.65em)
                    block(r.body)
                    v(-0.65em)
                    line(length: 100%, stroke: 0.65pt)
                    v(0.65em)
                }
            })
        ]
    }

    let page_footer() = {
        line(length: 100%, stroke: 1pt)
        v(-0.65em)
        set text(10pt, baseline: 0pt)
        locate(loc => if calc.odd(loc.page()) {
                grid(
                    columns: (5fr, 1fr),
                    rows: (auto),
                    gutter: 0pt,
                    [Copyright © #link(company_info.website_url)[#company_info.name]],
                    [
                        #set align(right)
                        #counter(page).display("1 / 1", both: true)
                    ],
                )
            } else {
                grid(
                    columns: (1fr, 5fr),
                    rows: (auto),
                    gutter: 0pt,
                    [
                        #set align(left)
                        #counter(page).display("1 / 1", both: true)
                    ],
                    [
                        #set align(right)
                        Copyright © #link(company_info.website_url)[#company_info.name]],
                )
            }
        )
    }

    let current_chapter() = locate(loc => {
        let elems = query(
            heading.where(level:2).before(loc),
            loc,
        )
        if elems != () {
            let elem = elems.last()
            h(1fr) + emph(counter(heading).at(loc).map(str).join(".") + h(.75em) + elem.body) + h(1fr)
        }
    })

    let afterwords_page() = {

        set page(numbering: none)

        set heading(numbering: none)

        [
            = Indexing

            #box(height: auto, [
                #columns(2, gutter: 30pt)[
                    #outline(
                        title: [Figures],
                        target: figure.where(kind: image),
                    )
                    #colbreak()
                    #outline(
                        title: [Tables],
                        target: figure.where(kind: table),
                    )
                ]
                #line(length: 100%, stroke: 1pt)
            ])

            = Legal Disclaimer Notice

            #lorem(30)

            #lorem(50)

            #lorem(30)
        ]

    }

    set par(leading: 0.75em)

    set page(
        numbering: "(1 / 1)",
        footer-descent: 2em,
        header: [
            #set text(10pt)
            #locate(loc => if calc.odd(loc.page()) {
                    grid(
                        columns: (1fr, 1fr),
                        rows: (100%),
                        gutter: 3pt,
                        [
                            #set align(left)
                            #link(company_info.website_url)[#image(company_info.logo, height: 28pt)]
                        ],
                        [
                            #set align(right)
                            #link(ds_metadata.product_url)[#ds_metadata.product]
                            #linebreak()
                            #lastest_rev.rev - #lastest_rev.date
                        ],
                    )
                } else {
                    grid(
                        columns: (1fr, 1fr),
                        rows: (100%),
                        gutter: 3pt,
                        [
                            #set align(left)
                            #link(ds_metadata.product_url)[#ds_metadata.product]
                            #linebreak()
                            #lastest_rev.rev - #lastest_rev.date
                        ],
                        [
                            #set align(right)
                            #link(company_info.website_url)[#image(company_info.logo, height: 28pt)]
                        ],
                    )
                }
            )
            #v(-0.65em)
            #line(length: 100%, stroke: 1pt)
        ],
        footer: page_footer(),
        // background: rotate(45deg,
        //    text(80pt, fill: rgb("FFCBC4"))[
        //  *CONFIDENTIAL*
        // ])
    )

    set heading(numbering: "1.")

    show heading: it => block([
        #v(0.3em)
        #text(weight: "bold", font: fonts.headings, [#counter(heading).display() #it.body])
        #v(0.8em)
    ])

    show heading.where(level: 1): it => {
        block([
            #text( weight: "bold", font: fonts.headings, [#counter(heading).display() #it.body])
            #v(0.3em)
        ])
    }

    v(-0.65em)
    align(center, block({
        set text(16pt, font: fonts.headings, weight: "medium")
        ds_metadata.title
        v(-0.5em)
        line(length: 100%, stroke: 1pt)
        v(0.3em)
    }))

    box(height: auto,
        columns(2, gutter: 30pt)[

= Features
<TitlePageFeatures>

#features

= Applications
<TitlePageApplications>

#applications

#colbreak()

= Description
<Description>

#desc

    #figure(rect(height: 30%,
    canvas(length: 0.75cm, {
        plot.plot(size: (8, 6),
        x-tick-step: 1,
        x-ticks: ((-calc.pi, $-pi$), (0, $0$), (calc.pi, $pi$)),
        y-tick-step: 1,
        {
            plot.add(
            domain: (-calc.pi, calc.pi), x => calc.sin(x * 1rad))
        })
    })
    ), caption: [Awesome Performance])

    ])

    pagebreak()

    outline_page()

    pagebreak()
    // document-body
    doc

    afterwords_page()
}
