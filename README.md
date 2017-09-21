# LCG Reasoning

First version of SLCG Reasoning

## Acknowledgement

This project takes the advantage of the open source code `dot_to_graph.m` Copyright (c) 2009, Leonid Peshkin.

## Running

Run `SLCGmain.m` for single reachability checking, with `LCG1~5` the small models in the paper *A Heuristic for Reachability Problem in Asynchronous Binary Automata Networks* and `LCG1~5.dot` the corresponding LCG figures. `phageLambda.an` is an example of 4 components and 12 transitions. In `Pint`, *cro=0* is **inconclusive** while we find it reachable and the corresponding sequence to reach the goal. 

Run `SLCGtest.m` for speed test, check the reachability of 40 instances in TCR and 98304 in EGFR.

## Contact

If you have any questions, do not hesitate to contact xinwei.chai@ls2n.fr.
