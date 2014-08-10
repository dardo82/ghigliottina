#! /bin/zsh

function search {
 DICT="vocabolario.txt"; SOL="soluzione.txt"; TMP="temporaneo.txt"
 for arg in $*; do
  if [ $(gawk -v RS="\n\n" 'END{print NR}' $DICT) -gt 1 ]; then
   gawk -v arg="$arg" 'BEGIN{ORS=RS="\n\n"} {if ($0~arg) print $0}' $DICT > $SOL
   cp $SOL $TMP; DICT="$TMP"
  fi
 done
}
function hints {
 DICT="vocabolario.txt"; HINTS="indizi.txt"
 for arg in $*; do
  gawk -v txt="$arg.txt" -v RS="\n\n" '{if ($0~txt) print $0}' $DICT >> $HINTS
 done
}
function solve {
 HINTS="indizi.txt"
 gawk -v arg="$1" -v RS="\n\n" '{sub(/\.txt/,"");if ($0~arg) print $1}' $HINTS
}
function output {
 OUT="$OUT $(gawk -v RS="\n\n" '{sub(/\.txt/,"");print $1}' $1)"
}

argv=${*:l}
hints $argv
search $argv
if [ -s $SOL ]; then
 output $SOL
 echo $OUT
else
 TEST="1"
 for arg in $argv; do
  search ${argv/$arg/}
  if [ -s $SOL ]; then
   output $SOL
  fi
 done
fi
if [ "$TEST" ]; then
 for arg in $OUT; do
  if [ "$(echo $(solve $arg))" == "$argv" ]; then
   echo $arg
  fi
 done
fi
rm $HINTS $TMP $SOL
