#!/bin/sh

#Novoalign script for MapReduce streaming with Hadoop
#Requires working hadoop cluster
#Each process requires large mem i.e. > 8gb per map job for human genome sized runs
#be sure to set $HADOOP_STREAMING variable to your streaming.jar location
# Usage:   $0 reads.tsv novoindex(hdfs) outdir(hdfs)

HADOOP_STREAMING="/path/to/streaming.jar"

#location of exes
#You may create your own jars using jar -cf
#This is HDS location of the jar 
# use "hadoop fs -copyFromLocal src dest" to install this file in HDFS

PACKAGE="novohadoop.jar"


jobname="NovoalignPairedEnd"

if [ $# -lt 3 ];then
	echo "$0 hdfs-inputreads.tsv hdfs-ref.novoindex hdfs-outdir"
	echo "Note: Input PE reads are TSV : readname seq1 qual1 seq2 qual2, SE reads are readname read1 qual1"
	exit
fi

input=$1
reference=$2
outdir=$3

#Hadoop Mapreduce memory
#This is set for Human-genome, set lower for smaller ref. genomes
MEM=13400
HEAP="12g"

echo "-------- `date` MapReduce Job Novoalign -----------------------"
echo "Map Tasks set: $MAPS"
echo "Out prefix: $outdir"
echo Input File in HDFS = $input
echo Map Mem= $MEM, HEAP is $HEAP
echo Reference index in HDFS = $reference

#set links to programs already in HDFS
cachefiles="-cacheArchive $PACKAGE#bin "
#HDFS location of your reference genome
arch="-cacheFile $reference#genome.inx"

#output directory spec
rawsam="$outdir"

echo INFO `date` Beginning Alignment

hadoop fs -rm -r $rawsam

mapper="./bin/aligner.cmd"

#	-D mapreduce.job.maps=$MAPS \
jobname=`basename $outdir`".align$MAPS"
echo hadoop jar $HADOOP_STREAMING  \
	-D mapreduce.job.reduces=0 \
	-D mapreduce.map.memory.mb=$MEM \
	-D mapreduce.map.java.opts=-Xmx$HEAP \
	-input $input  \
	-file novoalign.lic  \	
	$cachefiles \
	$arch  \
	-output  $rawsam  \
	-mapper  \' $mapper \' \
	-jobconf mapreduce.job.name=${jobname} | bash

echo INFO `date` Aligment complete
