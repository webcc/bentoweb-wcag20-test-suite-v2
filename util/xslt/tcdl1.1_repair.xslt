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
  Stylesheet that repairs validity errors introduced by Parsifal.
  Refer to 'tcdl1.1_repair_yesnoopen.xslt' for additional fixes to yesNoOpenQuestion elements.
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


<!-- Fix order of btw:space and btw:questionText if btw:space occurs in first position. -->
<xsl:template match="btw:openQuestion[btw:space[position() = 1]]">
  <openQuestion>
    <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute>
    <xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> Fixed order of space and questionText </xsl:comment></xsl:if>
    <xsl:for-each select="btw:questionText">
      <questionText>
        <xsl:copy-of select="node() | @*" />
      </questionText>
    </xsl:for-each>
    <space>
      <rows><xsl:value-of select="btw:space/btw:rows" /></rows>
      <columns><xsl:value-of select="btw:space/btw:columns" /></columns>
    </space>
  </openQuestion>
</xsl:template>


<!-- Fix order of btw:space and btw:optionOther if btw:space occurs before btw:optionOther. -->
<xsl:template match="btw:yesNoOpenQuestion[btw:space[following-sibling::btw:optionOther]]">
  <xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ found incorrectly ordered space and optionOther </xsl:comment></xsl:if>
  <yesNoOpenQuestion>
    <xsl:for-each select="btw:questionText[following-sibling::btw:optionYes]">
      <questionText>
        <xsl:copy-of select="node() | @*" />
      </questionText>
    </xsl:for-each>
    <optionYes><xsl:copy-of select="btw:optionYes/node() | btw:optionYes/@*" /></optionYes>
    <optionNo><xsl:copy-of select="btw:optionNo/node() | btw:optionNo/@*" /></optionNo>
    <xsl:for-each select="btw:optionOther">
      <optionOther><xsl:copy-of select="node() | @*" /></optionOther>
    </xsl:for-each>
    <xsl:for-each select="btw:questionText[preceding-sibling::btw:optionNo]">
      <questionText>
        <xsl:copy-of select="node() | @*" />
      </questionText>
    </xsl:for-each>
    <space>
      <rows><xsl:value-of select="btw:space/btw:rows" /></rows>
      <columns><xsl:value-of select="btw:space/btw:columns" /></columns>
    </space>
  </yesNoOpenQuestion>
</xsl:template>


<xsl:template match="btw:optionOther[not( node() )]">
  <optionOther xml:lang="{@xml:lang}"><p/></optionOther><xsl:if test="starts-with($DEBUG, 'true')"><xsl:comment> @@ added empty btw:p to empty btw:optionOther </xsl:comment></xsl:if>
</xsl:template>


<!-- Add missing btw:UserAgent, with same minimum level as the first AT. -->
<xsl:template match="btw:AssistiveTechnology[count(../btw:UserAgent) = 0][not(following-sibling::btw:AssistiveTechnology)]">
  <xsl:copy><xsl:apply-templates select="@* | node()" /></xsl:copy>
  <UserAgent minimumLevel="{../btw:AssistiveTechnology[1]/@minimumLevel}" type="browser" />
</xsl:template>

<!-- Remove empty product attributes. -->
<xsl:template match="btw:UserAgent/@product[string-length() &lt; 2] | btw:AssistiveTechnology/@product[string-length() &lt; 2] | btw:Device/@product[string-length() &lt; 2]">
  <!-- do nothing -->
</xsl:template>

</xsl:stylesheet>
