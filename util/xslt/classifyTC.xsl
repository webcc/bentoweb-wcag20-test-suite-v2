<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
    exclude-result-prefixes="btw html xlink xsd dc">

<!-- ===== classifyTC.xsl =====
    Version: 1.0
    Since: December 2006
    Copyright © 2004-2007 BenToWeb
    -->

	<xsl:output method="text" />
    <xsl:param name="filename" />
    <xsl:param name="techniques" />

    <xsl:template match="/">
        <xsl:apply-templates select="/btw:testCaseDescription" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:formalMetadata/dc:creator" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:formalMetadata/btw:description" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:locations" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:formalMetadata/btw:status" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:testCase/btw:requiredTests/btw:testModes/btw:testMode" /><xsl:text>|</xsl:text>
        <xsl:apply-templates select="/btw:testCaseDescription/btw:testCase/btw:requiredTests" /><xsl:text>|</xsl:text>
        <xsl:if test="$techniques = 'TRUE'">
          <!-- links to general techniques -->
          <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#F')]]" /><xsl:text>|</xsl:text>
          <!-- links to general techniques -->
          <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#G')]]" /><xsl:text>|</xsl:text>
          <!-- links to HTML techniques -->
          <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#H')]]" /><xsl:text>|</xsl:text>
          <!-- links to CSS techniques -->
          <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#C')]]" /><xsl:text>|</xsl:text>
          <!-- links to scripting techniques -->
          <xsl:apply-templates select="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#SCR')]]" /><xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription">
        <xsl:choose>
            <xsl:when test="@id = substring-before($filename,'.xml')">
                <xsl:value-of select="@id" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('ERROR: ', $filename)" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:formalMetadata/dc:creator">
        <xsl:value-of select="substring-before(.,'@')" />
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:formalMetadata/btw:description">
        <xsl:value-of select="normalize-space(.)" />
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:locations">
        <xsl:value-of select="@expectedResult" />
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:formalMetadata/btw:status">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:testCase/btw:requiredTests/btw:testModes/btw:testMode">
        <xsl:value-of select="." />
    </xsl:template>

    <xsl:template match="/btw:testCaseDescription/btw:testCase/btw:requiredTests">
        <xsl:value-of select="count(btw:scenario)" />
    </xsl:template>

    <!-- links to failures -->
    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#F')]]">
      <xsl:for-each select="html:a/@href"><xsl:value-of select="substring-after(normalize-space(.), '#')" /><xsl:text> </xsl:text></xsl:for-each>
    </xsl:template>
    <!-- links to general techniques -->
    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#G')]]">
      <xsl:for-each select="html:a/@href"><xsl:value-of select="substring-after(normalize-space(.), '#')" /><xsl:text> </xsl:text></xsl:for-each>
    </xsl:template>
    <!-- links to HTML techniques -->
    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#H')]]">
      <xsl:for-each select="html:a/@href"><xsl:value-of select="substring-after(normalize-space(.), '#')" /><xsl:text> </xsl:text></xsl:for-each>
    </xsl:template>
    <!-- links to CSS techniques -->
    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#C')]]">
      <xsl:for-each select="html:a/@href"><xsl:value-of select="substring-after(normalize-space(.), '#')" /><xsl:text> </xsl:text></xsl:for-each>
    </xsl:template>
    <!-- links to scripting techniques -->
    <xsl:template match="/btw:testCaseDescription/btw:rules/btw:rule[1]/btw:techComment/btw:p/html:span[@class='technique'][html:a[contains(@href,'WCAG20-TECHS-20070517/#SCR')]]">
      <xsl:for-each select="html:a/@href"><xsl:value-of select="substring-after(normalize-space(.), '#')" /><xsl:text> </xsl:text></xsl:for-each>
    </xsl:template>

    <xsl:template match="*|@*">
        <!--xsl:apply-templates select="node()|@*" /-->
    </xsl:template>

</xsl:stylesheet>
