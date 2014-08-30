#!/bin/zsh

export DICT="vocabolario.txt" SOL="soluzione.txt" TEMP="temporaneo.txt" HINTS="indizi.txt"

function search {
 for arg in ${=*}; do
  if [ $(awk -v RS="" 'END{print NR}' $DICT) -gt 1 ]; then
   awk -v arg="$arg" -v RS="" -v ORS="\n\n" '{if ($0~arg) print $0}' $DICT > $SOL
   cp $SOL $TEMP; DICT="$TEMP"
  fi
 done
}
function hints {
 for arg in ${=*}; do
  awk -v txt="$arg.txt" -v RS="" '{if ($0~txt) print $0}' $DICT >> $HINTS
 done
}
function solve {
 awk -v arg="$1" -v RS="" '{sub(/\.txt/,"");if ($0~arg) print $1}' $HINTS
}
function output {
OUT="$OUT $(awk -v RS="" '{sub(/\.txt/,"");print $1}' $1)"
}

argv=${*:l}
hints $argv
search $argv
if [ -s "$SOL" ]; then
 output $SOL
 echo ${OUT:1}
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
   echo ${arg:1}
  fi
 done
fi
rm $SOL $TEMP $HINTS

