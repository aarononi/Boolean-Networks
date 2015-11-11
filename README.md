# Boolean-Networks

This Perl program generates a random boolean network synchronously from user inputted parameters such as number of genes (nodes n), number of regulatory genes (variables k), number of states (states s) and an initial state that is either generated randomly or given as user input. Each node in the network can be in one of two states: on or off represented by 1 or 0 respectively. Time is represented as proceeding in discrete iterations, incrementing through states s. At each step, the new state of a node is obtained from a randomly generated function that uses logical operators. The output is a (s, n) matrix representing the state trajectory. The program provides additional information about the network such as point or cycle attractors, and corresponding basin states and transient time. Output can be written to a file or printed to the command line depending on initial user specifications.

Sample Input and Output

Number of genes (g)
10
Number of variables (k) to be the regulatory function for gene g
4
Number of states
10
Select initial state? [Y/N] (if N initial state will be random)
Y
Enter initial state (10 binary digits)
1, 0, 1, 1, 1, 0, 0, 1, 0, 1
Name of boolean network?
Human Genes
Write to file? [Y/N]
N

Human Genes (10-4 Boolean network)
State space = 1024

Regulatory functions
g'0 = ~g4 ^ g6 v ~g8 ^ ~g0
g'1 = g3 ^ ~g9 v g0 ^ ~g4
g'2 = g3 ^ ~g6 v g2 v ~g0
g'3 = g1 v g9 v ~g0 v g6
g'4 = ~g8 ^ ~g5 v g6 ^ g1
g'5 = g9 ^ ~g7 ^ g8 v ~g2
g'6 = g6 ^ ~g8 ^ ~g9 v g1
g'7 = ~g5 ^ ~g0 ^ ~g4 v g1
g'8 = g9 ^ g0 v ~g6 ^ ~g5
g'9 = ~g0 ^ g1 v ~g3 v ~g9

State    g0    g1    g2    g3    g4    g5    g6    g7    g8    g9
0    1    0    1    1    1    0    0    1    0    1
1    1    0    1    1    1    0    1    1    1    1
2    0    0    1    1    1    0    1    1    1    1
3    0    0    1    1    1    0    1    1    0    0
4    1    1    1    1    1    0    1    1    0    1
5    0    0    1    1    1    0    1    1    1    0
6    0    1    1    1    1    0    1    1    0    1
7    1    0    1    1    1    0    1    1    0    1
8    0    0    1    1    1    0    1    1    1    1
9    0    0    1    1    1    0    1    1    0    0
10    1    1    1    1    1    0    1    1    0    1

Basin states from 0 to 1
Cycle attractor of 6 iterations starting at state 2
Transient time of 2 iterations

Run again? [Y/N]
n
