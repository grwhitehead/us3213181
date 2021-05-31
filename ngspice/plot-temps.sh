SPICE_AUDIO_TOOLS=../../spice-audio-tools

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 circuit" >&2
  exit 1
fi

mkdir -p data

ngspice -b $1-plot-temps.cir

for TEMP in 10 20 30 40; do
    for FRQ in 220; do
        for AMP in 0.14; do
            for ATT in 0.01 0.99; do
                ./plotoutput.py ../plots/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output.png data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-input data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output
                ./plotoutput.py ../plots/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-abcd.png data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-a data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-b data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-c data/temp_${TEMP}-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-d
            done
        done
    done
done

for FRQ in 220; do
    for AMP in 0.14; do
        for ATT in 0.01 0.99; do
            ./plotoutput.py ../plots/temps-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output.png data/temp_10-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output data/temp_20-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output data/temp_30-sin_${FRQ}-amp_${AMP}-$1-att_${ATT}-output
        done
    done
done
