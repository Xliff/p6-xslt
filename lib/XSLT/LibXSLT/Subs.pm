use v6.c;

use NativeCall;

use XSLT::LibXSLT::Types;

# cw: To convert from file descriptor to FILE*
sub fdopen(int32 $fd, Str $mode) is native returns Pointer { * };

module XSLT::LibXSLT::Subs {
	constant XSLT = ('xslt', v1);

	#
	# /usr/include/libxslt/attributes.h
	#

	sub xsltParseStylesheetAttributeSet($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetAttributeSet(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetAttributeSet')
		{ * };

		_xsltParseStylesheetAttributeSet($style, $cur);
	}

	sub xsltFreeAttributeSetsHashes(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltApplyAttributeSet($ctxt, $node, $inst, $attributes) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyAttributeSet(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, Str $attributes) 
			is native(XSLT)
			is symbol('xsltApplyAttributeSet')
		{ * };

		_xsltApplyAttributeSet($ctxt, $node, $inst, $attributes);
	}

	sub xsltResolveStylesheetAttributeSet(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/documents.h
	#

	enum xsltLoadType is export (
	    XSLT_LOAD_START 		=> 0,	
	    XSLT_LOAD_STYLESHEET 	=> 1,	
	    XSLT_LOAD_DOCUMENT 		=> 2	
	);

	sub xsltNewDocument($ctxt, $doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNewDocument(xsltTransformContext $ctxt, xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltNewDocument')
			returns xsltDocument
		{ * };

		_xsltNewDocument($ctxt, $doc);
	}

	sub xsltLoadDocument(xsltTransformContext $ctxt, Str $URI) 
		is native(XSLT)
		is export
		returns xsltDocument
	{ * };

	sub xsltFindDocument($ctxt, $doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltFindDocument(xsltTransformContext $ctxt, xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltFindDocument')
			returns xsltDocument
		{ * };

		_xsltFindDocument($ctxt, $doc);
	}

	sub xsltFreeDocuments(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltLoadStyleDocument(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns xsltDocument
	{ * };

	sub xsltNewStyleDocument($style, $doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNewStyleDocument(xsltStylesheet $style, xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltNewStyleDocument')
			returns xsltDocument
		{ * };

		_xsltNewStyleDocument($style, $doc);
	}

	sub xsltFreeStyleDocuments(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltSetLoaderFunc(xsltDocLoaderFunc $f) 
		is native(XSLT)
		is export
	{ * };

		#
	# /usr/include/libxslt/extensions.h
	#

	sub xsltInitGlobals() 
		is native(XSLT)
		is export
	{ * };

	sub xsltRegisterExtModule(Str $URI, Pointer $initFunc, Pointer $shutdownFunc) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltRegisterExtModuleFull(Str $URI, Pointer $initFunc, Pointer $shutdownFunc, Pointer $styleInitFunc, Pointer $styleShutdownFunc) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltUnregisterExtModule(Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltGetExtData(xsltTransformContext $ctxt, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltStyleGetExtData(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltStyleStylesheetLevelGetExtData(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltShutdownCtxtExts(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltShutdownExts(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltXPathGetTransformContext($ctxt) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltXPathGetTransformContext(xmlXPathParserContext $ctxt) 
			is native(XSLT)
			is symbol('xsltXPathGetTransformContext')
			returns xsltTransformContext
		{ * };

		_xsltXPathGetTransformContext($ctxt);
	}

	sub xsltRegisterExtModuleFunction(Str $name, Str $URI, Pointer $function) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltExtModuleFunctionLookup(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltUnregisterExtModuleFunction(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltNewElemPreComp($style, $inst, $function) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNewElemPreComp(xsltStylesheet $style, xmlNode $inst, Pointer $function) 
			is native(XSLT)
			is symbol('xsltNewElemPreComp')
			returns xsltElemPreComp
		{ * };

		_xsltNewElemPreComp($style, $inst, $function);
	}

	sub xsltInitElemPreComp($comp, $style, $inst, $function, $freeFunc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltInitElemPreComp(xsltElemPreComp $comp, xsltStylesheet $style, xmlNode $inst, Pointer $function, xsltElemPreCompDeallocator $freeFunc) 
			is native(XSLT)
			is symbol('xsltInitElemPreComp')
		{ * };

		_xsltInitElemPreComp($comp, $style, $inst, $function, $freeFunc);
	}

	sub xsltRegisterExtModuleElement(Str $name, Str $URI, Pointer $precomp, Pointer $transform) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltExtElementLookup(xsltTransformContext $ctxt, Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltExtModuleElementLookup(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltExtModuleElementPreComputeLookup(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltUnregisterExtModuleElement(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltRegisterExtModuleTopLevel(Str $name, Str $URI, Pointer $function) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltExtModuleTopLevelLookup(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltUnregisterExtModuleTopLevel(Str $name, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltRegisterExtFunction(xsltTransformContext $ctxt, Str $name, Str $URI, Pointer $function) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltRegisterExtElement(xsltTransformContext $ctxt, Str $name, Str $URI, Pointer $function) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltRegisterExtPrefix(xsltStylesheet $style, Str $prefix, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltCheckExtPrefix(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltCheckExtURI(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltInitCtxtExts(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFreeCtxtExts(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltFreeExts(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltPreComputeExtModuleElement($style, $inst) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltPreComputeExtModuleElement(xsltStylesheet $style, xmlNode $inst) 
			is native(XSLT)
			is symbol('xsltPreComputeExtModuleElement')
			returns xsltElemPreComp
		{ * };

		_xsltPreComputeExtModuleElement($style, $inst);
	}

	sub xsltGetExtInfo(xsltStylesheet $style, Str $URI) 
		is native(XSLT)
		is export
		returns xmlHashTable
	{ * };

	sub xsltRegisterTestModule() 
		is native(XSLT)
		is export
	{ * };

	sub xsltDebugDumpExtensions(Pointer $output) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/extra.h
	#

	sub xsltFunctionNodeSet($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltFunctionNodeSet(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltFunctionNodeSet')
		{ * };

		_xsltFunctionNodeSet($ctxt, $nargs);
	}

	sub xsltDebug($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltDebug(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltDebug')
		{ * };

		_xsltDebug($ctxt, $node, $inst, $comp);
	}

	sub xsltRegisterExtras(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltRegisterAllExtras() 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/functions.h
	#

	sub xsltXPathFunctionLookup($ctxt, $name, $ns_uri) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltXPathFunctionLookup(xmlXPathContext $ctxt, Str $name, Str $ns_uri) 
			is native(XSLT)
			is symbol('xsltXPathFunctionLookup')
			returns Pointer
		{ * };

		_xsltXPathFunctionLookup($ctxt, $name, $ns_uri);
	}

	sub xsltDocumentFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltDocumentFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltDocumentFunction')
		{ * };

		_xsltDocumentFunction($ctxt, $nargs);
	}

	sub xsltKeyFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltKeyFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltKeyFunction')
		{ * };

		_xsltKeyFunction($ctxt, $nargs);
	}

	sub xsltUnparsedEntityURIFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltUnparsedEntityURIFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltUnparsedEntityURIFunction')
		{ * };

		_xsltUnparsedEntityURIFunction($ctxt, $nargs);
	}

	sub xsltFormatNumberFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltFormatNumberFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltFormatNumberFunction')
		{ * };

		_xsltFormatNumberFunction($ctxt, $nargs);
	}

	sub xsltGenerateIdFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltGenerateIdFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltGenerateIdFunction')
		{ * };

		_xsltGenerateIdFunction($ctxt, $nargs);
	}

	sub xsltSystemPropertyFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltSystemPropertyFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltSystemPropertyFunction')
		{ * };

		_xsltSystemPropertyFunction($ctxt, $nargs);
	}

	sub xsltElementAvailableFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltElementAvailableFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltElementAvailableFunction')
		{ * };

		_xsltElementAvailableFunction($ctxt, $nargs);
	}

	sub xsltFunctionAvailableFunction($ctxt, $nargs) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltFunctionAvailableFunction(xmlXPathParserContext $ctxt, int32 $nargs) 
			is native(XSLT)
			is symbol('xsltFunctionAvailableFunction')
		{ * };

		_xsltFunctionAvailableFunction($ctxt, $nargs);
	}

	sub xsltCleanupIds($ctxt, $root) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCleanupIds(xsltTransformContext $ctxt, xmlNode $root) 
			is native(XSLT)
			is symbol('xsltCleanupIds')
			returns int32
		{ * };

		_xsltCleanupIds($ctxt, $root);
	}

	sub xsltRegisterAllFunctions($ctxt) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRegisterAllFunctions(xmlXPathContext $ctxt) 
			is native(XSLT)
			is symbol('xsltRegisterAllFunctions')
		{ * };

		_xsltRegisterAllFunctions($ctxt);
	}



	# xsltutils
	enum xsltDebugTraceCodes is export (
		XSLT_TRACE_ALL 				=>	-1,
		XSLT_TRACE_NONE 			=>	0,
		XSLT_TRACE_COPY_TEXT 		=>	0b1,
		XSLT_TRACE_PROCESS_NODE 	=>	0b10,
		XSLT_TRACE_APPLY_TEMPLATE 	=>	0b100,
		XSLT_TRACE_COPY 			=>	0b1000,
		XSLT_TRACE_COMMENT 			=>	0b10000,
		XSLT_TRACE_PI 				=>	0b100000,
		XSLT_TRACE_COPY_OF 			=>	0b1000000,
		XSLT_TRACE_VALUE_OF 		=>	0b10000000,
		XSLT_TRACE_CALL_TEMPLATE 	=>	0b100000000,
		XSLT_TRACE_APPLY_TEMPLATES  =>	0b1000000000,
		XSLT_TRACE_CHOOSE 			=>	0b10000000000,
		XSLT_TRACE_IF 				=>	0b100000000000,
		XSLT_TRACE_FOR_EACH 		=>	0b1000000000000,
		XSLT_TRACE_STRIP_SPACES 	=>	0b10000000000000,
		XSLT_TRACE_TEMPLATES 		=>	0b100000000000000,
		XSLT_TRACE_KEYS 			=>	0b1000000000000000,
		XSLT_TRACE_VARIABLES 		=>	0b10000000000000000
	);

	constant XSLT_TIMESTAMP_TICS_PER_SEC is export = 100000;

	enum xsltDebugStatusCodes is export (
	    XSLT_DEBUG_NONE => 0, 
	    'XSLT_DEBUG_INIT',
	    'XSLT_DEBUG_STEP',
	    'XSLT_DEBUG_STEPOUT',
	    'XSLT_DEBUG_NEXT',
	    'XSLT_DEBUG_STOP',
	    'XSLT_DEBUG_CONT',
	    'XSLT_DEBUG_RUN',
	    'XSLT_DEBUG_RUN_RESTART',
	    'XSLT_DEBUG_QUIT'
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
		is native(XSLT)
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
			unless $XSLT_xml_support;

		sub _xsltGetNsProp(xmlNode $node, Str $name, Str $ns) 
			is native(XSLT) 
			is symbol('xsltGetNsProp')
			returns Str
		{ * };
		
		_xsltGetNsProp($node, $name, $ns);
	}

	sub xsltGetCNsProp($sheet, $node, $name, $ns) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $XSLT_xml_support;

		sub _xsltGetCNsProp(
			xsltStylesheet $sheet, 
			xmlNode $node, 
			Str $name, 
			Str $ns
		) 
			is native(XSLT) 
			is symbol('xsltGetCNsProp')
			returns Str
		{ * };

		_xsltGetCNsProp($sheet, $node, $name, $ns);
	}

	sub xsltPrintErrorContext($ctxt, $style, $node) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $XSLT_xml_support;

		sub _xsltPrintErrorContext(
			xsltTransformContext $ctxt, 
			xsltStylesheet $sheet, 
			xmlNode $node
		) 
			is native(XSLT)
			is symbol('xsltPrintErrorContext')
		{ * };

		_xsltPrintErrorContext($ctxt, $style, $node);
	}

	sub xsltMessage($ctxt, $node, $inst) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $XSLT_xml_support;

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
			unless $XSLT_xml_support;

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
			unless $XSLT_xml_support;

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
			unless $XSLT_xml_support;

		sub _xsltDoSortFunction(
			xsltTransformContext $ctxt, 
			xmlNode $node, int32 
			$num
		)
			is native(XSLT)
			is symbol('xsltDoSortFunction')
		{ * };

		_xsltDoSortFunction($ctxt, $nodes, $num)
	}

	sub xsltComputeSortResult($ctxt, $node) is export {
		die "Function requires the XML::LibXML::XPath module"
			unless $XSLT_xml_support;

		sub _xsltComputeSortResult(xsltTransformContext $ctxt, xmlNode $node)
			is native(XSLT)
			is symbol('xsltComputeSortResult')
			returns xmlXPathObject
		{ * };

		_xsltComputeSortResult($ctxt, $node);
	}

	sub xsltSplitQName($dict, $name, $prefix) is export {
		die "Function requires the XML::LibXML::Dict module"
			unless $XSLT_xml_support;

		# cw: Check to insure @prefix is using the right sigil.
		sub _xsltSplitQName(xmlDict $dict, Str $name, CArray[Str] $prefix)
			is native(XSLT)
			is symbol('xsltSplitQName')
			returns Str	
		{ * };

		_xsltSplitQName($dict, $name, $prefix);
	}

	sub xsltGetQNameURI($node, $name) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $XSLT_xml_support;

		sub _xsltGetQNameURI(xmlNode $node, Str $name)
			is native(XSLT)
			is symbol('xsltGetQNameURI')
			returns Str	
		{ * };

		_xsltGetQNameURI($node, $name);
	}

	sub xsltGetQNameURI2($style, $node, $name) is export {
		die "Function requires the XML::LibXML::Node module"
			unless $XSLT_xml_support;

		sub _xsltGetQNameURI(xsltStylesheet $style, xmlNode $node, Str $name)
			is native(XSLT)
			is symbol('xsltGetQNameURI2')
			returns Str	
		{ * };

		_xsltGetQNameURI($style, $node, $name);
	}

	sub xsltSaveResultTo($buf, $result, $style) is export {
		die "Function requires the XML::LibXML package"
			unless $XSLT_xml_support;

		sub _xsltSaveResultTo(
			xmlOutputBuffer $buf,
			xmlDoc $result,
			xsltStylesheet $style
		)
			is native(XSLT)
			is symbol('xsltSaveResultTo')
			returns int32
		{ * };

		_xsltSaveResultTo($buf, $result, $style);
	}

	sub xsltSaveResultToFilename($uri, $result, $style, $comp) is export {
		die "Function requires the XML::LibXML package"
			unless $XSLT_xml_support;

		sub _xsltSaveResultToFilename(
			Str $uri,
			xmlDoc $result,
			xsltStylesheet $style,
			int32 $comp
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFilename')
			returns int32
		{ * };

		_xsltSaveResultToFilename($uri, $result, $style, $comp);
	}


	sub xsltSaveResultToFile($file, $result, $style) {
		die "Function requires the XML::LibXML package"
			unless $XSLT_xml_support;

		die "Must pass an IO::Handle as the first parameter!"
			unless $file ~~ File::Handle;

		my $fd = fdopen($file.native-descriptor, "w");

		sub _xsltSaveResultToFile(
			Pointer $fd,
			xmlDoc $result,
			xsltStylesheet $style
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFile')
			returns int32
		{ * };
	
		_xsltSaveResultToFile($fd, $result, $style);
	}

	sub xsltSaveResultToFd($fd, $result, $style) is export {
		die "Function requires the XML::LibXML package"
			unless $XSLT_xml_support;

		sub _xsltSaveResultToFd(
			int32 $fd,
			xmlDoc $result,
			xsltStylesheet $style
		)
			is native(XSLT)
			is symbol('xsltSaveResultToFd')
			returns int32
		{ * };

		_xsltSaveResultToFd($fd, $result, $style);
	}

	sub xsltSaveResultToString($out is rw, $len is rw, $result, $style) 
		is export
	{
		die "Function requires the XML::LibXML package"
			unless $XSLT_xml_support;

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
			unless $XSLT_xml_support;

		sub _xsltXPathCompile(xsltStylesheet $style, Str $str)
			is native(XSLT)
			is symbol('xsltXPathCompile')
			returns Pointer
		{ * };

		_xsltXPathCompile($style, $str);
	}

	sub xsltXPathCompileFlags($style, $str, $flags) is export {
		die "Function requires the XML::LibXML::XPath module"
			unless $XSLT_xml_support;

		sub _xsltXPathCompileFlags(xsltStylesheet $style, Str $str, int32 $flags)
			is native(XSLT)
			is symbol('xsltXPathCompileFlags')
			returns Pointer
		{ * };

		_xsltXPathCompileFlags($style, $str, $flags);
	}

	sub xsltSaveProfiling($ctxt, $output) {
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
			unless $XSLT_xml_support;

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
			unless $XSLT_xml_support;

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