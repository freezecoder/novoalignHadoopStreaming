
./elastic-mapreduce --create --name "NovoTest Clustert" --ami-version latest --num-instances 2 --instance-type m1.small \
--stream  1 --jobconf  mapred.reduce.tasks=0 \
--jobconf  mapred.map.tasks=10 \
--input   s3n://yours3path/inreads.tsv \
--output  s3n://yours3path/testout001  \
--mapper     'perl Align.pl -database db.nix -prog ./novoalign '  \
--cache  "s3n://novoindexes/ecoli/ecoli.nix#db.nix,s3n://path_to_your/novoocraft/novoalign#novoalign,s3n://path_to_your/novocraft/samtools#samtools,s3n://path_to_your/novocraft/Align.pl#Align.pl,s3n://path_to_your/novocraft/novoalign.lic#novoalign.lic"

