BEGIN {f="parole-test.txt";while((getline l<f)>0)p=(p RS l);split(p,a)} {RS="";FS=".";for(e in a)if($0~a[e])v[e]=(a[e]".txt "$1);asort(v);for(e in v)print v[e]}
BEGIN {RS=""} {for(i=0;i<NR;i++)a[$1]=$0} END {for(e in a)print a[e]"\n"}
