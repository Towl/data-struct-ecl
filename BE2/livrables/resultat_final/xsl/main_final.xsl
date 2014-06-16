<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml"
				encoding="UTF-8" 
				doctype-public="-//W3C//DTD XHTML 1.1 plus MathML 2.0 plus SVG 1.1//EN" 
				doctype-system="http://www.w3.org/2002/04/xhtml-math-svg/xhtml-math-svg.dtd" 
				omit-xml-declaration="no"/>
				
	<xsl:include href="liste_personnes.xsl"/>
	<xsl:include href="fiches_etudiants.xsl"/>
	<xsl:include href="fiches_cours.xsl"/>
	
	<xsl:template match="/option">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
			<xsl:call-template name="head"/>
			<body>
				<xsl:call-template name="sommaire"/>
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
	
	<xsl:template name="sommaire">
		<div class="sommaire panel panel-default">
            <div class="panel-heading">
              <h3 class="panel-title sommaire-title">Sommaire</h3>
			</div>
			<div class="panel-content sommaire-content">
				<ul class="nav nav-pills nav-stacked">
					<li><a href="#liste_personnes">Liste des personnes</a></li>
					<li><a href="#fiches_etudiants">Fiches des étudiants</a></li>
					<li><a href="#fiches_cours">Fiches des cours</a></li>
				</ul>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="corps">
		<div class="corps">
			<h1>Option</h1>
			<xsl:call-template name="liste_personnes"/>
			<xsl:call-template name="fiches_etudiants"/>
			<xsl:call-template name="fiches_cours"/>
		</div>
	</xsl:template>
	
</xsl:stylesheet>