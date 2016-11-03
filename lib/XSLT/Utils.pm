use v6.c;

use XSLT::Types;

my $xml_support;
{
	$xml_node_support = (try require ::('XML::LibXML::Node')) !~~ Nil;
}

module XSLT::Utils {

	enum xsltDebugTraceCodes is export (
		XSLT_TRACE_ALL 				=	-1,
		XSLT_TRACE_NONE 			=	0,
		XSLT_TRACE_COPY_TEXT 		=	0b1,
		XSLT_TRACE_PROCESS_NODE 	=	0b10,
		XSLT_TRACE_APPLY_TEMPLATE 	=	0b100,
		XSLT_TRACE_COPY 			=	0b1000,
		XSLT_TRACE_COMMENT 			=	0b10000,
		XSLT_TRACE_PI 				=	0b100000,
		XSLT_TRACE_COPY_OF 			=	0b1000000,
		XSLT_TRACE_VALUE_OF 		=	0b10000000,
		XSLT_TRACE_CALL_TEMPLATE 	=	0b100000000,
		XSLT_TRACE_APPLY_TEMPLATES  =	0b1000000000,
		XSLT_TRACE_CHOOSE 			=	0b10000000000,
		XSLT_TRACE_IF 				=	0b100000000000,
		XSLT_TRACE_FOR_EACH 		=	0b1000000000000,
		XSLT_TRACE_STRIP_SPACES 	=	0b10000000000000,
		XSLT_TRACE_TEMPLATES 		=	0b100000000000000,
		XSLT_TRACE_KEYS 			=	0b1000000000000000,
		XSLT_TRACE_VARIABLES 		=	0b10000000000000000
	);

	sub xsltGetUTF8Char(Str $utf, int32 $len)
		is native('xslt')
		is export
		returns int32
	{ * };

	sub xsltDebugSetDefaultTrace(int32 $val)
		is native('xslt')
		is export
	{ * };

	sub xsltDebugGetTraceCodes()
		is native('xslt')
		is export
		returns int32
	{ * };

	sub xsltSetCtxtParseOptions(xsltTransformContext $ctxt, int32 $opt)
		is native('xslt')
		is export
		returns int32
	{ * };

	# cw: TODO
	#XSLTPUBVAR xmlGenericErrorFunc xsltGenericError;
	#XSLTPUBVAR void *xsltGenericErrorContext;
	#XSLTPUBVAR xmlGenericErrorFunc xsltGenericDebug;
	#XSLTPUBVAR void *xsltGenericDebugContext;

	sub xsltSetGenericErrorFunc(Pointer $ctx, Pointer $handler)
		is native('xslt')
		is export
	{ * };


	sub xsltSetGenericDebugFunc(Pointer $ctx, Pointer $handler)
		native('xslt')
		is export
	{ * };

	sub xsltSetTransformErrorFunc(
		xsltTransformContext $ctxt,
		Pointer $ctx,
		Pointer $handler
	)
		is native('xslt')
		is export
	{ * };

	# cw: TODO
	#xsltTransformError(
	#	xsltTransformContextPtr ctxt,
	#	xsltStylesheetPtr style,
	#	xmlNodePtr node,
	#	const char *msg,
	#	...
	#) LIBXSLT_ATTR_FORMAT(4,5);

	sub xsltGetNsProp($node, $name, $ns) is export {
		sub _xsltGetNsProp(xmlNode $node, Str $name, Str $ns) 
			is native('xslt') 
			is symbol ('xsltGetNsProp')
			returns Str
			{ * }

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetNsProp($node, $name, $ns);
	}

	sub xsltGetCNsProp($sheet, $node, $name, $ns) is export {
		sub _xsltCGetNsProp(xsltStyleSheet $sheet, xmlNode $node, Str $name, Str $ns) 
			is native('xslt') 
			is symbol ('xsltGetCNsProp')
			returns Str
			{ * }

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetCNsProp($sheet, $node, $name, $ns);
	}

	sub xsltPrintErrorContext($ctxt, $style, $node) {
		sub _xsltPrintErrorContext(
			xsltTransformContext $ctxt, 
			xsltStyleSheet $sheet, 
			xmlNode $node
		) 
			is native('xslt')
			is symbol('xsltPrintErrorContext')
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltPrintErrorContext($ctxt, $style, $node);
	}

	sub xsltMessage($ctxt, $node, $inst) {
		sub _xsltMessage(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst)
			is native('xslt')
			is symbol('xsltMessage')
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltMessage($ctxt, $node, $inst);
	}

