#!/usr/bin/perl

# read in genes (g), variables (k) and the number of states
# check all are non-negative integers and that k <= n
while ($n !~ /^\s*\d+\s*\n$/ || $n == 0) {
	print "Number of genes (g)\n";
	$n = <>;
}
while ($k !~ /^\s*\d+\s*\n$/ || $k > $n || $k == 0) {
	print "Number of variables (k) to be the regulatory function for gene g\n";
	$k = <>;
}
while ($s !~ /^\s*\d+\s*\n$/) {
	print "Number of states\n";
	$s = <>;
}
chomp ($n,$k,$s);
while ($write !~ /^\s*(y|n)\s*$/i) {
	print "Write to file? [Y/N]\n";
	$write = <>;
}
if ($write =~ /^\s*y\s*$/i) {
	while ($fname !~ /^\s*[\w\.]+\s*$/i) {
		print "File name:\n";
		$fname = <>;
	}
}
chomp ($fname);

my $output = "$n-$k Boolean network\n\n";

# generate functions
$output .= "Regulatory Functions\n";
@functions;
for my $i (0..$n-1) {
	my $string = "";
	my @selected;
	for my $z (0..$n-1) {
		$selected[$z] = 0;
	}
	for my $j (0..$k-1) {
		my $not = int(rand()+0.5);
		if ($not) {
			$string .= " !"
		}
		my $loop = 1;
		while ($loop) {
			my $node = int(rand($n));
			if (!$selected[$node]) {
				$string .= " $node ";
				$selected[$node] = 1;
				$loop = 0;
			}
		}
		if ($j != $k-1) {
			my $operator = int(rand()+0.5);
			if ($operator) {
				$string .= "&&";
			} else {
				$string .= "||";
			}
		}
	}
	$functions[$i] = $string;
	$gstring = $string;
	$gstring =~ s/ (\d+) / g$1 /g;
	$gstring =~ s/! /!/g;
	$gstring =~ s/^\s+//;
	$gstring =~ s/\s+$//;
	$output .= "g'$i = $gstring\n";
}

# initialise initial state
@states;
for my $i (0..$n-1) {
	$states[0][$i] = int(rand()+0.5);
}

# determine states
for my $current (1..$s) {
	for my $i (0..$n-1) {
		my $function = $functions[$i];
		my @nodes = ($function =~ /(\d+)/g);
		foreach $node (@nodes) {
			my $bool = $states[$current-1][$node];
			$function =~ s/ $node / $bool /;
		}
		$cmd = "perl -e 'if ($function) { print 1 } else { print 0 }'";
		my $bool = `$cmd`;
		$states[$current][$i] = $bool;
	}
}

# create table of states
$output .= "\nState";
for my $i (0..$n-1) {
	$output .= "\tg$i";
}
$output .= "\n";
for my $state (0..$s) {
	$output .= "$state";
	for my $i (0..$n-1) {
		$output .= "\t$states[$state][$i]";
	}
	$output .= "\n";
}

# write to file or print to STDOUT
if ($fname ne "") {
	open(my $f, '>', $fname) or die "Could not open file '$fname' $!";
	print $f $output;
	close $f;
} else {
	print $output;
}


