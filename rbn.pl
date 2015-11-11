#!/usr/bin/perl

print "How many nodes? (n)\n";
$n = <>;
print "How many nodes for each function? (k)\n";
$k = <>;
print "How many states?\n";
$s = <>;
chomp ($n,$s,$k);

# must be all integers. n, k > 0 and k <= n

# generate functions
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
	$nstring = $string;
	$nstring =~ s/ (\d+) / n$1 /g;
	$nstring =~ s/! /!/g;
	$nstring =~ s/^\s+//;
	$nstring =~ s/\s+$//;
	print "n'$i = $nstring\n";
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

# print states
print "State";
for my $i (0..$n-1) {
	print "\tn$i";
}
print "\n";
for my $state (0..$s) {
	print "$state";
	for my $i (0..$n-1) {
		print "\t$states[$state][$i]";
	}
	print "\n";
}


