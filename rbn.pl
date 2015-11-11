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
while ($initial !~ /^\s*(y|n)\s*$/i) {
	print "Select initial state? [Y/N] (if N initial state will be random)\n";
	$initial = <>;
}
if ($initial =~ /^\s*y\s*$/i) {
	while ($set !~ /^(\s*[01][\s,]*){$n}$/) {
		print "Enter initial state ($n binary digits)\n";
		$set = <>;
	}
}
chomp ($set);
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
$fname =~ s/^\s+//;
$fname =~ s/\s+$//;
chomp ($fname);

# print header
my $output = "$n-$k Boolean network\n";
my $space = 2**$n;
$output .= "State space = $space\n\n";

# generate functions
$output .= "Regulatory functions\n";
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
	$gstring =~ s/! /~/g;
	$gstring =~ s/&&/\^/g;
	$gstring =~ s/\|\|/v/g;
	$gstring =~ s/^\s+//;
	$gstring =~ s/\s+$//;
	$output .= "g'$i = $gstring\n";
}

# initialise initial state
if ($set ne "") {
	$set =~ s/[\s,]//g;
	@start = split //, $set;
	@states;
	for my $i (0..$n-1) {
		$states[0][$i] = $start[$i];
	}
} else {
	@states;
	for my $i (0..$n-1) {
		$states[0][$i] = int(rand()+0.5);
	}
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

# identify additional information including basin states, attractors and transient time
@strings;
$output .= "\n";
for my $i (0..$s) {
	$strings[$i] = "";
	for my $j (0..$n-1) {
		$strings[$i] .= "$states[$i][$j]";
	}
}
$found = 0;
for my $i (0..$s) {
	if ($found) {
		last;
	}
	for my $j ($i+1..$s) {
		if ($strings[$i] eq $strings[$j]) {
			if ($i != 0) {
				if ($i-1 == 0) {
					$output .= "Basin state at 0\n";
				} else {
					$output .= "Basin states from 0 to ";
					$output .= $i-1;
					$output .= "\n";
				}
			}
			if ($j - $i == 1) {
				$output .= "Point attractor starting at state $i\n"
			} else {
				$output .= "Cycle attractor of ";
				$output .= $j-$i;
				$output .= " iterations starting at state $i \n";
			}
			$output .= "Transient time of $i iterations\n";
			$found = 1;
			last;
		}
	}
}

# write to file or print to STDOUT
if ($fname ne "") {
	open(my $f, '>', $fname) or die "Could not open file '$fname'";
	print $f $output;
	close $f;
} else {
	print $output;
}

