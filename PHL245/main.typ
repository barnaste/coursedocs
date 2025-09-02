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
  *PHL245 Notes* 
])
#align(center, text(14pt)[
  Autumn 2025 \
  Stefan Barna
])
#linebreak()

#outline()
#linebreak()

= Arguments
#definition[statement][A _statement_ is a truth-apt declarative sentence.]

A declarative sentence is a one that states a fact, opinion, observation, or explanation.
Sentences that are _not_ declarative include interrogative sentences (which ask questions),
imperative sentences (which give commands), and exclamatory sentences (which express strong
emotions). Non-statements are useful in rhetorical persuasion, however serve no purpose in technical logic.

#definition[argument][
  An _argument_ is a collection of statements, partitioned into premises and a
  conclusion, such that the conclusion follows from the premises.
]

_Deductive_ arguments are certain, meaning that whenever the premises hold, we know absolutely
that the conclusion holds. Inductive and abductive arguments, however, are fallible.

#definition[validity & soundness][
  An argument is _valid_ if, whenever the premises are true, the conclusion is also true.
  An argument is _sound_ when it is valid and its premises are true.
]

#definition[tautology][
  A statement is a _tautology_ when it is always true.
]
#definition[contradiction][
  A statement is a _contradiction_ when it is always false.
]
#definition[contingency][
  A statement is _contingent_ when there exist cases where it is true, and cases where it is false.
]

= Semantics
== Syntax
#definition[logical connective][
  We define a symbol to be a _logical connective_ when it is an element of the set ${not, and, or, ->, <->}$. We furthermore call $not$
  the _unary_ connective, and the elements in $cal(B)={and, or, ->, <->}$ _binary_ connectives.
]

A statement that has no logical connectives, and can therefore not be
simplified any further, is called _atomic_. A statement that has logical connectives is called _molecular_.

#definition[well formed formula][
  A _propositional variable_ is a symbol belonging to the set  $cal(P)={P, Q, R, ..., Z}$ representing an atomic statement. With this definition, we may define the set $cal(W)$ of _well-formed formulae_ (WFF) inductively.

  If $cal(P)$ and $cal(B)$
  are the sets of propositional variables and binary connectives as defined above,
  - (base) $forall P in cal(P)$, $P$ is a formula
  - (unary) If $phi$ is a formula, then $not phi$ is a formula
  - (binary) If $phi$ and $psi$ are formulae, then $(phi dot psi)$ is a formula, where $dot in {and, or ->, <->}$
]

We may think of WFF as arrangements of our symbols in ways that make sense. Analogously, if we have a dictionary
${"a", "an", "animal", ...}$ and a collection of punctuation ${" ", ., !, ?, ...}$, not all combinations of
these elements will produce valid sentences.

#definition[main connective][
  Every molecular well-formed formula is by definition of form
  - $dot phi$ for $dot in {not}$; or
  - $(phi dot psi)$ for $dot in {and, or , ->, <->}$.
  We call $dot$ the _main connective_ in either of these cases.
]

We may think of the well-formed formula as a parse tree by considering its structural definition. In this form, the main connective
is the root node. In general, we may define sub-main connectives, sub-sub-main connectives, etc as internal nodes of level 2, level 3, etc.
This way, each $n$-sub-main connective is in fact the main connective of an $n$-subtree.
#footnote[Furthermore, all leaves are propositional variables.]

A formula is then parseable if and only if, for any subformula, there exists a
clear main connective. But as parseability is how we evaluate whether a formula
_makes sense_, the main connective is central to the understanding of formulae.

#linebreak()
== Semantics
We might notice that there is an excess use of parentheses within a well-formed formula.
However, removal of these symbols runs the risk of ambiguity, as we can no longer identify the main
connective. For instance, it is not immediately clear what the main connective of $P and Q -> R$ is.

We may reduce the redundancy of parentheses by introducing _semantics_ to formulae. We assign
meaning to each symbol in order to provide a sensical heirarchy of connectives.

#table(
  columns: (auto, auto, auto),
  table.header[Operator][Semantic Meaning][Order],
  $<->$, "biconditional", $3$,
  $->$, [conditional
    #footnote[Here, we call the left operand the _antecedent_, and the right operand the _consequent_.]
  ], $3$,
  $and$, "conjunction/and", $2$,
  $or$, "disjunction/or", $2$,
  $not$, "negation/not", $1$,
  $()$, "", $0$,
)


