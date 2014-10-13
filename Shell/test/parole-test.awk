#! /usr/bin/env gawk -f

BEGIN {
    RS="==="
}
NR<8 && /\[\[|\]\]/ {
    gsub (/\[|\]/,"")
    for (i=1; i<=n; i++) \
        m[i,NR]=$i
}
END {
    for (i=1; i<=n; i++) \
        for (j=1; j<=NR; j++) \
            a[(i-1)*n+j]=m[i,j]
    asort (a)
    for (e in a) \
        if (length (a[e]) >1) \
            print a[e]
}

