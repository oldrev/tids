#import "@preview/cetz:0.3.1": canvas
#import "@preview/cetz-plot:0.1.0": plot, chart

#let company_info = (
    name:           "命数半导电股份有限公司",
    logo:           "./assets/demo-logo.svg",
    website_url:    "https://github.com/oldrev",
)

#let tids(ds_metadata: (
        title: [YourDSTitle],
        product: [YourProductName],
        product_url: "https://github.com/oldrev/tids",
        revision: [CurrentRevision],
        publish_date: [PublishedOn]
    ), features: [], applications: [], desc: [], rev_list: [], doc: []) = {

    let fonts = (
        serif:          ("Source Han Serif", "Liberation Serif"),
        sans:           ("Source Han Sans"),
        mono:           ("Source Han Mono"),
        text:           ("Source Han Sans", "Liberation Sans"),
        text_strong:    ("Source Han Sans"),
        headings:       ("Source Han Sans"),
        code:           ("Source Han Mono"),
    )

    set text(font: fonts.text, size: 10.5pt)
    show strong: it => text(font: fonts.text_strong, weight: "bold", it)
    show link: it => text(fill: rgb("#0000FF"))[#it]
    set page(paper: "a4")

    // Figure styles
    show figure.caption: set text(
        weight: "regular",
        font: fonts.headings
    )

    // table styles
    show figure.where(
        kind: table
    ): set figure.caption(position: top)

    set table(
        stroke: 0.5pt,
        fill: (_, y) => if y == 0 { gray.lighten(75%) },
        align: (_, y) => if y == 0 { align(center) },
    )

    show table.cell.where(y: 0): set text(weight: "regular", font: fonts.headings)


    let lastest_rev = rev_list.first()

    let outline_page() = {
        [
            #block(height: 40%, [
                #columns(2, gutter: 30pt)[
                    = 目录
                    <Directory>
                    #outline(title: none, depth: 3)
                ]
            ])

            #line(length: 100%, stroke: 1pt)

            = 修订记录

            <Revisions>

            #v(1em)

            #block({
                for r in rev_list {
                    text(font: fonts.text_strong, weight: "medium", [#r.rev - #r.date])
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
        context {
            if calc.odd(here().page()) {
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
        }
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

    let cover_page_footer = {
        line(length: 100%, stroke: 1pt)
        v(-0.65em)

        grid(columns: (auto, 1fr), rows: 1, gutter: 10pt,
            align(top, image("assets/octagon-exclamation.svg", height: 9mm)),
            box([
            #set text(10pt, baseline: 0pt)
            *重要须知* 本数据手册末尾的重要通知涉及产品可用性、保修、变更、在安全关键应用中的使用、知识产权问题以及其他重要免责声明。
            ]),
        )
    };

    let cover_page_icon(icon: str, url: str, body: content) = {
        link(url,
            grid(
                rows: 1,
                columns: (auto, auto),
                align: horizon,
                column-gutter: 3pt,
                row-gutter: 0pt,
                image(icon, height: 0.3in),
                align(left, {
                    set par(leading: 5pt)
                    set text(9pt, fill: black)
                    body
                })
            )
        )
    }

    let cover_page() = page(
        margin: (top: 0.3in),
        header: none,
        header-ascent: 0%+0pt,
        footer: cover_page_footer
    )[

#show figure.where(
  kind: auto
): set figure.caption(position: top)

#align(center, grid(
    columns: (auto, auto, auto, auto, auto, auto),
    rows: (auto),
    gutter: 15pt,
    align: center,

    cover_page_icon(icon: "assets/icons/folder.svg", url: "https://github.com/oldrev", body: [产品#linebreak()目录]),
    cover_page_icon(icon: "assets/icons/cart.svg", url: "https://github.com/oldrev", body: [样品#linebreak()购买]),
    cover_page_icon(icon: "assets/icons/tools.svg", url: "https://github.com/oldrev", body: [工具与#linebreak()软件]),
    cover_page_icon(icon: "assets/icons/doc.svg", url: "https://github.com/oldrev", body: [技术#linebreak()文档]),
    cover_page_icon(icon: "assets/icons/doc.svg", url: "https://github.com/oldrev", body: [支持与#linebreak()社区]),
    cover_page_icon(icon: "assets/icons/doc.svg", url: "https://github.com/oldrev", body: [参考#linebreak()设计]),
))

#v(0.3in)

#grid(
    inset: 0pt,
    columns: (1fr, 1fr),
    rows: (auto),
    gutter: 0pt,
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

#grid(
    columns: 1,
    row-gutter: 5pt,
    [#line(length: 100%, stroke: 1pt + black)],
    [
        #set text(18pt, font: fonts.headings, weight: "medium")
        #align(center, ds_metadata.title)
    ],
    [#line(length: 100%, stroke: 1pt + black)],
)

#v(0.3em)

#box(height: auto,
    columns(2, gutter: 30pt)[

= 特性
<TitlePageFeatures>

#features

= 用途
<TitlePageApplications>

#applications

#colbreak()

= 产品简介
<产品简介>

#desc

])
    ]

    let backcover_page() = [
        #counter(page).update(n => n - 1)
        #set page(
            numbering: none,
            header: none,
            footer: none,
        )
        #show heading: it => it.body

        #v(2.5cm)

        #align(center)[
            #heading(level: 1, outlined: false)[重要通知和声明]
        ]

        #lorem(30)

        #lorem(50)

        #lorem(30)

        #v(2.5cm)
        #align(center)[
            *本文为演示排版功能，内容纯属虚构。如有雷同，纯属巧合！*
        ]
    ]

    let afterwords_page() = [
        = 文档索引

        #box(height: auto, [
            #columns(2, gutter: 30pt)[
                == 图表索引
                #outline(
                    title: none,
                    target: figure.where(kind: image),
                )
                #colbreak()
                == 表格索引
                #outline(
                    title: none,
                    target: figure.where(kind: table),
                )
            ]
        ])
    ]


    set par(leading: 0.75em)

    set page(
        numbering: "(1 / 1)",
        footer-descent: 2em,
        header: [
            #set text(10pt)
            #context {
                if calc.odd(here().page()) {
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
            }
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


    cover_page()

    pagebreak()

    outline_page()

    pagebreak()
    // document-body
    doc

    pagebreak()

    afterwords_page()

    pagebreak()

    backcover_page()
}
