use v6.c;

#use Grammar::Tracer;

grammar XSLTFuncDef {
	token TOP { 
		'XSLTPUBFUN' <ws>
		<returnType> <wso>
		'XSLTCALL' <wso>
		<funcName> <wso>
		'(' <wso> <params>* <wso> ');'  
	}

	token ws 	{ \s+ }
	token wso 	{ \s* }
	token stars { '*' * }

	token returnType {
		[<typePrefix> <ws>]? <typeName> <wso> <stars>
	}

	token funcName {
		\w+
	}

	token typeName {
		\w+
	}

	token typePrefix {
		'const' || 'unsigned'
	}

	regex params {
		[
			[ 'void' <wso> <stars> <wso> ]

			|| 

			[<typePrefix> <ws>]? 
			<typeName> <stars> <ws> <stars> <wso> 
		] 
		<stars> (\w+)? [ ',' <ws> ]? 
	}
}

class grammarActions {
	has @!params;

	method TOP($/) {
		make {
			functionName 	=> $/<funcName>.Str,
			returnType 		=> $/<returnType>.made,
			params			=> @!params
		}
	}

	method returnType($/) {
		my $tp = $/<typePrefix>.defined ?? $/<typePrefix>.made !! '';
		make {
			ctype 	=> $/<typeName>.Str,
			type 	=> $tp ~ self!typeConv($/<typeName>.Str),
			stars	=> $/<stars>.Str
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
		my $stars = $/<stars>.map({ $_.Str }).join('');
		my $ctype = ($/<typeName> // '').Str;

		push @!params, {
			ctype 	=> $ctype,
			type 	=> $tp ~ self!typeConv($ctype),
			name 	=> ($/[0] // '').Str,
			stars 	=> $stars,
		}
	}

	# cw: WHEEE! This needs to be reworked since it is a method and not 
	#     an auto-executed action.
	method !typeConv($t) {
		do given $t {
			when Nil {
				'';
			}

			when /Ptr$/ {
				S/Ptr$//;
			}

			when /Function$/ || /FILE$/ {
				'Pointer';
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
			$_;
		}
	};
}

sub writeStub($f) {
	my @argsList;
	my @fullArgsList;
	for @( $f<params> ) -> $p {
		# cw: There should be a type here, but will leave this alone if it
		#     works.
		if 
			($p<ctype> eq 'void' || $p<ctype>.chars == 0) && 
			$p<stars>.chars == 0 
		{
			push @argsList, '';
			push @fullArgsList, '';
			last;
		}

		# cw: If we are at this point, assume any void types are (void *)
		my $type = $p<type> eq 'void' ?? 'Pointer' !! 
			$p<stars>.chars > 1 ?? "CArray[{ $p<type> }]" !! $p<type>;
		my $var = "\${ $p<name> }";
		push @argsList, $var;
		push @fullArgsList, "$type $var";
	}
	my $returns = resolveReturnType($f<returnType>);
	my $argsList = @argsList.join(', ');

	for $f<params>.grep({ $_<stars>.chars > 2 }) -> $ca {
		say "\t# Potential CArray ({ $ca<stars>.chars - 1 })";
	}
	say qq:to/HERE/;
		sub { $f<functionName> }($argsList) \{
			die 'Function requires XML::LibXML'
				unless \$XSLT_xml_support;

			sub _{ $f<functionName> }({ @fullArgsList.join(', ') }) 
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
	my @fullArgsList;
	for @( $f<params> ) -> $p { 
		# cw: This is also non-optimal. There should be a type here.
		if ($p<ctype> eq 'void' || $p<ctype>.chars == 0) && $p<stars>.chars == 0 {
			push @fullArgsList, '';
			last;
		}

		# cw: If we are at this point, assume any void types are (void *)
		# cw: Note, CArray handling is *not optimal* and will not handle 
		#     multidim arrays... yet.
		my $type = $p<type> eq 'void' ?? 'Pointer' !! 
			$p<stars>.chars > 1 ?? "CArray[{ $p<type> }]" !! $p<type>;
		my $var = "\${ $p<name> }";
		push @fullArgsList, "$type $var";
	}
	my $returns = resolveReturnType($f<returnType>);

	for $f<params>.grep({ $_<stars>.chars > 2 }) -> $ca {
		say "\t# Potential Multi-Dimensional CArray ({ $ca<stars>.chars - 2 })";
	}

	say qq:to/NC/;
		sub { $f<functionName> }({ @fullArgsList.join(', ') }) 
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
			note "=== $filename ===\nPotential missed parsing:\n{ $m[0] }";
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