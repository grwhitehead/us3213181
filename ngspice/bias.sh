if [ "$#" -ne 1 ]; then
  echo "Usage: $0 circuit" >&2
  exit 1
fi

ngspice -b $1-bias.cir

