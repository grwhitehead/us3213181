#!/usr/bin/env python3
#coding: utf-8

import sys
import csv
import numpy as np
import matplotlib.pyplot as plt

figure1 = plt.figure(1, (20, 10))
plt.title('Fuzz Tone Output')
plt.xlabel('Freq [Hz]')
plt.ylabel('Power [$V^2$]')
plt.grid()

fname = sys.argv[2]
f = open(fname, 'r')
fdata = list(csv.reader(f, delimiter=' ', skipinitialspace='true'))

rate = 44100
bins = np.fft.rfft([float(s[1]) for s in fdata], rate)
frqs = np.linspace(0, rate/2, len(bins))
bpwr = np.abs((bins/rate)**2)*2
plt.plot(frqs, bpwr)

if len(sys.argv) > 3:
    ffrq = float(sys.argv[3])

    ffrqi = 0
    for i in range(len(frqs)):
        if ffrq < frqs[i]:
            ffrqi = i-1
            break

    ax1 = figure1.axes[0]
    ax1.annotate('{:.0f} Hz'.format(frqs[ffrqi]),
                 xy=(frqs[ffrqi], bpwr[ffrqi]), xycoords='data',
                 xytext=(0, 0), textcoords='offset points',
                 horizontalalignment='center', verticalalignment='bottom')

    if False:
        for i in range(ffrqi*2,len(bpwr),ffrqi):
            if bpwr[i] > bpwr[ffrqi]/1000:
                ax1.annotate('{:d}x'.format(int(i/ffrqi)),
                             xy=(frqs[i], bpwr[i]), xycoords='data',
                             xytext=(0, 0), textcoords='offset points',
                             horizontalalignment='center', verticalalignment='bottom')
            
    hpsum = 0
    for hi in range(ffrqi*2,len(bpwr),ffrqi):
        hpsum = hpsum + bpwr[hi]
    thd = 100*np.sqrt(hpsum/bpwr[ffrqi])

    bbox_props = dict(boxstyle="round", fc="w", pad=1)
    ax1.annotate('Total Harmonic Distortion %{:.2f}'.format(thd),
                 xy=(.5, .95), xycoords='axes fraction',
                 horizontalalignment='center', verticalalignment='top',
                 fontsize=12, bbox=bbox_props)

plt.tight_layout()

plt.savefig(sys.argv[1]);
