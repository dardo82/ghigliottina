#!/bin/zsh
function search {
awk -v RS="" "/${1// //&&/}/"'{sub(/.txt/,"");print $1}' $2
}
eval LAST=\${$#}
if [ "${LAST:e}" = "txt" ]; then
    ARGV=${${*:l}/$LAST/}; DICT="$LAST"
else
    ARGV=${*:l}; DICT="vocabolario.txt"
fi
SOL=$(search $ARGV $DICT)
if [ "$SOL" ]; then
    echo "$SOL"
else
    for arg in ${=ARGV}; do
        SOL=$(search ${ARGV/$arg/} $DICT)
        if [ "$SOL" ]; then
            echo "$SOL"
        fi
    done
fi
