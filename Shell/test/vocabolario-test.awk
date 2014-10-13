BEGIN {f="parole-test.txt";while((getline l<f)>0)a[i]=l;i++} {RS="";FS=".";for(e in a)if($0~a[e])print a[e]".txt "$1}
BEGIN {RS=""} {for(i=0;i<NR;i++)a[$1]=$0} END {for(e in a)print a[e]"\n"}
