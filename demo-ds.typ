#import "tids.typ": tids
#import "@preview/gentle-clues:1.1.0": *

#let metadata = (
    title: [FXC1117 Flux Capacitor],
    product: "FXC1117",
    product_url: "https://github.com/oldrev/tids",
)

#let features = [
    - Capacity: 1.21 gigawatts
    - Operating Voltage: 88 billion volts
    - Dimensions: Standard size, suitable for most electronic devices
    - Material: Advanced alloys and insulating materials
    - Frequency Response: Exceeds 1.21 kilohertz
    - Temperature Range: -40°C to 150°C
    - Stability: High stability, suitable for extreme environments
]


#let applications = [

    The FXC1117 Flux Capacitor is an advanced electronic component widely used in the following fields:

    - Time travel technology
    - Energy conversion
    - Electronics enhancement
    - Space deformation techniques
    - Quantum communication

    #figure(
        rect(image("./assets/741.svg"), stroke: 0.5pt), caption: "Typical Application"
    )
]

#let desc = [
    The Flux Capacitor is a revolutionary electronic technology utilizing advanced alloys and insulating materials, enabling it to operate in extreme conditions. Its high capacity and operating voltage make it an ideal choice for time travel technology and energy conversion fields.

    Additionally, Flux Capacitors can be applied in electronics enhancement, space deformation techniques, and quantum communication. Their stability and frequency response make them an innovative product in the future of electronic components.
]

#let rev_list = (
    (rev: [REV2], date: [2024/12/12], body: [
        - #lorem(10)
        - #lorem(8)
        - #lorem(8)
    ]),
    (rev: [REV1], date: [2012/12/12], body: [
        - #lorem(10)
        - #lorem(18)
        - #lorem(18)
        - #lorem(18)
    ]),
)

#show: doc => tids(
    ds_metadata: metadata,
    features: features,
    applications: applications,
    desc: desc,
    rev_list: rev_list,
    doc: doc
)

= Specifications

== Pin Configuration and Functions
<PinConfigAndFunctions>

#lorem(30)

#lorem(30)

== Specifications
<Specifications>

#table(
    columns: (1fr, auto, auto, auto, auto, auto, 1fr),
    align: (left,center,right,right,right,left,left,),

    table.header([Parameters], [Symbol], [Minimum], [Typical], [Maximum], [Unit], [Condition]),

    [Rated Voltage], [$V_(upright("IN"))$], [5], [—], [24], [V], [—],

    [Rated Current], [$I$], [100], [150], [1,000], [mA], [Using 5V Supply],

    [High-Level Voltage], [$V_(upright("OH"))$], [4.5], [—], [—], [V], [—],

    [Low-Level Voltage], [$V_(upright("OL"))$], [—], [—], [0.5], [V], [—],

    [Output High-Level Current], [$I_(upright("OH"))$], [—], [20], [—], [mA], [—],
)

== Absolute Maximum Ratings
<AbsoluteMaximumRatings>

#table(
    columns: (auto, auto, auto, auto, auto, 1fr),
    align: (left,center,right,right,center,left),

    table.header([Parameter], [Symbol], [Minimum Value], [Maximum Value], [Unit], [Note]),

    [Power Supply Voltage], [$V_(upright("IN"))$], [0], [30], [V],[],

    [Ambient Temperature], [$T_A$], [-25], [85], [°C],[],
)

#warning(title: "Warning")[
    Before start it you must be sure you have enough garbage.
]


#pagebreak()

= Detailed Description
<DetailedDescription>

== Overview

#lorem(200)

#lorem(200)

== Functional Block Diagram

#lorem(200)

#pagebreak()

= Application and Implementation

=== Application Information

#lorem(200)

=== Typical Applications

#lorem(200)

=== Design Requirements

#lorem(200)

= Power Supply Recommendations

#lorem(200)

=== PCB Layout

#lorem(200)

#pagebreak()

= Device and Documentation Support

=== Device Support

=== Related Links

#lorem(200)

#pagebreak()

= Mechanical, Packaging, and Orderable Information

#lorem(30)

#lorem(30)
