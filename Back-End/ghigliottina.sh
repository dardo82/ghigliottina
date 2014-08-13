#! /bin/sh

export DICT="vocabolario.txt" SOL="soluzione.txt" TEMP="temporaneo.txt" HINTS="indizi.txt"

function search {
 for arg in $*; do
  if [ $(gawk -v RS="\n\n" 'END{print NR}' $DICT) -gt 1 ]; then
   gawk -v arg="$arg" -v RS="\n\n" -v ORS="\n\n" '{if ($0~arg) print $0}' $DICT > $SOL
   cp $SOL $TEMP; DICT="$TEMP"
  fi
 done
}
function hints {
 for arg in $*; do
  gawk -v txt="$arg.txt" -v RS="\n\n" '{if ($0~txt) print $0}' $DICT >> $HINTS
 done
}
function solve {
 gawk -v arg="$1" -v RS="\n\n" '{sub(/\.txt/,"");if ($0~arg) print $1}' $HINTS
}
function output {
OUT="$OUT $(gawk -v RS="\n\n" '{sub(/\.txt/,"");print $1}' $1)"
}

argv=`echo $* | gawk '{print tolower($0)}'`
hints $argv
search $argv
if [ -s "$SOL" ]; then
 output $SOL
 echo "$OUT"
else
 TEST="1"
 for arg in "$argv"; do
  search ${argv/$arg/}
  if [ -s "$SOL" ]; then
   output $SOL
  fi
 done
fi
if [ -n "$TEST" ]; then
 for arg in "$OUT"; do
  if [ "$(echo $(solve $arg))" == "$argv" ]; then
   echo "$arg"
  fi
 done
fi
rm $HINTS $TEMP $SOL

