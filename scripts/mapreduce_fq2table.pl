#!/usr/bin/perl


#FaSTQ preprocessor for hadoop Novoalign

my $usage="$0 fastq1 fastq2\n";

my $counter=0;

if (scalar @ARGV ==1) {
	seProcess($ARGV[0]);
}elsif (scalar @ARGV==2) {
	peProcess($ARGV[0],$ARGV[1]);
}else {
	print $usage;
	exit 11;
}

exit 0;

sub seProcess {
	my $f=shift;
	print STDERR "SE detected\n";
	if ($f=~/.gz/) {
		open(IN,"gzip -dc $f |") or die "$!";
	}else {
		open(IN,$f) or die "$!";
	}
	while(<IN>) {
		chomp $_; 
		my $s=<IN>;
		<IN>;
		my $q=<IN>;
		chomp $s; 
		chomp $q;
		s/^\@//;
		s/\s+.+//;
		print "$_\t$s\t$q\n";
	}
	close IN;
	
}




sub peProcess {

$f1=shift;
$f2=shift; 
if ($f1 =~/\.gz$/) {
open(R1,"zcat $f1 | ") or die "$!"; 
open(R2,"zcat $f2 | ") or die "$!"; 
}else{
open(R1,$f1) or die "$!"; 
open(R2,$f2) or die "$!"; 
}

	while (<R1>){ 
	my $n=$_; 
	my $s1=<R1>;
	<R1>; 
	my $q1=<R1>;
	<R2>;
	my $s2=<R2>;
	<R2>;
	my $q2=<R2>; 
	chomp $n;
	 chomp $s1; 
	chomp $s2; 
	chomp $q1; 
	chomp $q2; 
	$n=~s/\/[12]//;
	$n=~s/^\@//;
	$n=~s/\s+.+//;
	print "$n\t$s1\t$q1\t$s2\t$q2\n";
	$counter++;
}

close R1;
close R2;
}
