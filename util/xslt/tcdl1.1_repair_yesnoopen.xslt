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
<!--
  Stylesheet that repairs yesNoOpenQuestion elements.
  This stylesheet should only run AFTER 'tcdl1.1_repair.xslt'!
  Author: Christophe Strobbe
  
  See also
  'XSLT Utility Stylesheets': http://www.xml.com/pub/a/2004/04/07/tr.html
  'XSLT, Comments and Processing Instructions': http://www.xml.com/pub/a/2000/09/13/xslt/index.html
-->
<xsl:include href="tcdl1.1_repair_shared.xslt"/>

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>

<xsl:strip-space elements="btw:*"/>

<!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
<xsl:param name="DEBUG" select="'false'" />


<!-- @@ For some mysterious reason, the general copy template skips a number of elements. -->
<xsl:template match="btw:questions | btw:openQuestion">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
</xsl:template>


<!-- Delete optionOther elements that contain only a placeholder. -->
<xsl:template match="btw:yesNoOpenQuestion[ btw:optionOther[btw:p[normalize-space(text()) = '@placeholder']] ] | btw:yesNoOpenQuestion[btw:optionOther[not( node() )]] | btw:yesNoOpenQuestion[btw:optionOther[count(btw:p) = 1][btw:p[not( node() )]]]">
  <xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ removed empty optionOther or optionOther with placeholder! </xsl:comment></xsl:if>
  <yesNoQuestion>
    <xsl:apply-templates mode="simplifyYesNoOpen" />
  </yesNoQuestion>
</xsl:template>


<xsl:template mode="simplifyYesNoOpen" match="@* | node()">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
</xsl:template>

<xsl:template mode="simplifyYesNoOpen" match="comment()">
  <xsl:copy />
</xsl:template>

<xsl:template mode="simplifyYesNoOpen" match="processing-instruction()">
  <xsl:copy />
</xsl:template>

<xsl:template mode="simplifyYesNoOpen" match="btw:space">
  <!-- do nothing --><xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ removed btw:space </xsl:comment></xsl:if>
</xsl:template>

<xsl:template mode="simplifyYesNoOpen" match="btw:optionOther[btw:p[normalize-space(text()) = '@placeholder']]">
  <!-- do nothing --><xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ removed btw:optionOther w placeholder </xsl:comment></xsl:if>
</xsl:template>
<xsl:template mode="simplifyYesNoOpen" match="btw:optionOther[not( node() )]">
  <!-- do nothing --><xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ removed empty btw:optionOther </xsl:comment></xsl:if>
</xsl:template>
<xsl:template mode="simplifyYesNoOpen" match="btw:optionOther[count(btw:p) = 1][btw:p[not( node() )]]">
  <!-- do nothing --><xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ removed btw:optionOther with just one empty btw:p </xsl:comment></xsl:if>
</xsl:template>

</xsl:stylesheet>
