<?xml version="1.0" encoding="ISO-8859-1" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml"
				encoding="ISO-8859-1" 
				doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
				doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
				omit-xml-declaration="no"/>
				
	<xsl:include href="liste_personnes.xsl"/>
	
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
			<xsl:call-template name="liste_personnes"/>
		</div>
	</xsl:template>
	
</xsl:stylesheet>