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
&GetOptions(
	'paired!'=>\$is_paired,
	'reference=s'=>\$index,
	'prog=s'=>\$aligner,
	'bam!'=>\$onlybam,
	'cores=s'=>\$cores,
	'removeunmapped!'=>\$removeun,
	'raw!'=>\$noheader,
);
print STDERR "$0 started\n ";
print STDERR "Removing unmapped reads from Novoalign\n" if $removeun;
unless ($aligner) {
	print STDERR "No aligner found $aligner";
	exit 123;
}
my $counter = strftime( q/%Y%m%dT%H%M%S/, localtime());
print STDERR "Indexing done, Now Aligning to reference $index\n";
#if remove unmapped reads is true
if  ($removeun) {
	open(F,"| ./$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom | ./samtools view -S -F 4 -h -") or die "$!";
}else {
	open(F,"| ./$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom | ./samtools view -S -h -") or die "$!";
}
while (<>) {
	s/^\@//; #strip off leading @ character that messses up file format
	print F $_;
	$c++;
}
close F;
print STDERR "$0:\t$c records processed\n";
exit 0;



#unused pipes
#open(F,"| ./$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom  ") or die "$!";
#open(F,"| ./$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom | ./samtools view -uS - | ./samtools sort -o - - | ./samtools view - ") or die "$!";
#open(F,"| ./$aligner  $opts -d $index -F TSV -f - -oSAM -k -rRandom | ./samtools view -uS -  | ./novosort - -t . -m 3g   | ./samtools view -h - ") or die "$!";
