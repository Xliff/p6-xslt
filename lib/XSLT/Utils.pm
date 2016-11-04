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

# cw: To convert from file descriptor to FILE*
sub fdopen(int32 $fd, Str $mode) is native returns Pointer { * };

module XSLT::Utils {
	constant XSLT = ('xslt', v1);

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
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltDebugSetDefaultTrace(int32 $val)
		is native(XSLT)
		is export
	{ * };

	sub xsltDebugGetTraceCodes()
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltSetCtxtParseOptions(xsltTransformContext $ctxt, int32 $opt)
		is native(XSLT)
		is export
		returns int32
	{ * };

	# cw: For now, use Pointer. Can always nativecast() and replace with a better
	#     alternative, later.
	our $xsltGenericError := cglobal('xslt', 'xsltGenericError', Pointer);
	our $xsltGenericErrorContext := cglobal('xslt', 'xsltGenericErrorContext', Pointer);
	our $xsltGenericDebug := cglobal('xslt', 'xsltGenericDebug', Pointer);
	our $xsltGenerigDebugContext := cglobal('xslt', 'xsltGenericDebugContext', Pointer);

	our $xsltDebugStatus := cglobal('xslt', 'xslDebugStatus', int32);

	sub xsltSetGenericErrorFunc(Pointer $ctx, Pointer $handler)
		is native(XSLT)
		is export
	{ * };


	sub xsltSetGenericDebugFunc(Pointer $ctx, Pointer $handler)
		native(XSLT)
		is export
	{ * };

	sub xsltSetTransformErrorFunc(
		xsltTransformContext $ctxt,
		Pointer $ctx,
		Pointer $handler
	)
		is native(XSLT)
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
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltGetNsProp(xmlNode $node, Str $name, Str $ns) 
			is native(XSLT) 
			is symbol ('xsltGetNsProp')
			returns Str
		{ * };
		
