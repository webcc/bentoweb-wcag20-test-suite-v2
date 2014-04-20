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
            <xsl:value-of select="@id" /><xsl:text>|</xsl:text>
            <xsl:choose>
                <xsl:when test="@name">
                    <xsl:value-of select="@name" /><xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text> |</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="string-length(normalize-space(btw:userGuidance[@xml:lang='en']))>0">
                    <xsl:text>Yes|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>No|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test=".//btw:questionText[@xml:lang='en'] and .//btw:questionText[@xml:lang='nl']">
                    <xsl:text>Yes|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>No|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='blindness']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='colour vision deficiency']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='low vision']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='deafness']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='hard of hearing']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='dyslexia']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='dyscalculus']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='intellectual disability']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='dexterity impairment']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='motor impairment']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='no disability']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='learning disability']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='functional illiteracy']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='ADHD']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='aphasia']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='deaf-blindness']">
                    <xsl:text>1|</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0|</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="btw:disabilities[btw:disability='speech impairment']">
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>0</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>&#x000a;</xsl:text>
        </xsl:if>
    </xsl:template>

    <!-- Overriding default template -->
    <xsl:template match="btw:*|@*">
    </xsl:template>

</xsl:stylesheet>
