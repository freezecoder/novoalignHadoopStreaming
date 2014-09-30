
./elastic-mapreduce --create --name "NovoTest Clustert" --ami-version latest --num-instances 2 --instance-type m1.small \
--stream  1 --jobconf  mapred.reduce.tasks=0 \
--jobconf  mapred.map.tasks=10 \
--input   s3n://yours3path/inreads.tsv \
--output  s3n://yours3path/testout001  \
--mapper     'perl Align.pl -database db.nix '  \
--cache  "s3n://novoindexes/ecoli/ecoli.nix#db.nix,s3n://codev1/novocloud/novoocraft/novoalign#novoalign,s3n://codev1/novocloud/novocraft/samtools#samtools,s3n://codev1/novocloud/novocraft/Align.pl#Align.pl,s3n://codev1/novocloud/novocraft/novoalign.lic#novoalign.lic"

