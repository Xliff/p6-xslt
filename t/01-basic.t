use v6.c;

use NativeCall;

use XML::LibXML::CStructs;
use XML::LibXML::Parser;
use XML::LibXSLT::Subs;

my $parser = XML::LibXML::Parser.new;
my $doc = $parser.parse(qq:to/XML/);
<?xml version="1.0"?>
  <dromedaries>
    <species name="Camel">
      <humps>1 or 2</humps>
      <disposition>Cranky</disposition>
    </species>
    <species name="Llama">
      <humps>1 (sort of)</humps>
      <disposition>Aloof</disposition>
    </species>
    <species name="Alpaca">
      <humps>(see Llama)</humps>
      <disposition>Friendly</disposition>
    </species>
</dromedaries>
XML

my $stylesheet_doc = $parser.parse(qq:to/XSL/);
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:fo="http://www.w3.org/1999/XSL/Format">
<xsl:template match="/">
  <html>
  <head><title>Know Your Dromedaries</title></head>
  <body>
    <table bgcolor="#eeeeee" border="1">
    <tr>
    <th>Species</th>
    <th>No of Humps</th>
    <th>Disposition</th>
    </tr>
    <xsl:for-each select="dromedaries">
      <xsl:apply-templates select="./species" />
    </xsl:for-each>
  </table>
  </body>
  </html>
</xsl:template>

<xsl:template match="species">
  <tr>
  <td><xsl:value-of select="@name" /></td>
  <td><xsl:value-of select="humps" /></td>
  <td><xsl:value-of select="disposition" /></td>
  </tr>
</xsl:template>

</xsl:stylesheet>
XSL

# --------------------------------------
# cw: To add to XML::LibXML!!
# --------------------------------------
sub xmlAllocOutputBuffer(Pointer $encoder) 
	is native('xml')
	returns xmlBuffer
{ * }

sub xmlOutputBufferGetContent(xmlBuffer $out) 
	is native('xml')
	returns Str
{ * }
# --------------------------------------

#my $stylesheet = xsltParseStylesheetDoc($stylesheet_doc);
#my $transform = xsltApplyStylesheet($stylesheet, $doc, Str);
#my $buffer = xmlAllocOutputBuffer(xmlCharEncodingHandler);
#xsltSaveResultTo($buffer, $transform, $stylesheet);
#my $output = xmlOutputBufferGetContent($buffer);

#say $buffer;

# cw: XXX - Handle proper deallocation
