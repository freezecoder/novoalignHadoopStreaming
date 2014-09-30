#!/usr/bin/perl

#Novoalign Mapper for Hadoop
##write SAM with headers as text
#mapreduce hadoop
use POSIX q/strftime/;
use Getopt::Long;

#novo index
my $index;
my $aligner;
my $fasta;
my $onlybam;
my $opts="";
my $is_paired=0;
my $cores;
my $removeun;
my $noheader;
$removeun=1;
my $d="novocloud/novocraft";
&GetOptions(
	'paired!'=>\$is_paired,
	'database|reference=s'=>\$index,
	'prog=s'=>\$aligner,
	'bam!'=>\$onlybam,
	'cores=s'=>\$cores,
	'removeunmapped!'=>\$removeun,
	'raw!'=>\$noheader,
);
print STDERR "$0 started\n ";
my $counter = strftime( q/%Y%m%dT%H%M%S/, localtime());
#if remove unmapped reads is true
system("chmod a+x $d/novoalign ; chmod a+x $d/samtools");
if  ($removeun) {
	open(F,"| $d/novoalign  $opts -d $index -F TSV -f - -oSAM -k -rRandom | $d/samtools view -S -F 4 -h -") or die "$!";
}else {
	open(F,"| $d/$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom | $d/samtools view -S -h -") or die "$!";
}
while (<>) {
	s/^\@//; #strip off leading @ character that messses up file format
	print F $_;
	$c++;
}
close F;
print STDERR "$0:\t$c records processed\n";
exit 0;

