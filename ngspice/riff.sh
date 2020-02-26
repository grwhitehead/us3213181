SPICE_AUDIO_TOOLS=../../spice-audio-tools

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 circuit" >&2
  exit 1
fi

mkdir -p data

AMP=0.28
${SPICE_AUDIO_TOOLS}/wavtospice.py --vrange ${AMP} ../audio/riff.wav data/riff
ngspice -b $1-riff.cir
${SPICE_AUDIO_TOOLS}/spicetowav.py data/riff-$1 ../audio/riff-amp_${AMP}-$1.wav