	sub xsltDocumentSortFunction($list) {
		sub _xsltDocumentSortFunction(xmlNodeSet $list)
			is native('xslt')
			is symbol('xsltDocumentSortFunction')
		{ *  };

		# cw: We could break out support to different modules or to the whole
		#     XML::LibXML::LibXML package. Actually, XML::LibXML::LibXML should probably be a
		#     requirement. That would make things a LOT easier.
		die "Functon requires the XML::LibXML::NodeSet module"
			unless $xml_node_support;

		_xsltDocumentSortFunction($list);
	}

	#xsltSetSortFunc(xsltSortFunc handler);
	#xsltSetCtxtSortFunc(xsltTransformContextPtr ctxt, xsltSortFunc handler);

	sub xsltDefaultSortFunction($ctxt, $nodes, $num) {
		sub _xsltDefaultSortFunction(
			xsltTransformContext $ctxt, 
			xmlNode $node, int32 
			$num
		)
			is native('xslt')
			is symbol('xsltDefaultSortFunction')
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltDefaultSortFunction($ctxt, $nodes, $num)
	}

	sub xsltDoSortFunction($ctxt, $nodes, $num) {
		sub _xsltDoSortFunction(
			xsltTransformContext $ctxt, 
			xmlNode $node, int32 
			$num
		)
			is native('xslt')
			is symbol('xsltDoSortFunction')
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltDotSortFunction($ctxt, $nodes, $num)
	}

	sub xsltComputeSortResult($ctxt, $node) {
		sub _xsltComputeSortResult(xsltTransformContext $ctxt, xmlNode $node)
			is native('xslt')
			is symbol('xsltComputeSortResult')
			returns xmlXPathObject
		{ * };

		# cw: XML::LibXML::LibXML will probably be a requirement prior to release, but 
		#     for now, we will test the conditional support pattern.
		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		_xsltComputeSortResult($ctxt, $node);
	}

	sub xsltSplitQName($dict, $name, @prefix) {
		sub _xsltSplitQName(xmlDict $dict, Str $name, CArray[str] @prefix)
			is native('xslt')
			is symbol ('xsltSplitQName')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Dict module"
			unless $xml_node_support;

		_xsltSplitQName($dict, $name, $prefix);
	}

	sub xsltGetQNameURI($node, $name) {
		sub _xsltGetQNameURI(xmlNode $node, Str $name)
			is native('xslt')
			is symbol('xsltGetQNameURI')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetQNameURI($node, $name);
	}

	sub xsltGetQNameURI2($style $node, $name) {
		sub _xsltGetQNameURI(xsltStyleSheet $style, xmlNode $node, Str $name)
			is native('xslt')
			is symbol('xsltGetQNameURI2')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetQNameURI($style $node, $name);
	}

	sub xsltSaveResultTo($buf, $result, $style) {
		sub _xsltSaveResultTo(
			xmlOutputBuffer $buf,
			xmlDoc $result,
			xsltStylesheet style
		)
			is native('xslt')
			is symbol('xsltSaveResultTo')
			returns int32
		{ * };

		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		_xsltSaveResulTo($buf, $result, $style);
	}

	sub xsltSaveResultToFilename($uri, $result, $style, $comp) {
		sub _xsltSaveResultToFilename(
			Str $uri,
			xmlDoc $result,
			xsltStylesheet $style,
			int $comp
		)
			is native('xslt')
			is symbol('xsltSaveResultToFilename')
			returns int32
		{ * };

		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		_xsltSaveResulToFilename($buf, $result, $style, $comp);
	}

	# cw: TODO - C FILE pointers.
	#sub xsltSaveResultToFile($file, $result, $style) {
	#	sub _xsltSaveResultToFile(
	#		FILE $fd,
	#		xmlDoc $result,
	#		xsltStylesheet style
	#	)
	#		is native('xslt')
	#		is symbol('xsltSaveResultToFile')
	#		returns int32
	#	{ * };
	#
	#	die "Function requires the XML::LibXML package"
	#		unless $xml_node_support;
	#
	#	_xsltSaveResulToFile($file, $result, $style);
	#}

	sub xsltSaveResultToFd($fd, $result, $style) {
		sub _xsltSaveResultToFd(
			int32 $fd,
			xmlDoc $result,
			xsltStylesheet $style
		)
			is native('xslt')
			is symbol('xsltSaveResultToFd')
			returns int32
		{ * };

		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		_xsltSaveResulToFd($fd, $result, $style);
	}

	sub xsltSaveResultToString($out is rw, $len is rw, $result, $style) {
		# cw: Another reason to do this via wrappers is so that we can 
		#     do work for the caller, as in this case. 
		#
		#     The caller should just be able to pass a string value and have
		#     this wrapper do all of the NativeCall work to properly prepare 
		#     $out and $len. 
		sub _xsltSaveResultToString(
			Pointer[Str] $out,
			Pointer[int32] $len,
			xmlDoc $result,
			xsltStylesheet $style
		)

		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		_xsltSaveResultToString($out, $len, $result, $style);
	}

}