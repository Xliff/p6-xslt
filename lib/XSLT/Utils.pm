use v6.c;

use XSLT::Types;

class xmlXPathCompExprPtr 	{ ... };
class xmlDoc 				{ ... };
class xmlNode 				{ ... };
class xmlNodeSet 			{ ... };

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

	constant XSLT_TIMESTAMP_TICS_PER_SEC is export = 100000;

	enum xsltDebugStatusCodes is export (
	    XSLT_DEBUG_NONE = 0, 
	    XSLT_DEBUG_INIT,
	    XSLT_DEBUG_STEP,
	    XSLT_DEBUG_STEPOUT,
	    XSLT_DEBUG_NEXT,
	    XSLT_DEBUG_STOP,
	    XSLT_DEBUG_CONT,
	    XSLT_DEBUG_RUN,
	    XSLT_DEBUG_RUN_RESTART,
	    XSLT_DEBUG_QUIT
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
		sub _xsltCGetNsProp(
			xsltStyleSheet $sheet, 
			xmlNode $node, 
			Str $name, 
			Str $ns
		) 
			is native('xslt') 
			is symbol ('xsltGetCNsProp')
			returns Str
			{ * }

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetCNsProp($sheet, $node, $name, $ns);
	}

	sub xsltPrintErrorContext($ctxt, $style, $node) is export {
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

	sub xsltMessage($ctxt, $node, $inst) is export {
		sub _xsltMessage(
			xsltTransformContext $ctxt, 
			xmlNode $node, 
			xmlNode $inst
		)
			is native('xslt')
			is symbol('xsltMessage')
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltMessage($ctxt, $node, $inst);
	}

	sub xsltDocumentSortFunction($list) is export {
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

	sub xsltDefaultSortFunction($ctxt, $nodes, $num) is export {
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

	sub xsltDoSortFunction($ctxt, $nodes, $num) is export {
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

	sub xsltComputeSortResult($ctxt, $node) is export {
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

	sub xsltSplitQName($dict, $name, @prefix) is export {
		sub _xsltSplitQName(xmlDict $dict, Str $name, CArray[str] @prefix)
			is native('xslt')
			is symbol ('xsltSplitQName')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Dict module"
			unless $xml_node_support;

		_xsltSplitQName($dict, $name, $prefix);
	}

	sub xsltGetQNameURI($node, $name) is export {
		sub _xsltGetQNameURI(xmlNode $node, Str $name)
			is native('xslt')
			is symbol('xsltGetQNameURI')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetQNameURI($node, $name);
	}

	sub xsltGetQNameURI2($style $node, $name) is export {
		sub _xsltGetQNameURI(xsltStyleSheet $style, xmlNode $node, Str $name)
			is native('xslt')
			is symbol('xsltGetQNameURI2')
			returns Str	
		{ * };

		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		_xsltGetQNameURI($style $node, $name);
	}

	sub xsltSaveResultTo($buf, $result, $style) is export {
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

	sub xsltSaveResultToFilename($uri, $result, $style, $comp) is export {
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

	sub xsltSaveResultToFd($fd, $result, $style) is export {
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

	sub xsltSaveResultToString($out is rw, $len is rw, $result, $style) 
		is export
	{
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
			is native('xslt')
			is symbol('xsltSaveResultToString')
			returns int32
		{ * };

		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		_xsltSaveResultToString($out, $len, $result, $style);
	}

	sub xsltXPathCompile($style, $str) is export {
		sub _xsltXPathCompile(xsltStyleSheet $style, Str $str)
			is native('xslt')
			is symbol('xsltXPathCompile')
			returns xsltXPathCompExpr
		{ * };

		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		_xsltXPathCompile($style, $str);
	}

	sub xsltXPathCompileFlags($style, $str, $flags) is export {
		sub _xsltXPathCompileFlags(xsltStyleSheet $style, Str $str, int32 $flags)
			is native('xslt')
			is symbol('xsltXPathCompileFlags')
			returns xmlXPathCompExpr
		{ * };

		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		_xsltXPathCompileFlags($style, $str, $flags);
	}

	# cw: TODO - C FILE Pointer
	#sub xsltSaveProfiling(xsltTransformContext $ctxt, FILE $output)
	#	is native('xslt')
	#{ * };

	sub xsltGetProfileInformation($ctxt) is export {
		sub _xsltGetProfileInformation(xsltTransformContext $ctxt)
			is native('xslt')
			is symbol('xsltGetProfileInformation')
			returns xmlDoc
		{ * };

		die "Function requires the XML::LibXML::Doc module"
			unless $xml_node_support;

		_xsltGetProfileInformation($ctxt);
	}

	sub xsltTimestamp() 
		is native('xslt')
		is export
	{ * };

	sub xsltCalibrateAdjust(int64 $delta)
		is native('xslt')
		is export
	{ * };


}