BEGIN {f="parole-test.txt";while((getline l<f)>0)a[i]=l;i++} {RS="";FS=".";for(e in a)if($0~a[e])print a[e]".txt "$1}
