novoalignHadoopStreaming
========================

Synopsis
----------
Run Novoalign using Hadoop Streaming

Requirements
-------------------------

1) A working hadoop cluster. For human-genome sized alignments you will need hadoop streaming to run large memory jobs, typically above 6Gb.

2) Download novoalign and request free  trial license from www.novocraft.com

Note well: requires V3.03.00 or higher


Usage
---------------------------

All locations are in HDFS



```sh
novoalign_mapRed.sh reads.tsv database.nix alignment_out novoalign.lic
```


Novoalign.lic is the novoalign license file

Note that the novohadoop.jar is required. This jar is an archive of the executables of 

1) novoalign
2) samtools
3) align.cmd (the mapper for mapreduce)


Building your  own jars
-----------------------


An example of buildin your own jar is given below:

```sh
jar -cf novohadoop.jar align.cmd novoalign samtools Align.pl  novosort novoindex vcfutils.pl
```
