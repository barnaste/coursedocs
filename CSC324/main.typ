// theme
#import "@preview/catppuccin:1.0.0": catppuccin, flavors
#show: catppuccin.with(flavors.latte)

// headings
#set heading(numbering: "1.1")

// frames
#import "@preview/frame-it:1.2.0": *

// define desired frames
#let (definition, theorem, problem, note) = frames(
  problem: ("Problem",),
  note: ("Note",),
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


// table config
#let frame(stroke) = (x, y) => (
  left: 0pt,
  right: 0pt,
  top: if y < 2 {stroke} else {0pt},
  bottom: stroke,
)

#set table(
  fill: rgb("#e6e9ef"),
  stroke: frame(rgb("#000000"))
)

// page numbering
#set page(numbering: "1")

// ==== DOCUMENT BEGINS HERE ====

#align(center, text(20pt)[
  *CSC324 Notes* 
])
#align(center, text(14pt)[
  Autumn 2025 \
  Stefan Barna
])
#linebreak()

#outline()
#linebreak()

Haskell is a strongly typed functional programming language
- very good for defining domain-specific languages (DSLs); examples of DSLs include SQL and CSS

What defines a programming language?
- syntax, semantics, underlying fundamental concepts
How are programming languages designed and implemented?

How do we reason about programs?
- what properties does a program have? how do we prove them?

What is being researched wrt programming languages?
- Theoretical: Formal semantics, logics (CH isomorphism), type theory, program analysis, proof systems/assistants,...
- Applied: compiler design and optimizations, domain-specific languages, concurrency, distributed systems

_Questions_ What are algebraic data types? What is type theory?

#note[][Read chapters 1, 2 of TAPL after lecture.]

= Types and Programming Languages (Introduction)
Type systems are a lightweight formal method.

#definition[type system][
  A _type system_ is a tractable syntactic method for proving the absence of certain program behaviours
  by classifying phrases according to the kinds of values they compute.
]

Typing rules are usually applied to the code's syntax, classifying terms according to the properties of the values that they will compute when executed.

Statically typed programming languages are those for which types are known at compile time.
Dynamically typed languages, in contrast, are those for which types are only known at runtime.

We will focus on type systems found in programming languages, while type systems (or _type theory_)
more generally refers to a much broader field of study in logic, mathematics, and philosophy.

Types introduce order to a language by defining what kinds of data can interact with what other kinds
of data, and how. The stronger the type system, the safer the language.
- language design goes hand-in-hand with type system design

= Haskell
Haskell is a _purely functional_ programming languages.
- There are no side effects.
- Functions are first-class citizens, meaning we can pass functions as inputs, and return them as outputs.
- Haskell is lazy, meaning computations will not happen unless necessary.
- Haskell is strongly typed with a powerful type inference system.
Variables are not mutable in Haskell.
