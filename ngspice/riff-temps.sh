SPICE_AUDIO_TOOLS=../../spice-audio-tools

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 circuit" >&2
  exit 1
fi

mkdir -p data

AMP=0.28
${SPICE_AUDIO_TOOLS}/wavtospice.py --vrange ${AMP} ../audio/riff.wav data/riff
ngspice -b $1-riff-temps.cir
for TEMP in 10 20 30 40; do
  ${SPICE_AUDIO_TOOLS}/spicetowav.py data/temp_${TEMP}-riff-$1 ../audio/temp_${TEMP}-riff-amp_${AMP}-$1.wav
done
