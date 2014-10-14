#!/bin/zsh
LC_ALL="C"; PTD="parole-test"; PTT="parole-test.txt"
for f in $PTD/*.txt; do for p in $(cat $PTT); do if [ "$(grep -F ${${f##*/}:r} $PTD/${p:l}.txt)" ]; then echo $p>>$f; fi; done; done 
