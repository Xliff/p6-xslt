use v6.c;

use Grammar::Tracer;

grammar XSLTFuncDef {
	token TOP { <funcDef> <wso> }

	token funcDef { 
		'XSLTPUBFUN' <ws>
		<returnType> <ws>
		'XSLTCALL' <ws>
		<funcName> <wso>
		'(' ( <params>* ) ');' 
	}

	token ws 	{ [ \s ]+ }
	token wso 	{ [ \s ]* }

	token returnType {
		[const <ws>]? (\w+)
	}

	token funcName {
		\w+
	}

	token params {
		['const' <ws>]? (\w+) ' ' ('*'? \w+) [ ',' <ws> ]? 
	}
}

my $test = "XSLTPUBFUN void XSLTCALL
	xsltApplyAttributeSet		(xsltTransformContextPtr ctxt,
					 xmlNodePtr node,
					 xmlNodePtr inst,
					 const xmlChar *attributes);";

my $t = XSLTFuncDef.parse($test);
say $t;