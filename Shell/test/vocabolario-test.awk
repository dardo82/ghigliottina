BEGIN{wf="parole.txt";while((getline l<wf)>0)s=(s RS l);split(s,wa);RS="";FS="."}{for(i in wa)if($0~wa[i])print $1>>("parole/"wa[i]"-awk.txt")}
