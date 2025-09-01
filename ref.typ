// theme
#import "@preview/catppuccin:1.0.0": catppuccin, flavors
#show: catppuccin.with(flavors.latte)

// headings
#set heading(numbering: "1.1")

// frames
#import "@preview/frame-it:1.2.0": *

// define desired frames
#let (definition, theorem, problem, tip) = frames(
  problem: ("Problem",),
  tip: ("Tip",),
  theorem: ("Theorem",),
  definition: ("Definition",),
)

#show: frame-style(styles.hint)
#show figure.where(kind: "frame"): set block(breakable: false)

// arbitrary diagrams
#import "@preview/cetz:0.4.1"

// node-based diagrams
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

// program formatting
#import "@preview/zebraw:0.5.5": *
#show: zebraw.with(
  numbering-separator: true,
  background-color: rgb("#e6e9ef"),
  lang-color: rgb("#e6e9ef"),
)

// algorithm formatting
#import "@preview/algorithmic:1.0.4"
#import algorithmic: algorithm-figure
#show: algorithmic.style-algorithm

= PACKAGE DEMOS
== Frames

#definition[][tags (optional)][Contents]
#theorem[][tags (optional)][Contents]
#problem[][tags (optional)][Contents]
#tip[][tags (optional)][Contents]

== Fletcher
// for more information visit https://typst.app/universe/package/fletcher/

// math diagram
#diagram(cell-size: 15mm, $
  G edge(f, ->) edge("d", pi, ->>) & im(f) \
  G slash ker(F) edge("ur", tilde(f), "hook->>")
  $)
// edge(direction (optional), label (optional), arrow type (optional))

// graph
#let nodes = ("A", "B", "C", "D", "E", "F", "G")
#let edges = (
  (3, 2),
  (4, 1),
  (1, 4),
  (0, 4),
  (3, 0),
  (5, 6),
  (6, 5),
)

#diagram({
  for (i, n) in nodes.enumerate() {
    let theta = 90deg - i*360deg/nodes.len()
    node((theta, 18mm), n, stroke: 0.5pt, name: str(i))
  }
  for (from, to) in edges {
    let bend = if (to, from) in edges { 10deg } else { 0deg }
    // refer to nodes by label
    edge(label(str(from)), label(str(to)), "-|>", bend: bend)
  }
})
// node(coordinate, label, ..args)
// edge(from, to, arrow type (optional), bend (optional))

// graph 2
#let nodes = ("A": (0, 0), "B": (2, 0), "C": (1, 1))
#let edges = (
  ("A", "B"),
  ("C", "B"),
  ("C", "A"),
)
#diagram({
  for (k, v) in nodes { node(v, k, stroke: 0.5pt, name: str(k)) }
  for (from, to) in edges {
    let bend = if (to, from) in edges { 10deg } else { 0deg }
    // refer to nodes by label
    edge(label(str(from)), label(str(to)), "-|>", bend: bend)
  }
})

== CeTZ
// for more information visit https://typst.app/universe/package/cetz/

// (parse) tree
#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  set-style(content: (padding: 0.5em))
  tree.tree(
    ([Expression 5], (
      [Expression 3],
      ([Expression 1], `Int(1)`), `Plus`,
      ([Expression 2], `Int(2)`)
    ),
    `Lt`,
    ([Expression 4], `Int(4)`)
  )
  )
})

== Zebraw
// for more information visit https://typst.app/universe/package/zebraw/

```rust
  fn main() {
    todo!()
  }
```

== Algorithmic
// for more information visit https://typst.app/universe/package/algorithmic/

#algorithm-figure(
  "Binary Search",   // algorithm label
  vstroke: .5pt + luma(200),
  {
  import algorithmic: *
  Procedure(
    "Binary-Search", // algorithm name
    ("A", "n", "v"), // arguments
    {                // body
    Comment[Initialize the search range]
    Assign[$l$][$1$]
    Assign[$r$][$n$]
    LineBreak
    While(
      $l <= r$, // condition
      {
      Assign([mid], FnInline[floor][$(l+r)$ / 2])
      IfElseChain(
        $A ["mid"] < v$,
        {
        Assign[$l$][$"mid" + 1$]
        },
        [$A ["mid"] > v$],
        {
        Assign[$r$][$"mid" - 1$]
        },
        Return[mid],
      )
      },
    )
    Return[*null*]
    },
  )
  }
)

