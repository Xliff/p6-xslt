use v6.c;

use Grammar::Tracer;

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
		[<typePrefix> <ws>]? (\w+) <wso> <stars>
	}

	token funcName {
		(\w+)
	}

	token typeName {
		\w+
	}

	token typePrefix {
		'const' || 'unsigned'
	}

	regex params {
		[
			[ 'void' <ws> <stars> (\w+)] || 
			[<typePrefix> <ws>]? 
			<typeName> <stars> <ws> <stars> <wso> <stars>(\w+)
		] 
		[ ',' <ws> ]? 
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
			ctype 	=> $/<typeName>.Str,
			type 	=> $tp ~ self!typeConv($/<typeName>.Str)
		}
		
	}

	method typePrefix($/) {
		given $/[0] {
			when Any {
				make '';
			}

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

sub writeStub($f) {
	my $argsList = $f<params>.map({ '$' ~ $_<name>}).join(', ');
	my $fullArgsList = $f<params>.map({ 
		$_<type> ~ ' ' ~ '$' ~ $_<name>
	}).join(', ');
	my $returns = $f<returnType><type> ne 'void' ??
		$f<returnType><type> !! '';

	for $f<params>.grep({ $_<stars>.chars > 2 }) -> $ca {
		say "\t# Potential CArray ({ $ca<stars>.chars - 1 })";
	}
	say qq:to/HERE/;
		sub { $f<functionName> }($argsList) \{
			die 'Function requires XML::LibXML'
				unless XSLT_xml_support;

			sub _{ $f<functionName> }($fullArgsList) 
				is native(XSLT)
				is symbol('{ $f<functionName> }'){
					$returns.chars ?? "\n\t\treturns $returns" !! ''
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
	my $returns = $f<returnType><type> ne 'void' ??
		$f<returnType><type> !! '';

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

sub MAIN {
    my $text = "XSLTPUBFUN int XSLTCALL
                xsltPointerListAddSize          (xsltPointerListPtr list,
                                                 void *item,
                                                 int initialSize);";

	say "==== Testing ====\n$text\n{ '=' x 25 }";
	my $t = XSLTFuncDef.parse($text, actions => grammarActions.new);
	say $t;
	my $r = $t.made;
	dd $r;

	if $r<params>.grep({ $_<type> ~~ /xml/ }) {
		writeStub($r);
	} else {
		writeNC($r);
	}
	
	
}