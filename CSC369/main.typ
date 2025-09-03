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
  *CSC369 Notes* 
])
#align(center, text(14pt)[
  Autumn 2025 \
  Stefan Barna
])
#linebreak()

#outline()
#linebreak()

= Operating Systems

#definition[operating system][
  An _operating system_ (OS) is a system software that manages a computer's resources for its users and their applications.
  The operating system provides an interface that that abstracts the details of accessing and managing hardware. 
  This interface typically comes as a collection of _system calls_, and is often referred to as the _standard library_.
]

Applications run in _user mode_ by default, within which hardware will restrict the set of possible actions. When a system call
is made (typically via the _trap_ hardware instruction), the hardware transfers control to a _trap handler_ and simultaneously 
raises the hardware privilege level to _kernel mode_, within which the OS has full access to the hardware of the system and thus
may initiate I/O requests or make more memory available to a process. When the OS is done servicing the request, it returns 
control to the user via a _return-from-trap_ instruction, which reverts to user mode while simultaneously passing control back 
to where the application left off.

Operating systems use _virtualization_ to produce an illusion of nearly unlimited resources.
Resources refer to physical or virtual components that a computer system uses to perform tasks, such as
CPU, memory, storage, and other devices. Hence, we often refer to the OS as a _resource manager_.
The virtualization of memory, for instance, involves introducing an address space.

#definition[address space][
  A _(virtual) address space_ is the range of memory addresses that an operating system allocates to a process, enabling it
  to access memory independently of the underlying physical memory layout. This abstraction allows each process to operate
  as though it has its own private memory space, typically beginning at address `0x0000`.
  #footnote[This means we may have a collection of processes allocating memory at the same address without interference!]
]

The objective of a good operating system is to act as a resource manager while isolating processes and providing a high
degree of reliability.
