<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://bentoweb.org/refs/TCDL1.1"
  xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xsi:schemaLocation="
    http://bentoweb.org/refs/TCDL1.1 http://bentoweb.org/refs/schemas/tcdl1.1.xsd
    http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd
    http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd
    http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd"
  exclude-result-prefixes="btw">

<xsl:template match="/">
<testCaseDescription id="{/btw:testCaseDescription/@id}">
  <xsl:if test="@xml:lang">
    <xsl:attribute name="xml:lang"><xsl:value-of select="/btw:testCaseDescription/@xml:lang"/></xsl:attribute>
  </xsl:if>
  <xsl:attribute name="xsi:schemaLocation">
    <!-- http://bentoweb.org/refs/TCDL1 http://bentoweb.org/refs/schemas/tcdl1.xsd  not needed here -->
    <xsl:text disable-output-escaping="yes">http://bentoweb.org/refs/TCDL1.1 http://bentoweb.org/refs/schemas/tcdl1.1.xsd http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd</xsl:text>
  </xsl:attribute>
<xsl:text>
</xsl:text>
  <xsl:apply-templates />
</testCaseDescription>
</xsl:template>


<!-- By default, copy all elements and attributes, but comments are handled separately. -->
<xsl:template match="@* | node()[not(comment())]">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
</xsl:template>

<!-- @@ For some mysterious reason, the previous template skips a few elements. -->
<xsl:template match="btw:formalMetadata | btw:experience | btw:rules">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
</xsl:template>


<!-- Note that the XML parser is not required to pass comments along to the application; 
  switch to antoher XML parser if comments don't show up in the result tree.
-->
<xsl:template match="comment()">
  <xsl:copy />
  <!-- Both rules appear to have the same effect. -->
  <!--xsl:comment xml:space="preserve"><xsl:value-of select="." /></xsl:comment-->
</xsl:template>

<xsl:template match="processing-instruction()">
  <xsl:copy />
</xsl:template>

</xsl:stylesheet>