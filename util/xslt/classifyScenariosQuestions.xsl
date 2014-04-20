<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
    exclude-result-prefixes="btw html xlink xsd dc">

<!-- ===== classifyScenarios.xsl =====
    Version: 1.0
    Since: January 2007
    Copyright © 2004-2007 BenToWeb
    -->

	<xsl:output method="text" />
    <xsl:param name="filename" />

    <xsl:template match="/">
        <xsl:apply-templates select="//btw:scenario" />
    </xsl:template>

    <xsl:template match="btw:scenario">
        <xsl:param name="status"><xsl:value-of select="ancestor::btw:testCaseDescription/descendant::btw:status" /></xsl:param>
        <xsl:if test="$status='accepted for end user evaluation'">
            <xsl:value-of select="../../../@id" /><xsl:text>|</xsl:text>
            <xsl:value-of select="normalize-space(/*//btw:title)" /><xsl:text>|</xsl:text>
            <xsl:value-of select="normalize-space(/*//btw:description)" /><xsl:text>|</xsl:text>
            <xsl:value-of select="normalize-space(/*//btw:purpose)" /><xsl:text>|</xsl:text>
            <xsl:value-of select="@id" /><xsl:text>|</xsl:text>
            <xsl:apply-templates select=".//btw:disabilities" /><xsl:text>|</xsl:text>
            <xsl:apply-templates select=".//btw:experience" /><xsl:text>|</xsl:text>
            <xsl:value-of select="normalize-space(.//btw:userGuidance[@xml:lang='en'])" /><xsl:text>|</xsl:text>
            <xsl:value-of select="normalize-space(.//btw:questionText[@xml:lang='en'])" /><xsl:text>|</xsl:text>
            <xsl:value-of select="local-name(.//btw:questionText[@xml:lang='en']/..)" /><xsl:text>|</xsl:text>
            <xsl:text>&#x000a;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="btw:disabilities">
        <xsl:for-each select="btw:disability">
            <xsl:value-of select="." /><xsl:text>,</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="btw:experience">
        <xsl:for-each select="btw:AssistiveTechnology">
            <xsl:value-of select="concat(@type,'(exp=',@minimumLevel,'),',@product,'(version=',@version,')')" /><xsl:text>;</xsl:text>
        </xsl:for-each>
        <xsl:text>|</xsl:text>
        <xsl:for-each select="btw:UserAgent">
            <xsl:value-of select="concat(@type,'(exp=',@minimumLevel,'),',@product,'(version=',@version,')')" /><xsl:text>;</xsl:text>
        </xsl:for-each>
    </xsl:template>

    <!-- Overriding default template -->
    <xsl:template match="btw:*|@*">
    </xsl:template>

</xsl:stylesheet>
