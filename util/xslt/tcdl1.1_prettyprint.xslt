<?xml version="1.0" encoding="UTF-8"?>
<!--
  Converts XML into a nice readable format.
  Tested with Saxon 6.5.3.
  As a test, this stylesheet should not change when run on itself.
  But note that there are no guarantees about attribute order within an
  element (see http://www.w3.org/TR/xpath#dt-document-order), or about
  which characters are escaped (see
  http://www.w3.org/TR/xslt#disable-output-escaping).
  I did not test processing instructions, CDATA sections, or
  namespaces.
  
  Hew Wolff
  Senior Engineer
  Art & Logic, Inc.
  www.artlogic.com
-->
<!-- See also 'XSLT as Pretty Printer' at http://www.xml.com/pub/a/2006/11/29/xslt-xml-pretty-printer.html
  and the comments on the article.
  The stylesheet ignores xml:space="preserve".
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:html="http://www.w3.org/1999/xhtml">
  <!-- Take control of the whitespace. -->
  <xsl:output method="xml" indent="no" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="xsl:text"/>

  <!-- @@ support for PIs added for BenToWeb.
    Note Eclipse 3.2.1 complains that "Spaces are not allowed before a Processing Instruction" 
    but this is not confirmed by the XML 1.0 Specification (4th ed);
    see http://www.w3.org/TR/2006/REC-xml-20060816/#NT-content .
  -->
  <xsl:template match="processing-instruction()">
    <xsl:text>&#xA;</xsl:text><xsl:copy />
  </xsl:template>
  <!-- @@ If first node in document element is comment, don't indent. -->
  <xsl:template match="/*/node()[1][self::comment()]">
    <xsl:text>&#xA;</xsl:text><xsl:copy />
  </xsl:template>

  <!-- For HTML elements: just copy, don't indent. -->
  <xsl:template match="html:*">
    <xsl:copy>
      <xsl:if test="self::*">
        <xsl:copy-of select="@*"/>

        <xsl:apply-templates />


      </xsl:if>
    </xsl:copy>
  </xsl:template>


  <!-- Copy comments, and elements recursively. -->
  <xsl:template match="*|comment()">
    <xsl:param name="depth">0</xsl:param>

    <!--
      Set off from the element above if one of the two has children.
      Also, set off a comment from an element.
      And set off from the XML declaration if necessary.
    -->
    <xsl:variable name="isFirstNode" select="count(../..) = 0 and position() = 1"/>
    <xsl:variable name="previous" select="preceding-sibling::node()[1]"/>
    <xsl:variable name="adjacentComplexElement" select="count($previous/*) &gt; 0 or count(*) &gt; 0"/>
    <xsl:variable name="adjacentDifferentType" select="not(($previous/self::comment() and self::comment()) or ($previous/self::* and self::*))"/>

    <!-- @@ Disabled for BenToWeb -->
    <!-- xsl:if test="$isFirstNode or ($previous and ($adjacentComplexElement or $adjacentDifferentType))">
      <xsl:text>&#xA;</xsl:text>
    </xsl:if-->

    <!-- Start a new line. -->
    <xsl:text>&#xA;</xsl:text>

    <xsl:call-template name="indent">
      <xsl:with-param name="depth" select="$depth"/>
    </xsl:call-template>

    <xsl:copy>
      <xsl:if test="self::*">
        <xsl:copy-of select="@*"/>

        <xsl:apply-templates>
          <xsl:with-param name="depth" select="$depth + 1"/>
        </xsl:apply-templates>

        <xsl:if test="count(*) &gt; 0">
          <xsl:text>&#xA;</xsl:text>

          <xsl:call-template name="indent">
            <xsl:with-param name="depth" select="$depth"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:if>
    </xsl:copy>

    <xsl:variable name="isLastNode" select="count(../..) = 0 and position() = last()"/>

    <xsl:if test="$isLastNode">
      <xsl:text>&#xA;</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="indent">
    <xsl:param name="depth"/>

    <xsl:if test="$depth &gt; 0">
      <!-- @@ Changed 3 spaces to 2 for BenToWeb. -->
      <xsl:text>  </xsl:text>

      <xsl:call-template name="indent">
        <xsl:with-param name="depth" select="$depth - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

<!-- Escape newlines within text nodes, for readability. -->
  <xsl:template match="text()">
    <xsl:call-template name="escapeNewlines">
      <xsl:with-param name="text">
        <xsl:value-of select="."/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="escapeNewlines">
    <xsl:param name="text"/>

    <xsl:if test="string-length($text) &gt; 0">
      <xsl:choose>
        <xsl:when test="substring($text, 1, 1) = '&#xA;'">
          <xsl:text disable-output-escaping="yes">&#xA;</xsl:text>
        </xsl:when>

        <xsl:otherwise>
          <xsl:value-of select="substring($text, 1, 1)"/>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:call-template name="escapeNewlines">
        <xsl:with-param name="text" select="substring($text, 2)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
