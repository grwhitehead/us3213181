.subckt fuzztone in out att=0.99 vol=0.99 r19=7k r29=1.4k r33=3k

* B. Holmes, M. Holters, M. van Walstijn. “Comparison of Germanium Bipolar Junction Transistor Models for Real-Time Circuit Simulation”, Proceedings of the 20th International Conference on Digital Audio Effects, Edinburgh, Scotland, Sept. 2017
.MODEL AC128 PNP(IS=20.66u BF=229.6 BR=14.66 NF=1.133 NR=1.140 VT=25.5m VAF=19.68 VAR=88.28 IKF=463.0m IKR=241.5m ISE=2.190u ISC=7.546u NE=1.796 NC=1.364 RB=1.885 RE=306.4m RC=1.727u CCB=100p)

R14 in 1 100k
C15 1 2 0.01u
R20 2 0 1meg

Q16 4 2 3 AC128

*R19 3 0 10k
R19 3 0 {r19}
C24 3 5 20u

*R261 4 5 470
R261 4 5 470k
*R29 5 6 2.2k
R29 5 6 {r29}
R30 6 0 22k
R12 6 0 {att*50k}

Q25 7 5 0 AC128

R26 4 7 1.5k
C31 7 8 20u
*R33 8 0 10k
R33 8 0 {r33}

Q32 9 8 0 AC128

R35 4 9 10k
C37 9 10 0.0033u
R38 10 0 56k

R11a 10 out {(1-vol)*500k}
R11b out 0 {vol*500k}

Vbatt 0 4 DC 3.1

.ends fuzztone
