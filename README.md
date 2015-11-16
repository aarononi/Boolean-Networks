# Random Boolean Networks using rbn.pl

This Perl program generates a random boolean network synchronously from user inputted parameters such as number of genes (nodes n), number of regulatory genes (variables k), number of states (states s) and an initial state that is either generated randomly or given as user input. Each node in the network can be in one of two states: on or off represented by 1 or 0 respectively. Time is represented as proceeding in discrete iterations, incrementing through states s. At each step, the new state of a node is obtained from a randomly generated function that uses logical operators. The output is a (s, n) matrix representing the state trajectory. The program provides additional information about the network such as point or cycle attractors, and corresponding basin states and transient time. Output can be written to a file or printed to the command line depending on initial user specifications.

Since the network uses logical operators to define functions it is deterministic with a finite state space and will therefore fall into a cycle irrespective of the initial state.

Some examples and anomolies:

(10-2 Boolean network)
State space = 1024

Regulatory functions
g'0 = g6 OR g8
g'1 = g3 NAND ~g1
g'2 = ~g0 OR g5
g'3 = g5 NOR ~g2
g'4 = g0 AND g9
g'5 = ~g6 XNOR ~g1
g'6 = g1 AND ~g2
g'7 = ~g9 NAND g1
g'8 = g3 XNOR g6
g'9 = ~g3 XNOR ~g5

State	g0	g1	g2	g3	g4	g5	g6	g7	g8	g9
0		0	0	1	0	0	0	1	0	0	1
1		1	1	1	1	0	0	0	0	0	0
2		0	1	0	1	0	0	0	0	1	1
3		1	1	1	1	0	0	1	1	1	1
4		1	1	0	1	1	1	0	1	1	1
5		1	1	1	0	1	0	1	1	1	1
6		1	1	0	1	1	1	0	1	0	0
7		0	1	1	0	0	0	1	0	1	1
8		1	1	1	1	0	1	0	1	0	0
9		0	1	1	0	0	0	0	0	1	1
10	1	1	1	1	0	0	0	1	0	0

No attractors found within 10 iteration(s)

************************************************

(10-10 Boolean network)
State space = 1024

Regulatory functions
g'0 = g1 OR g5 NOR g4 NOR g6 AND ~g8 NAND ~g7 AND g3 XNOR g0 NOR g9 XOR ~g2
g'1 = g0 OR g6 XNOR ~g5 NOR ~g3 XOR g2 OR g9 NOR g1 XNOR ~g7 AND g8 NAND g4
g'2 = g8 NOR ~g4 XNOR g2 XNOR g5 OR g3 AND ~g6 NOR g9 XOR g1 OR ~g0 NOR ~g7
g'3 = ~g1 NAND ~g6 NOR g2 XOR ~g4 AND g9 NAND g7 AND ~g0 XNOR g5 XOR ~g8 NOR ~g3
g'4 = ~g7 XNOR ~g1 NOR ~g6 OR g0 AND ~g3 NAND g8 XOR ~g4 AND g5 NOR ~g9 NAND g2
g'5 = g3 NAND ~g0 XNOR g6 NAND ~g1 XNOR ~g5 NOR g2 NAND ~g7 NAND ~g4 NAND ~g8 OR g9
g'6 = g3 XOR g7 NOR ~g2 NAND g8 NAND g4 XNOR g6 NOR ~g0 NOR g1 XOR ~g9 NOR ~g5
g'7 = ~g8 NAND g3 AND g1 XOR g0 XNOR ~g7 OR g4 OR ~g9 AND ~g5 XOR g6 OR g2
g'8 = ~g1 XOR ~g3 XOR g0 XNOR ~g5 XOR ~g6 XOR g4 AND g9 AND g2 XOR g8 XOR ~g7
g'9 = g0 XNOR g7 AND ~g8 OR ~g6 XOR g3 XNOR ~g5 NAND ~g4 NOR ~g1 OR ~g9 XNOR ~g2

State	g0	g1	g2	g3	g4	g5	g6	g7	g8	g9
0		0	1	1	1	1	1	0	1	0	1
1		1	0	1	0	0	1	1	1	0	1
2		1	1	0	0	1	1	1	1	0	1
3		1	1	0	0	1	1	0	1	1	1
4		1	1	0	0	0	1	0	1	1	1
5		1	1	0	0	0	1	0	1	1	1
6		1	1	0	0	0	1	0	1	1	1
7		1	1	0	0	0	1	0	1	1	1
8		1	1	0	0	0	1	0	1	1	1
9		1	1	0	0	0	1	0	1	1	1
10	1	1	0	0	0	1	0	1	1	1

Basin states from 0 to 3
Point attractor starting at state 4
Transient time of 4 iterations
