
# General

Published as "Dynamical Stability of Quantum Algorithms". Dissertation, ISBN:0-493-13630-4. The University of Texas at Austin. 2000.


# Building

The `Makefile` says most of it... lots of deps.  And it's, ahem, slow.

First, from the toplevel:

    export TEXINPUTS=.:./macros:
    make main.dvi
    make main.dvi
    make main.pdf

multiple times just to resolve citations, indices, etc.

