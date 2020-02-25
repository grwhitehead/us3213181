SPICE_AUDIO_TOOLS=../../spice-audio-tools

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 circuit" >&2
  exit 1
fi

ngspice -b $1-plot.cir

for FRQ in 110 220 440; do
    for AMP in 0.14; do
        for ATT in 0.01 0.99; do
            ./plotoutput.py ../plots/sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output.png sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-input sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output
            ./plotoutput.py ../plots/sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-abcd.png sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-a sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-b sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-c sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-d
        done
    done
done

for FRQ in 110 220 440; do
    for ATT in 0.01 0.99; do
        ./plotoutput.py ../plots/sin_${FRQ}-amps-$1-att_${ATT}-output.png sin_${FRQ}-amp_0.14-$1-att_${ATT}-output sin_${FRQ}-amp_0.28-$1-att_${ATT}-output sin_${FRQ}-amp_0.56-$1-att_${ATT}-output
    done
done

for FRQ in 110 220 440; do
    for AMP in 0.14; do
        for ATT in 0.01 0.10 0.99; do
            ./plotspectrum.py ../plots/sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-spectrum.png sin_${FRQ}-amp_${AMP}-$1-att_${ATT} ${FRQ}
            ${SPICE_AUDIO_TOOLS}/spicetowav.py sin_${FRQ}-amp_${AMP}-$1-att_${ATT} ../audio/sin_${FRQ}-amp_${AMP}-$1-att_${ATT}.wav
        done
    done
done
