use v6.c;

#use Grammar::Tracer;

grammar XSLTFuncDef {
	token TOP { 
		'XSLTPUBFUN' <ws>
		<returnType> <ws>
		'XSLTCALL' <ws>
		<funcName> <wso>
		'(' ( <params>* ) ');' 
	}

	token ws 	{ [ \s ]+ }
	token wso 	{ [ \s ]* }

	token returnType {
		[<typePrefix> <ws>]? (\w+) <wso> (\* *)
	}

	token funcName {
		(\w+)
	}

	token typePrefix {
		'const' || 'unsigned'
	}

	token params {
		[<typePrefix> <ws>]? (\w+) <ws> [('*'+)? (\w+)] [ ',' <ws> ]? 
	}
}

class grammarActions {
	has @!params;

	method TOP($/) {
		make {
			functionName 	=> $/<funcName>[0].Str,
			returnType 		=> $/<returnType>.made,
			params			=> @!params
		}
	}

	method returnType($/) {
		my $tp = $/<typePrefix>.defined ?? $/<typePrefix>.made !! '';
		make {
			ctype 	=> $/[0].Str,
			type 	=> $tp ~ self!typeConv($/[0]),
			stars	=> ($/[1] // '').Str
		}
		
	}

	method typePrefix($/) {
		given $/[0] {
			#when Any {
			#	make '';
			#}

			when 'unsigned' {
				make $/[0].Str;
			}

			default { 
				make '';
			}
		}
	}

	method params($/) {
		my $tp = $/<typePrefix>.defined ?? $/<typePrefix>.made !! '';

		push @!params, {
			ctype 	=> ($/[0] // '').Str,
			type 	=> $tp ~ self!typeConv($/[0]),
			name 	=> ($/[2] // '').Str,
			stars 	=> ($/[1] // '').Str,
		}
	}

	# cw: WHEEE! This needs to be reworked since it is a method and not 
	#     an auto-executed action.
	method !typeConv($t) {
		do given $t {
			when /Ptr$/ {
				S/Ptr$//;
			}

			when /Cha?r/ {
				'Str';
			}

			when 'int' {
				'int32';
			}

			when 'long' {
				'int64';
			}

			when 'float' {
				'num32';
			}

			when 'double' {
				'num64';
			}

			default {
				$_;
			}
		}
	}
}

sub resolveReturnType($r) {
	do given $r<type> {
		when 'void' {
			given $r<stars> {
				when .chars > 0 {
					'Pointer';
				}

				default {
					''
				}
			}
		}

		default {
			$_
		}
	};
}

sub writeStub($f) {
	my $argsList = $f<params>.map({ '$' ~ $_<name>}).join(', ');
	my $fullArgsList = $f<params>.map({ 
		($_<type> eq 'void' ?? 'Pointer' !! $_<type>) ~ 
		' ' ~ 
		'$' ~ $_<name>
	}).join(', ');
	my $returns = resolveReturnType($f<returnType>);

	for $f<params>.grep({ $_<stars>.chars > 2 }) -> $ca {
		say "\t# Potential CArray ({ $ca<stars>.chars - 1 })";
	}
	say qq:to/HERE/;
		sub { $f<functionName> }($argsList) \{
			die 'Function requires XML::LibXML'
				unless \$XSLT_xml_support;

			sub _{ $f<functionName> }($fullArgsList) 
				is native(XSLT)
				is symbol('{ $f<functionName> }'){
					$returns.chars ?? "\n\t\t\treturns $returns" !! ''
				}
			\{ \* \};

			_{ $f<functionName> }($argsList);
		\}
	HERE
}

sub writeNC($f) {
	my $fullArgsList = $f<params>.map({ 
		$_<type> ~ ' ' ~ '$' ~ $_<name>
	}).join(', ');
	my $returns = resolveReturnType($f<returnType>);

	for $f<params>.grep({ $_<stars>.chars > 2 }) -> $ca {
		say "\t# Potential CArray ({ $ca<stars>.chars - 1 })";
	}

	say qq:to/NC/;
		sub { $f<functionName> }($fullArgsList) 
			is native(XSLT)
			is export{$returns.chars ?? "\n\t\treturns $returns" !! ''}
		\{ \* \};
	NC
}

sub MAIN($filename) {
	die "'$filename' does not exist" unless $filename.IO.e;

	my $text = $filename.IO.slurp;

	my @functions;
	my @declarations = $text ~~ m:g/^^ ('XSLTPUBFUN' .+? ';')/;

	for @declarations -> $m {
		my $t = XSLTFuncDef.parse($m[0], actions => grammarActions.new);
		if $t.defined {
			push @functions, $t.made;
		} else {
			note "=== $filename ===\nPotential missed parsing:\n'{ $m[0] }'";
		}
	}

	if @functions {
		say qq:to/HEAD/;
			#
			# $filename
			#
		HEAD

		for @functions -> $f {
			next unless $f.defined;

			if $f<params>.grep({ $_<type> ~~ /xml/ }) {
				writeStub($f);
			} else {
				writeNC($f);
			}
		}
	}
}