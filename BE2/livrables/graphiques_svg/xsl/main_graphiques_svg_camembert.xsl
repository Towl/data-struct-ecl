<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml"
				encoding="UTF-8" 
				doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN" 
				doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd" 
				omit-xml-declaration="no"/>
				
	<xsl:include href="histogramme.xsl"/>
	<xsl:include href="camembert.xsl"/>
	
	<xsl:template match="/option">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
			<xsl:call-template name="head"/>
			<body>
				<xsl:call-template name="corps"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="head">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
			<meta name="authors" content="Franck Coutouly, Jacques Meykiechel"/>
			<link href="css/bootstrap.css" type="text/css" rel="stylesheet" />
			<link href="css/bootstrap-theme.css" type="text/css" rel="stylesheet" />
			<link href="css/stylesheet.css" type="text/css" rel="stylesheet" />
			<title>BE2</title>
		</head>
	</xsl:template>
	
	<xsl:template name="corps">
		<div class="corps">
			<h1>Option</h1>
			<xsl:call-template name="javascriptInitCamembert"/>
			<xsl:apply-templates select="//personne"/>
		</div>
	</xsl:template>

	<xsl:template match="personne">
		<xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
		<xsl:if test="../../cours/étudiant[@id = $id]">
			<h2><xsl:value-of select="prénom"/><xsl:text> </xsl:text><xsl:value-of select="nom"/></h2>
			<xsl:call-template name="camembert">
				<xsl:with-param name="id" select="$id"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>