		_xsltGetNsProp($node, $name, $ns);
	}

	sub xsltGetCNsProp($sheet, $node, $name, $ns) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltCGetNsProp(
			xsltStyleSheet $sheet, 
			xmlNode $node, 
			Str $name, 
			Str $ns
		) 
			is native(XSLT) 
			is symbol ('xsltGetCNsProp')
			returns Str
		{ * };

		_xsltGetCNsProp($sheet, $node, $name, $ns);
	}

	sub xsltPrintErrorContext($ctxt, $style, $node) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltPrintErrorContext(
			xsltTransformContext $ctxt, 
			xsltStyleSheet $sheet, 
			xmlNode $node
		) 
			is native(XSLT)
			is symbol('xsltPrintErrorContext')
		{ * };

		_xsltPrintErrorContext($ctxt, $style, $node);
	}

	sub xsltMessage($ctxt, $node, $inst) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltMessage(
			xsltTransformContext $ctxt, 
			xmlNode $node, 
			xmlNode $inst
		)
			is native(XSLT)
			is symbol('xsltMessage')
		{ * };
		
		_xsltMessage($ctxt, $node, $inst);
	}

	sub xsltDocumentSortFunction($list) is export {
		# cw: We should break out support to different modules. Especially 
		#     since XML::LibXML is not yet complete... or released.
		die "Functon requires the XML::LibXML::NodeSet module"
			unless $xml_node_support;

		sub _xsltDocumentSortFunction(xmlNodeSet $list)
			is native(XSLT)
			is symbol('xsltDocumentSortFunction')
		{ *  };

		_xsltDocumentSortFunction($list);
	}

	sub xsltSetSortFunc(Pointer $handler)
		is native(XSLT)
		is export
	{ * };

	sub xsltSetCtxtSortFunc(xsltTransformContext $ctxt, Pointer $handler)
		is native(XSLT)
		is export
	{ * };

	sub xsltDefaultSortFunction($ctxt, $nodes, $num) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltDefaultSortFunction(
			xsltTransformContext $ctxt, 
			xmlNode $node, int32 
			$num
		)
			is native(XSLT)
			is symbol('xsltDefaultSortFunction')
		{ * };
		
		_xsltDefaultSortFunction($ctxt, $nodes, $num)
	}

	sub xsltDoSortFunction($ctxt, $nodes, $num) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltDoSortFunction(
			xsltTransformContext $ctxt, 
			xmlNode $node, int32 
			$num
		)
			is native(XSLT)
			is symbol('xsltDoSortFunction')
		{ * };

		_xsltDotSortFunction($ctxt, $nodes, $num)
	}

	sub xsltComputeSortResult($ctxt, $node) is export {
		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		sub _xsltComputeSortResult(xsltTransformContext $ctxt, xmlNode $node)
			is native(XSLT)
			is symbol('xsltComputeSortResult')
			returns xmlXPathObject
		{ * };

		_xsltComputeSortResult($ctxt, $node);
	}

	sub xsltSplitQName($dict, $name, @prefix) is export {
		die "Function requires the XML::LibXML::Dict module"
			unless $xml_node_support;

		# cw: Check to insure @prefix is using the right sigil.
		sub _xsltSplitQName(xmlDict $dict, Str $name, CArray[str] @prefix)
			is native(XSLT)
			is symbol ('xsltSplitQName')
			returns Str	
		{ * };

		_xsltSplitQName($dict, $name, $prefix);
	}

	sub xsltGetQNameURI($node, $name) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltGetQNameURI(xmlNode $node, Str $name)
			is native(XSLT)
			is symbol('xsltGetQNameURI')
			returns Str	
		{ * };

		_xsltGetQNameURI($node, $name);
	}

	sub xsltGetQNameURI2($style $node, $name) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltGetQNameURI(xsltStyleSheet $style, xmlNode $node, Str $name)
			is native(XSLT)
			is symbol('xsltGetQNameURI2')
			returns Str	
		{ * };

		_xsltGetQNameURI($style $node, $name);
	}

	sub xsltSaveResultTo($buf, $result, $style) is export {
		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		sub _xsltSaveResultTo(
			xmlOutputBuffer $buf,
			xmlDoc $result,
			xsltStylesheet style
		)
			is native(XSLT)
			is symbol('xsltSaveResultTo')
			returns int32
		{ * };

		_xsltSaveResulTo($buf, $result, $style);
	}

	sub xsltSaveResultToFilename($uri, $result, $style, $comp) is export {
		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		sub _xsltSaveResultToFilename(
			Str $uri,
			xmlDoc $result,
			xsltStylesheet $style,
			int $comp
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFilename')
			returns int32
		{ * };

		_xsltSaveResulToFilename($buf, $result, $style, $comp);
	}


	sub xsltSaveResultToFile($file, $result, $style) {
		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		die "Must pass an IO::Handle as the first parameter!"
			unless $file ~~ File::Handle;

		my $fd = fdopen($file.native-descriptor, "w");

		sub _xsltSaveResultToFile(
			Pointer $fd,
			xmlDoc $result,
			xsltStylesheet style
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFile')
			returns int32
		{ * };
	
		_xsltSaveResulToFile($fd, $result, $style);
	}

	sub xsltSaveResultToFd($fd, $result, $style) is export {
		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

		sub _xsltSaveResultToFd(
			int32 $fd,
			xmlDoc $result,
			xsltStylesheet $style
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFd')
			returns int32
		{ * };

		_xsltSaveResulToFd($fd, $result, $style);
	}

	sub xsltSaveResultToString($out is rw, $len is rw, $result, $style) 
		is export
	{
		die "Function requires the XML::LibXML package"
			unless $xml_node_support;

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
			is native(XSLT)
			is symbol('xsltSaveResultToString')
			returns int32
		{ * };

		_xsltSaveResultToString($out, $len, $result, $style);
	}

	sub xsltXPathCompile($style, $str) is export {
		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		sub _xsltXPathCompile(xsltStyleSheet $style, Str $str)
			is native(XSLT)
			is symbol('xsltXPathCompile')
			returns xsltXPathCompExpr
		{ * };

		_xsltXPathCompile($style, $str);
	}

	sub xsltXPathCompileFlags($style, $str, $flags) is export {
		die "Function requires the XML::LibXML::XPath module"
			unless $xml_node_support;

		sub _xsltXPathCompileFlags(xsltStyleSheet $style, Str $str, int32 $flags)
			is native(XSLT)
			is symbol('xsltXPathCompileFlags')
			returns xmlXPathCompExpr
		{ * };

		_xsltXPathCompileFlags($style, $str, $flags);
	}

	sub xsltSaveResultToFile($ctxt, $output) {
		die "Second parameter to xsltSaveResultToFile must be IO::Handle!"
			unless $output ~~ IO::Handle;

		my $fd = fdopen($output.native-descriptor, "w");

		sub _xsltSaveProfiling(xsltTransformContext $ctxt, Pointer $file)
			is native(XSLT)
		{ * };	

		_xsltSaveProfiling($ctxt, $fd);
	}
	

	sub xsltGetProfileInformation($ctxt) is export {
		die "Function requires the XML::LibXML::Doc module"
			unless $xml_node_support;

		sub _xsltGetProfileInformation(xsltTransformContext $ctxt)
			is native(XSLT)
			is symbol('xsltGetProfileInformation')
			returns xmlDoc
		{ * };
		
		_xsltGetProfileInformation($ctxt);
	}

	sub xsltTimestamp() 
		is native(XSLT)
		is export
	{ * };

	sub xsltCalibrateAdjust(int64 $delta)
		is native(XSLT)
		is export
	{ * };

	sub xsltSetDebuggerStatus(int32 $val)
		is native(XSLT)
		is export
	{ * };

	sub xsltGetDebuggerStatus()
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltSetDebuggerCallbacks(int32 $no, Pointer $block)
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xslAddCall($tmpl, $src) {
		die "Function requires the XML::LibXML::Node module"
			unless $xml_node_support;

		sub _xsltAddCall(xsltTemplate $templ, xmlNode $source)
			is native(XSLT)
			is symbol('xsltAddCall')
			returns int32
		{ * }

		_xsltAddCall($tmpl, $src);
	}

	sub xslDropCall()
		is native(XSLT)
		is export
	{ * };

}