novoalignHadoopStreaming
========================

Synopsis
----------
Run Novoalign using Hadoop Streaming. The hadoop software stack is widely used for big data analysis. In bioinformatics and next-generation sequencing (NGS) there is however the potential to use existing software to distribute 
using the hadoop streaming mechanism.
A collection of SAM alignment files are produced by this script and these can be further processed by HadoopBAM to make BAM files for further analysis.

Requirements
-------------------------

1) A working hadoop cluster. For human-genome sized alignments you will need hadoop streaming to run large memory jobs, typically above 6Gb.
2) Download novoalign and request free  trial license from www.novocraft.com. See the [release notes] (http://www.novocraft.com/wiki/tiki-view_forum_thread.php?comments_parentId=843)

Note well: requires V3.03.00 or higher


Usage
---------------------------


```sh
./novoalign_mapRed.sh reads.tsv database.nix alignment_out novoalign.lic
```

All locations are in HDFS. Therefore novoindex your genome before loading into HDFS.
Novoalign.lic is the novoalign license file

Note that the novohadoop.jar is required. This jar is an archive of the executables of 

1. novoalign
2. samtools
3. align.cmd (the mapper for mapreduce)


Configuration
-------------
Set the $HADOOP_STREAMING variable in the shell script to it's location on your hadoop cluster.
Upload the jar in this repo or your own to HDFS and set it's location in the script


Building your  own jars
-----------------------


An example of buildin your own jar is given below:

```sh
jar -cf novohadoop.jar align.cmd novoalign samtools Align.pl  novosort novoindex vcfutils.pl
```


Creating input reads in TSV format
----------------------------------
Jnomics may be used for this. Also a simple perl program in scripts/ is included.

1. Copy all TSV files to HDFS.
