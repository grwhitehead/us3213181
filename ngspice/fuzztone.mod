.subckt fuzztone in out att=0.99 vol=0.99 r19=10k r26=1.5k r35=10k

* calculated bias adjustments for 20C (no significant performance improvement)
*.subckt fuzztone in out att=0.99 vol=0.99 r19=10k r26=1.8k r35=7.9k

*-------------------------------------------------
*  2N270 Spice model
*  Germanium PNP transistor in TO-7 metal case
*  Copyright (c) 2021 by Gert Willmann
*-------------------------------------------------
.model 2N270 pnp (
+  is=24.3u
+  bf=172 nf=1.055 vaf=25 ikf=0.143 ise=2.57u ne=1.99
+  br=17.2 nr=1.055 var=25 ikr=0.143 isc=8.35u nc=1.7
+  rc=0.843 re=0.172 rb=308 rbm=26.8 irb=0.686m
+  cje=110p vje=0.3 mje=0.5
+  cjc=183p vjc=0.3 mjc=0.5
+  tf=156n tr=1560n
+  eg=0.67 xti=9.32 xtb=1.5 fc=0.5
+  kf=6.6f af=1
+  tnom=25 )

R14 in 1 100k
C15 1 2 0.01u
R20 2 0 1meg

Q16 4 2 3 2N270

*R19 3 0 10k
R19 3 0 {r19}
C24 3 5 20u

*R261 4 5 470
R261 4 5 470k
R29 5 6 2.2k
R30 6 0 22k
R12 6 0 {att*50k}

Q25 7 5 0 2N270

*R26 4 7 1.5k
R26 4 7 {r26}
C31 7 8 20u
R33 8 0 10k

Q32 9 8 0 2N270

*R35 4 9 10k
R35 4 9 {r35}
C37 9 10 0.0033u
R38 10 0 56k

R11a 10 out {(1-vol)*500k}
R11b out 0 {vol*500k}

Vbatt 0 4 DC 3.1

.ends fuzztone