Here, the highest order connective will implicitly become the main connective. So, in a formula such
as $P and not Q -> R$, we may read off $->$ as the main connective. 

We may further simplify formulae by asserting that $and$ and $or$
are associative (indeed, in common language they are). Thus, there is no need for parentheses in chains of $P and Q and ... $ and $P or Q or ...$
_The main connective will be interpreted as the right-most operand in these chains._

Using these rules, we may take some otherwise ambiguous formulae and parse them as we would
well-formed formulae. It is worth noting that this does not cause _all_ conceivable formulae to be parseable. For instance, $P and Q or R$
still does not make sense. Indeed, any formula containing a level
with two (non-associative) connectives of the same order cannot be parsed into a well-formed formula.

#definition[official notation][
  A formula $phi$ is in _official notation_ when $phi in cal(W)$. We say $phi$ is instead in _informal_ notation when
  $phi in.not cal(W)$ but
  + $phi$ contains no parentheses around unary connectives or propositional variables; and
  + $phi$ can be parsed into a WFF by the heirarchy of connectives and associativity of $and$ and $or$.
  In this case, we also say $phi$ is a _well-formed symbolic sentence_.
]

_Example._ We may simplify the formula $(((P and Q) and R) and S)$ to $P and Q and R and S$ by associativity.

_Example._ The formula $Q  -> R -> S$ is not well formed.

#note[][
  From this point forward, all references to any formula $phi$ will assume that $phi$ is parseable,
  so that it is by extension either in official notation or in informal notation.
]

== Truth Tables
We consider a formula's semantics to be defined when the formula has a truth value associated to each combination of truth values 
assigned to its propositional variables.

#definition[truth value assignment (TVA)][
  A _truth value assignment_ to a formula $phi$ is an assignment of truth values to the atomic statements, or propositional variables, of $phi$.
  It corresponds to a single row in the truth table of $phi$.
]

#definition[truth table][
  The _truth table_ for a formula $phi$ is a table listing all TVAs of $phi$, along with the truth value of $phi$ for each TVA.
]

#theorem[][There exist $2^n$ possible TVAs for a formula composed of $n$ propositional variables.]

In discussing truth tables, we now see that formulae are truth-apt and therefore sentences. We may therefore
translate our prior definitions for statements. If $phi$ is a formula, then
- $phi$ is a _tautology_ if $phi$ is true on every TVA
- $phi$ is a _contradiction_ if $phi$ is false on every TVA
- $phi$ is _contingent_ if there exists a TVA for which $phi$ is true, and a TVA for which $phi$ is false.
In fact, because statements are by definition truth-apt, they have corresponding truth tables in some collection
of propositional variables. It can be shown (via CNF/DNF, for instance) that for every truth table $T$ there exists a formula satisfying $T$.
From this it is clear that all statements are also formulae. _With this we have established an equivalence between statements and formulae._

#definition[consistency][
  A set of statements ${phi, psi, ...}$ is _consistent_ when there is at least one TVA
  for which all statements in the set are true. The set is _inconsistent_ otherwise.
]

#definition[logical equivalence][
  The statements in a set ${phi, psi, ...}$ of statements are _logically equivalent_ when every statement has the 
  same truth value on each TVA. That is, when the truth tables for all statements are equal.
]

We may thus translate our notions of _validity_ also. Recall that an argument $A$ is a collection of statements. We say $A$ is valid when, for each TVA where all premises are true, the conclusion is true.

#note[notation][
  When a valid argument is composed of premise statements $phi, psi, ..., zeta$ and a conclusion $cal(C)$, we denote the argument by $phi . psi. ... zeta .  therefore cal(C)$. The $therefore$ symbol is read as "therefore." This is equivalent
  to writing $phi and psi and ... and zeta => cal(C)$.
  #footnote[
    Note that this is _different_ from writing $phi and psi and ... and zeta -> cal(C)$. This latter expression is a formula and has its own truth table. It may or may not be the case that the formula evaluates to true
    for every TVA. However, when writing $phi and psi and ... and zeta => cal(C)$ or $phi . psi . ... zeta . therefore cal(C)$, we are asserting that this argument is valid with certainty, and so the above formula _does_ evaluate to true for every TVA.
  ]
]

#pagebreak()
= Symbolization

= Derivations in Sentential Logic

= Single-Place Symbolization in Predicate Logic

= Single-Place Derivations in Predicate Logic

= Multi-Place Symbolization in Predicate Logic

= Multi-Place Derivations in Predicate Logic

= Semantics in Predicate Logic
