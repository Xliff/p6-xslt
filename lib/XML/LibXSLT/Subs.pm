use v6.c;

use NativeCall;

use XML::LibXSLT::Types;

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

	sub xsltSetLoaderFunc(Pointer $f) 
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

		sub _xsltInitElemPreComp(xsltElemPreComp $comp, xsltStylesheet $style, xmlNode $inst, Pointer $function, Pointer $freeFunc) 
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

	#
	# /usr/include/libxslt/imports.h
	#

	sub xsltParseStylesheetImport($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetImport(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetImport')
			returns int32
		{ * };

		_xsltParseStylesheetImport($style, $cur);
	}

	sub xsltParseStylesheetInclude($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetInclude(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetInclude')
			returns int32
		{ * };

		_xsltParseStylesheetInclude($style, $cur);
	}

	sub xsltNextImport(xsltStylesheet $style) 
		is native(XSLT)
		is export
		returns xsltStylesheet
	{ * };

	sub xsltNeedElemSpaceHandling(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFindElemSpaceHandling($ctxt, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltFindElemSpaceHandling(xsltTransformContext $ctxt, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltFindElemSpaceHandling')
			returns int32
		{ * };

		_xsltFindElemSpaceHandling($ctxt, $node);
	}

	sub xsltFindTemplate(xsltTransformContext $ctxt, Str $name, Str $nameURI) 
		is native(XSLT)
		is export
		returns xsltTemplate
	{ * };

	#
	# /usr/include/libxslt/keys.h
	#

	sub xsltAddKey($style, $name, $nameURI, $match, $use, $inst) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltAddKey(xsltStylesheet $style, Str $name, Str $nameURI, Str $match, Str $use, xmlNode $inst) 
			is native(XSLT)
			is symbol('xsltAddKey')
			returns int32
		{ * };

		_xsltAddKey($style, $name, $nameURI, $match, $use, $inst);
	}

	sub xsltGetKey(xsltTransformContext $ctxt, Str $name, Str $nameURI, Str $value) 
		is native(XSLT)
		is export
		returns xmlNodeSet
	{ * };

	sub xsltInitCtxtKeys(xsltTransformContext $ctxt, xsltDocument $doc) 
		is native(XSLT)
		is export
	{ * };

	sub xsltFreeKeys(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltFreeDocumentKeys(xsltDocument $doc) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/namespaces.h
	#

	sub xsltNamespaceAlias($style, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNamespaceAlias(xsltStylesheet $style, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltNamespaceAlias')
		{ * };

		_xsltNamespaceAlias($style, $node);
	}

	sub xsltGetNamespace($ctxt, $cur, $ns, $out) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltGetNamespace(xsltTransformContext $ctxt, xmlNode $cur, xmlNs $ns, xmlNode $out) 
			is native(XSLT)
			is symbol('xsltGetNamespace')
			returns xmlNs
		{ * };

		_xsltGetNamespace($ctxt, $cur, $ns, $out);
	}

	sub xsltGetPlainNamespace($ctxt, $cur, $ns, $out) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltGetPlainNamespace(xsltTransformContext $ctxt, xmlNode $cur, xmlNs $ns, xmlNode $out) 
			is native(XSLT)
			is symbol('xsltGetPlainNamespace')
			returns xmlNs
		{ * };

		_xsltGetPlainNamespace($ctxt, $cur, $ns, $out);
	}

	sub xsltGetSpecialNamespace($ctxt, $cur, $URI, $prefix, $out) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltGetSpecialNamespace(xsltTransformContext $ctxt, xmlNode $cur, Str $URI, Str $prefix, xmlNode $out) 
			is native(XSLT)
			is symbol('xsltGetSpecialNamespace')
			returns xmlNs
		{ * };

		_xsltGetSpecialNamespace($ctxt, $cur, $URI, $prefix, $out);
	}

	sub xsltCopyNamespace($ctxt, $elem, $ns) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCopyNamespace(xsltTransformContext $ctxt, xmlNode $elem, xmlNs $ns) 
			is native(XSLT)
			is symbol('xsltCopyNamespace')
			returns xmlNs
		{ * };

		_xsltCopyNamespace($ctxt, $elem, $ns);
	}

	sub xsltCopyNamespaceList($ctxt, $node, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCopyNamespaceList(xsltTransformContext $ctxt, xmlNode $node, xmlNs $cur) 
			is native(XSLT)
			is symbol('xsltCopyNamespaceList')
			returns xmlNs
		{ * };

		_xsltCopyNamespaceList($ctxt, $node, $cur);
	}

	sub xsltFreeNamespaceAliasHashes(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/pattern.h
	#

	sub xsltCompilePattern($pattern, $doc, $node, $style, $runtime) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCompilePattern(Str $pattern, xmlDoc $doc, xmlNode $node, xsltStylesheet $style, xsltTransformContext $runtime) 
			is native(XSLT)
			is symbol('xsltCompilePattern')
			returns Pointer
		{ * };

		_xsltCompilePattern($pattern, $doc, $node, $style, $runtime);
	}

	sub xsltFreeCompMatchList(Pointer $comp) 
		is native(XSLT)
		is export
	{ * };

	sub xsltTestCompMatchList($ctxt, $node, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltTestCompMatchList(xsltTransformContext $ctxt, xmlNode $node, Pointer $comp) 
			is native(XSLT)
			is symbol('xsltTestCompMatchList')
			returns int32
		{ * };

		_xsltTestCompMatchList($ctxt, $node, $comp);
	}

	sub xsltNormalizeCompSteps(Pointer $payload, Pointer $data, Str $name) 
		is native(XSLT)
		is export
	{ * };

	sub xsltAddTemplate(xsltStylesheet $style, xsltTemplate $cur, Str $mode, Str $modeURI) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltGetTemplate($ctxt, $node, $style) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltGetTemplate(xsltTransformContext $ctxt, xmlNode $node, xsltStylesheet $style) 
			is native(XSLT)
			is symbol('xsltGetTemplate')
			returns xsltTemplate
		{ * };

		_xsltGetTemplate($ctxt, $node, $style);
	}

	sub xsltFreeTemplateHashes(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltCleanupTemplates(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/preproc.h
	#

	sub xsltDocumentComp($style, $inst, $function) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltDocumentComp(xsltStylesheet $style, xmlNode $inst, Pointer $function) 
			is native(XSLT)
			is symbol('xsltDocumentComp')
			returns xsltElemPreComp
		{ * };

		_xsltDocumentComp($style, $inst, $function);
	}

	sub xsltStylePreCompute($style, $inst) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltStylePreCompute(xsltStylesheet $style, xmlNode $inst) 
			is native(XSLT)
			is symbol('xsltStylePreCompute')
		{ * };

		_xsltStylePreCompute($style, $inst);
	}

	sub xsltFreeStylePreComps(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/security.h
	#

	enum xsltSecurityOption is export (
	    XSLT_SECPREF_READ_FILE => 1,
	    'XSLT_SECPREF_WRITE_FILE',
	    'XSLT_SECPREF_CREATE_DIRECTORY',
	    'XSLT_SECPREF_READ_NETWORK',
	    'XSLT_SECPREF_WRITE_NETWORK'
	);

	sub xsltNewSecurityPrefs() 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltFreeSecurityPrefs(Pointer $sec) 
		is native(XSLT)
		is export
	{ * };

	sub xsltSetSecurityPrefs(Pointer $sec, int32 $option, Pointer $func) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltGetSecurityPrefs(Pointer $sec, int32 $option) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltSetDefaultSecurityPrefs(Pointer $sec) 
		is native(XSLT)
		is export
	{ * };

	sub xsltGetDefaultSecurityPrefs() 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltSetCtxtSecurityPrefs(Pointer $sec, xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltSecurityAllow(Pointer $sec, xsltTransformContext $ctxt, Str $value) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltSecurityForbid(Pointer $sec, xsltTransformContext $ctxt, Str $value) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltCheckWrite(Pointer $sec, xsltTransformContext $ctxt, Str $URL) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltCheckRead(Pointer $sec, xsltTransformContext $ctxt, Str $URL) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	#
	# /usr/include/libxslt/templates.h
	#

	sub xsltEvalXPathPredicate($ctxt, $comp, $nsList, $nsNr) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalXPathPredicate(xsltTransformContext $ctxt, xmlXPathCompExpr $comp, xmlNs $nsList, int32 $nsNr) 
			is native(XSLT)
			is symbol('xsltEvalXPathPredicate')
			returns int32
		{ * };

		_xsltEvalXPathPredicate($ctxt, $comp, $nsList, $nsNr);
	}

	sub xsltEvalTemplateString($ctxt, $contextNode, $inst) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalTemplateString(xsltTransformContext $ctxt, xmlNode $contextNode, xmlNode $inst) 
			is native(XSLT)
			is symbol('xsltEvalTemplateString')
			returns Str
		{ * };

		_xsltEvalTemplateString($ctxt, $contextNode, $inst);
	}

	sub xsltEvalAttrValueTemplate($ctxt, $node, $name, $ns) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalAttrValueTemplate(xsltTransformContext $ctxt, xmlNode $node, Str $name, Str $ns) 
			is native(XSLT)
			is symbol('xsltEvalAttrValueTemplate')
			returns Str
		{ * };

		_xsltEvalAttrValueTemplate($ctxt, $node, $name, $ns);
	}

	sub xsltEvalStaticAttrValueTemplate($style, $node, $name, $ns, $found) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalStaticAttrValueTemplate(xsltStylesheet $style, xmlNode $node, Str $name, Str $ns, int32 $found) 
			is native(XSLT)
			is symbol('xsltEvalStaticAttrValueTemplate')
			returns Str
		{ * };

		_xsltEvalStaticAttrValueTemplate($style, $node, $name, $ns, $found);
	}

	sub xsltEvalXPathString($ctxt, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalXPathString(xsltTransformContext $ctxt, xmlXPathCompExpr $comp) 
			is native(XSLT)
			is symbol('xsltEvalXPathString')
			returns Str
		{ * };

		_xsltEvalXPathString($ctxt, $comp);
	}

	sub xsltEvalXPathStringNs($ctxt, $comp, $nsNr, $nsList) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalXPathStringNs(xsltTransformContext $ctxt, xmlXPathCompExpr $comp, int32 $nsNr, xmlNs $nsList) 
			is native(XSLT)
			is symbol('xsltEvalXPathStringNs')
			returns Str
		{ * };

		_xsltEvalXPathStringNs($ctxt, $comp, $nsNr, $nsList);
	}

	sub xsltTemplateProcess($ctxt, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltTemplateProcess(xsltTransformContext $ctxt, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltTemplateProcess')
			returns xmlNode
		{ * };

		_xsltTemplateProcess($ctxt, $node);
	}

	sub xsltAttrListTemplateProcess($ctxt, $target, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltAttrListTemplateProcess(xsltTransformContext $ctxt, xmlNode $target, xmlAttr $cur) 
			is native(XSLT)
			is symbol('xsltAttrListTemplateProcess')
			returns xmlAttr
		{ * };

		_xsltAttrListTemplateProcess($ctxt, $target, $cur);
	}

	sub xsltAttrTemplateProcess($ctxt, $target, $attr) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltAttrTemplateProcess(xsltTransformContext $ctxt, xmlNode $target, xmlAttr $attr) 
			is native(XSLT)
			is symbol('xsltAttrTemplateProcess')
			returns xmlAttr
		{ * };

		_xsltAttrTemplateProcess($ctxt, $target, $attr);
	}

	sub xsltAttrTemplateValueProcess(xsltTransformContext $ctxt, Str $attr) 
		is native(XSLT)
		is export
		returns Str
	{ * };

	sub xsltAttrTemplateValueProcessNode($ctxt, $str, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltAttrTemplateValueProcessNode(xsltTransformContext $ctxt, Str $str, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltAttrTemplateValueProcessNode')
			returns Str
		{ * };

		_xsltAttrTemplateValueProcessNode($ctxt, $str, $node);
	}

	#
	# /usr/include/libxslt/transform.h
	#

	sub xsltSetXIncludeDefault(int32 $xinclude) 
		is native(XSLT)
		is export
	{ * };

	sub xsltGetXIncludeDefault() 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltNewTransformContext($style, $doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNewTransformContext(xsltStylesheet $style, xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltNewTransformContext')
			returns xsltTransformContext
		{ * };

		_xsltNewTransformContext($style, $doc);
	}

	sub xsltFreeTransformContext(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltApplyStylesheetUser($style, $doc, $params, $output, $profile, $userCtxt) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyStylesheetUser(xsltStylesheet $style, xmlDoc $doc, CArray[Str] $params, Str $output, Pointer $profile, xsltTransformContext $userCtxt) 
			is native(XSLT)
			is symbol('xsltApplyStylesheetUser')
			returns xmlDoc
		{ * };

		_xsltApplyStylesheetUser($style, $doc, $params, $output, $profile, $userCtxt);
	}

	sub xsltProcessOneNode($ctxt, $node, $params) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltProcessOneNode(xsltTransformContext $ctxt, xmlNode $node, xsltStackElem $params) 
			is native(XSLT)
			is symbol('xsltProcessOneNode')
		{ * };

		_xsltProcessOneNode($ctxt, $node, $params);
	}

	sub xsltApplyStripSpaces($ctxt, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyStripSpaces(xsltTransformContext $ctxt, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltApplyStripSpaces')
		{ * };

		_xsltApplyStripSpaces($ctxt, $node);
	}

	sub xsltApplyStylesheet($style, $doc, $params) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyStylesheet(xsltStylesheet $style, xmlDoc $doc, Str $params) 
			is native(XSLT)
			is symbol('xsltApplyStylesheet')
			returns xmlDoc
		{ * };

		_xsltApplyStylesheet($style, $doc, $params);
	}

	sub xsltProfileStylesheet($style, $doc, $params, $output) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltProfileStylesheet(xsltStylesheet $style, xmlDoc $doc, Str $params, Pointer $output) 
			is native(XSLT)
			is symbol('xsltProfileStylesheet')
			returns xmlDoc
		{ * };

		_xsltProfileStylesheet($style, $doc, $params, $output);
	}

	sub xsltRunStylesheet($style, $doc, $params, $output, $SAX, $IObuf) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRunStylesheet(xsltStylesheet $style, xmlDoc $doc, Str $params, Str $output, xmlSAXHandler $SAX, xmlOutputBuffer $IObuf) 
			is native(XSLT)
			is symbol('xsltRunStylesheet')
			returns int32
		{ * };

		_xsltRunStylesheet($style, $doc, $params, $output, $SAX, $IObuf);
	}

	sub xsltRunStylesheetUser($style, $doc, $params, $output, $SAX, $IObuf, $profile, $userCtxt) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRunStylesheetUser(xsltStylesheet $style, xmlDoc $doc, Str $params, Str $output, xmlSAXHandler $SAX, xmlOutputBuffer $IObuf, Pointer $profile, xsltTransformContext $userCtxt) 
			is native(XSLT)
			is symbol('xsltRunStylesheetUser')
			returns int32
		{ * };

		_xsltRunStylesheetUser($style, $doc, $params, $output, $SAX, $IObuf, $profile, $userCtxt);
	}

	sub xsltApplyOneTemplate($ctxt, $node, $list, $templ, $params) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyOneTemplate(xsltTransformContext $ctxt, xmlNode $node, xmlNode $list, xsltTemplate $templ, xsltStackElem $params) 
			is native(XSLT)
			is symbol('xsltApplyOneTemplate')
		{ * };

		_xsltApplyOneTemplate($ctxt, $node, $list, $templ, $params);
	}

	sub xsltDocumentElem($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltDocumentElem(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltDocumentElem')
		{ * };

		_xsltDocumentElem($ctxt, $node, $inst, $comp);
	}

	sub xsltSort($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltSort(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltSort')
		{ * };

		_xsltSort($ctxt, $node, $inst, $comp);
	}

	sub xsltCopy($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCopy(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltCopy')
		{ * };

		_xsltCopy($ctxt, $node, $inst, $comp);
	}

	sub xsltText($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltText(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltText')
		{ * };

		_xsltText($ctxt, $node, $inst, $comp);
	}

	sub xsltElement($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltElement(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltElement')
		{ * };

		_xsltElement($ctxt, $node, $inst, $comp);
	}

	sub xsltComment($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltComment(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltComment')
		{ * };

		_xsltComment($ctxt, $node, $inst, $comp);
	}

	sub xsltAttribute($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltAttribute(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltAttribute')
		{ * };

		_xsltAttribute($ctxt, $node, $inst, $comp);
	}

	sub xsltProcessingInstruction($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltProcessingInstruction(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltProcessingInstruction')
		{ * };

		_xsltProcessingInstruction($ctxt, $node, $inst, $comp);
	}

	sub xsltCopyOf($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCopyOf(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltCopyOf')
		{ * };

		_xsltCopyOf($ctxt, $node, $inst, $comp);
	}

	sub xsltValueOf($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltValueOf(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltValueOf')
		{ * };

		_xsltValueOf($ctxt, $node, $inst, $comp);
	}

	sub xsltNumber($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNumber(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltNumber')
		{ * };

		_xsltNumber($ctxt, $node, $inst, $comp);
	}

	sub xsltApplyImports($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyImports(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltApplyImports')
		{ * };

		_xsltApplyImports($ctxt, $node, $inst, $comp);
	}

	sub xsltCallTemplate($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCallTemplate(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltCallTemplate')
		{ * };

		_xsltCallTemplate($ctxt, $node, $inst, $comp);
	}

	sub xsltApplyTemplates($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltApplyTemplates(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltApplyTemplates')
		{ * };

		_xsltApplyTemplates($ctxt, $node, $inst, $comp);
	}

	sub xsltChoose($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltChoose(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltChoose')
		{ * };

		_xsltChoose($ctxt, $node, $inst, $comp);
	}

	sub xsltIf($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltIf(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltIf')
		{ * };

		_xsltIf($ctxt, $node, $inst, $comp);
	}

	sub xsltForEach($ctxt, $node, $inst, $comp) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltForEach(xsltTransformContext $ctxt, xmlNode $node, xmlNode $inst, xsltStylePreComp $comp) 
			is native(XSLT)
			is symbol('xsltForEach')
		{ * };

		_xsltForEach($ctxt, $node, $inst, $comp);
	}

	sub xsltRegisterAllElement(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltCopyTextString($ctxt, $target, $string, $noescape) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCopyTextString(xsltTransformContext $ctxt, xmlNode $target, Str $string, int32 $noescape) 
			is native(XSLT)
			is symbol('xsltCopyTextString')
			returns xmlNode
		{ * };

		_xsltCopyTextString($ctxt, $target, $string, $noescape);
	}

	sub xsltLocalVariablePop(xsltTransformContext $ctxt, int32 $limitNr, int32 $level) 
		is native(XSLT)
		is export
	{ * };

	sub xsltLocalVariablePush(xsltTransformContext $ctxt, xsltStackElem $variable, int32 $level) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xslHandleDebugger($cur, $node, $templ, $ctxt) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xslHandleDebugger(xmlNode $cur, xmlNode $node, xsltTemplate $templ, xsltTransformContext $ctxt) 
			is native(XSLT)
			is symbol('xslHandleDebugger')
		{ * };

		_xslHandleDebugger($cur, $node, $templ, $ctxt);
	}

	#
	# /usr/include/libxslt/variables.h
	#

	sub xsltEvalGlobalVariables(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltEvalUserParams(xsltTransformContext $ctxt, Str $params) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltQuoteUserParams(xsltTransformContext $ctxt, Str $params) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltEvalOneUserParam(xsltTransformContext $ctxt, Str $name, Str $value) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltQuoteOneUserParam(xsltTransformContext $ctxt, Str $name, Str $value) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltParseGlobalVariable($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseGlobalVariable(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseGlobalVariable')
		{ * };

		_xsltParseGlobalVariable($style, $cur);
	}

	sub xsltParseGlobalParam($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseGlobalParam(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseGlobalParam')
		{ * };

		_xsltParseGlobalParam($style, $cur);
	}

	sub xsltParseStylesheetVariable($ctxt, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetVariable(xsltTransformContext $ctxt, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetVariable')
		{ * };

		_xsltParseStylesheetVariable($ctxt, $cur);
	}

	sub xsltParseStylesheetParam($ctxt, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetParam(xsltTransformContext $ctxt, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetParam')
		{ * };

		_xsltParseStylesheetParam($ctxt, $cur);
	}

	sub xsltParseStylesheetCallerParam($ctxt, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetCallerParam(xsltTransformContext $ctxt, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetCallerParam')
			returns xsltStackElem
		{ * };

		_xsltParseStylesheetCallerParam($ctxt, $cur);
	}

	sub xsltAddStackElemList(xsltTransformContext $ctxt, xsltStackElem $elems) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFreeGlobalVariables(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltVariableLookup(xsltTransformContext $ctxt, Str $name, Str $ns_uri) 
		is native(XSLT)
		is export
		returns xmlXPathObject
	{ * };

	sub xsltXPathVariableLookup(Pointer $ctxt, Str $name, Str $ns_uri) 
		is native(XSLT)
		is export
		returns xmlXPathObject
	{ * };

	#
	# /usr/include/libxslt/xslt.h
	#

	sub xsltInit() 
		is native(XSLT)
		is export
	{ * };

	sub xsltCleanupGlobals() 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/xsltlocale.h
	#

	sub xsltNewLocale(Str $langName) 
		is native(XSLT)
		is export
		returns Pointer
	{ * };

	sub xsltFreeLocale(Pointer $locale) 
		is native(XSLT)
		is export
	{ * };

	sub xsltStrxfrm(Pointer $locale, Str $string) 
		is native(XSLT)
		is export
		returns Str
	{ * };

	sub xsltLocaleStrcmp(Pointer $locale, Str $str1, Str $str2) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFreeLocales() 
		is native(XSLT)
		is export
	{ * };

	#
	# /usr/include/libxslt/xsltInternals.h
	#

	sub xsltPointerListCreate(int32 $initialSize) 
		is native(XSLT)
		is export
		returns xsltPointerList
	{ * };

	sub xsltPointerListFree(xsltPointerList $list) 
		is native(XSLT)
		is export
	{ * };

	sub xsltPointerListClear(xsltPointerList $list) 
		is native(XSLT)
		is export
	{ * };

	sub xsltPointerListAddSize(xsltPointerList $list, Pointer $item, int32 $initialSize) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltNewStylesheet() 
		is native(XSLT)
		is export
		returns xsltStylesheet
	{ * };

	sub xsltParseStylesheetFile(Str $filename) 
		is native(XSLT)
		is export
		returns xsltStylesheet
	{ * };

	sub xsltFreeStylesheet(xsltStylesheet $style) 
		is native(XSLT)
		is export
	{ * };

	sub xsltIsBlank(Str $str) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFreeStackElemList(xsltStackElem $elem) 
		is native(XSLT)
		is export
	{ * };

	sub xsltDecimalFormatGetByName(xsltStylesheet $style, Str $name) 
		is native(XSLT)
		is export
		returns xsltDecimalFormat
	{ * };

	sub xsltParseStylesheetProcess($ret, $doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetProcess(xsltStylesheet $ret, xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltParseStylesheetProcess')
			returns xsltStylesheet
		{ * };

		_xsltParseStylesheetProcess($ret, $doc);
	}

	sub xsltParseStylesheetOutput($style, $cur) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetOutput(xsltStylesheet $style, xmlNode $cur) 
			is native(XSLT)
			is symbol('xsltParseStylesheetOutput')
		{ * };

		_xsltParseStylesheetOutput($style, $cur);
	}

	sub xsltParseStylesheetDoc($doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetDoc(xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltParseStylesheetDoc')
			returns xsltStylesheet
		{ * };

		_xsltParseStylesheetDoc($doc);
	}

	sub xsltParseStylesheetImportedDoc($doc, $style) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseStylesheetImportedDoc(xmlDoc $doc, xsltStylesheet $style) 
			is native(XSLT)
			is symbol('xsltParseStylesheetImportedDoc')
			returns xsltStylesheet
		{ * };

		_xsltParseStylesheetImportedDoc($doc, $style);
	}

	sub xsltLoadStylesheetPI($doc) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltLoadStylesheetPI(xmlDoc $doc) 
			is native(XSLT)
			is symbol('xsltLoadStylesheetPI')
			returns xsltStylesheet
		{ * };

		_xsltLoadStylesheetPI($doc);
	}

	sub xsltNumberFormat($ctxt, $data, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltNumberFormat(xsltTransformContext $ctxt, xsltNumberData $data, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltNumberFormat')
		{ * };

		_xsltNumberFormat($ctxt, $data, $node);
	}

	# cw: Return value should be converted to xmlXPathError enum.
	sub xsltFormatNumberConversion(xsltDecimalFormat $self, Str $format, num64 $number, CArray[Str] $result) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltParseTemplateContent($style, $templ) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltParseTemplateContent(xsltStylesheet $style, xmlNode $templ) 
			is native(XSLT)
			is symbol('xsltParseTemplateContent')
		{ * };

		_xsltParseTemplateContent($style, $templ);
	}

	sub xsltAllocateExtra(xsltStylesheet $style) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltAllocateExtraCtxt(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltCreateRVT(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns xmlDoc
	{ * };

	sub xsltRegisterTmpRVT($ctxt, $RVT) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRegisterTmpRVT(xsltTransformContext $ctxt, xmlDoc $RVT) 
			is native(XSLT)
			is symbol('xsltRegisterTmpRVT')
			returns int32
		{ * };

		_xsltRegisterTmpRVT($ctxt, $RVT);
	}

	sub xsltRegisterLocalRVT($ctxt, $RVT) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRegisterLocalRVT(xsltTransformContext $ctxt, xmlDoc $RVT) 
			is native(XSLT)
			is symbol('xsltRegisterLocalRVT')
			returns int32
		{ * };

		_xsltRegisterLocalRVT($ctxt, $RVT);
	}

	sub xsltRegisterPersistRVT($ctxt, $RVT) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltRegisterPersistRVT(xsltTransformContext $ctxt, xmlDoc $RVT) 
			is native(XSLT)
			is symbol('xsltRegisterPersistRVT')
			returns int32
		{ * };

		_xsltRegisterPersistRVT($ctxt, $RVT);
	}

	sub xsltExtensionInstructionResultRegister($ctxt, $obj) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltExtensionInstructionResultRegister(xsltTransformContext $ctxt, xmlXPathObject $obj) 
			is native(XSLT)
			is symbol('xsltExtensionInstructionResultRegister')
			returns int32
		{ * };

		_xsltExtensionInstructionResultRegister($ctxt, $obj);
	}

	sub xsltExtensionInstructionResultFinalize(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltFreeRVTs(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltReleaseRVT($ctxt, $RVT) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltReleaseRVT(xsltTransformContext $ctxt, xmlDoc $RVT) 
			is native(XSLT)
			is symbol('xsltReleaseRVT')
		{ * };

		_xsltReleaseRVT($ctxt, $RVT);
	}

	sub xsltCompileAttr($style, $attr) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltCompileAttr(xsltStylesheet $style, xmlAttr $attr) 
			is native(XSLT)
			is symbol('xsltCompileAttr')
		{ * };

		_xsltCompileAttr($style, $attr);
	}

	sub xsltEvalAVT($ctxt, $avt, $node) {
		die 'Function requires XML::LibXML' unless $XSLT_xml_support;

		sub _xsltEvalAVT(xsltTransformContext $ctxt, Pointer $avt, xmlNode $node) 
			is native(XSLT)
			is symbol('xsltEvalAVT')
			returns Str
		{ * };

		_xsltEvalAVT($ctxt, $avt, $node);
	}

	sub xsltFreeAVTList(Pointer $avt) 
		is native(XSLT)
		is export
	{ * };

	sub xsltUninit() 
		is native(XSLT)
		is export
	{ * };

	# cw: Part of XSLT refactor, which is not included.
	#
	# sub xsltParseSequenceConstructor($cctxt, $start) {
	# 	die 'Function requires XML::LibXML' unless $XSLT_xml_support;

	# 	sub _xsltParseSequenceConstructor(xsltCompilerCtxt $cctxt, xmlNode $start) 
	# 		is native(XSLT)
	# 		is symbol('xsltParseSequenceConstructor')
	# 	{ * };

	# 	_xsltParseSequenceConstructor($cctxt, $start);
	# }

	# sub xsltParseAnyXSLTElem($cctxt, $elem) {
	# 	die 'Function requires XML::LibXML' unless $XSLT_xml_support;

	# 	sub _xsltParseAnyXSLTElem(xsltCompilerCtxt $cctxt, xmlNode $elem) 
	# 		is native(XSLT)
	# 		is symbol('xsltParseAnyXSLTElem')
	# 		returns int32
	# 	{ * };

	# 	_xsltParseAnyXSLTElem($cctxt, $elem);
	# }

	# sub xsltRestoreDocumentNamespaces($ns, $doc) {
	# 	die 'Function requires XML::LibXML' unless $XSLT_xml_support;

	# 	sub _xsltRestoreDocumentNamespaces(xsltNsMap $ns, xmlDoc $doc) 
	# 		is native(XSLT)
	# 		is symbol('xsltRestoreDocumentNamespaces')
	# 		returns int32
	# 	{ * };

	# 	_xsltRestoreDocumentNamespaces($ns, $doc);
	# }

	sub xsltInitCtxtKey(xsltTransformContext $ctxt, xsltDocument $doc, xsltKeyDef $keyd) 
		is native(XSLT)
		is export
		returns int32
	{ * };

	sub xsltInitAllDocKeys(xsltTransformContext $ctxt) 
		is native(XSLT)
		is export
		returns int32
	{ * };


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