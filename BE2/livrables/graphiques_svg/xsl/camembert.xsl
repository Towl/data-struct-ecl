<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0"
				xmlns="http://www.w3.org/1999/xhtml"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="CoriginX">0</xsl:variable><!-- Coordonnée X de l'origine du dessin SVG -->
	<xsl:variable name="CoriginY">0</xsl:variable><!-- Coordonnée Y de l'origine du dessin SVG -->
	<xsl:variable name="Cwidth">300</xsl:variable><!-- Largeur du dessin SVG -->
	<xsl:variable name="Cheight">300</xsl:variable><!-- Hauteur du dessin SVG -->

	<xsl:variable name="centreCamembertX"><xsl:value-of select="$Cwidth div 2"/></xsl:variable>
	<xsl:variable name="centreCamembertY"><xsl:value-of select="$Cheight div 2"/></xsl:variable>
	<xsl:variable name="rayonCamembert">100</xsl:variable>
	
	<!-- Template à appeller une seule fois avant la création du premier camembert.
	setPath(...) est la fonction javascript utilisé pour calculer les angles des parts de camembert.
		avec :  -idPath l'id de la balise <path/> correspondant à la part de camembert,
				-angle l'angle décrit par la part de camembert en radian
				-isLargeArc vaut 1 si l'arc à dessiner est plus long que la moitié du périmetre du cercle complet sinon vaut 0-->
	<xsl:template name="javascriptInitCamembert">
		<script type="text/javascript">
			function setPath(idPath,angle,isLargeArc){
				var angleEndX = <xsl:value-of select="$rayonCamembert"/>*Math.cos(angle)+<xsl:value-of select="$centreCamembertX"/>;
				var angleEndY = <xsl:value-of select="$rayonCamembert"/>*Math.sin(angle)+<xsl:value-of select="$centreCamembertY"/>;
				document.getElementById(idPath).setAttribute("d", "M<xsl:value-of select="$centreCamembertX"/>,<xsl:value-of select="$centreCamembertY"/> l<xsl:value-of select="$rayonCamembert"/>,0 A<xsl:value-of select="$rayonCamembert"/>,<xsl:value-of select="$rayonCamembert"/> 0 "+isLargeArc+",0 "+angleEndX+","+angleEndY+" Z");
			}
		</script>
	</xsl:template>
	
	<xsl:template name="camembert">
		<xsl:param name="id"/>
		<xsl:variable name="nbCoursInscr"><xsl:value-of select="count(../../cours/étudiant[@id = $id])"/></xsl:variable>
		<xsl:variable name="notemoy">
			<xsl:value-of select="sum(../../cours/étudiant[@id = $id]/note) div count(../../cours/étudiant[@id = $id]/note)"/>
		</xsl:variable>
		<svg:svg xmlns:svg="http://www.w3.org/2000/svg" width="{$Cwidth}" height="{$Cheight}" version="1.1">		
			<xsl:for-each select="../../cours/étudiant[@id = $id]/note">
				<xsl:variable name="uInt8Max">255</xsl:variable>
				<xsl:variable name="color">
					<xsl:text>rgb(</xsl:text>
					<xsl:value-of select="round((position() div $nbCoursInscr) * $uInt8Max)"/><!-- Rouge -->
					<xsl:text>,</xsl:text>
					<xsl:value-of select="round(0.5 * $uInt8Max)"/><!-- Vert -->
					<xsl:text>,</xsl:text>
					<xsl:value-of select="round((1 - (position() div $nbCoursInscr)) * $uInt8Max)"/><!-- Bleu -->
					<xsl:text>)</xsl:text>
				</xsl:variable>
				<xsl:variable name="positCours"><xsl:value-of select="count(../../preceding-sibling::cours) + 1"/></xsl:variable>
				<xsl:variable name="negatePercent">
					<xsl:value-of select="(sum(../../../cours[position() &lt; $positCours]/étudiant[@id = $id]/note) div $nbCoursInscr) div $notemoy"/>
				</xsl:variable>
				<xsl:if test="$negatePercent &gt; 0">
					<xsl:variable name="idPath"><xsl:value-of select="concat('path',count(preceding::*))"/></xsl:variable>
					<svg:path id="{$idPath}" d="" fill="{$color}" stroke="black" stroke-width="2"/>
				</xsl:if>
				<xsl:if test="$negatePercent = 0">
					<svg:circle cx="{$centreCamembertX}" cy="{$centreCamembertY}" r="{$rayonCamembert}" stroke="black" stroke-width="2" fill="{$color}"/>
				</xsl:if>
			</xsl:for-each>
		</svg:svg>
		<xsl:for-each select="../../cours/étudiant[@id = $id]/note">
			<xsl:variable name="positCours"><xsl:value-of select="count(../../preceding-sibling::cours) + 1"/></xsl:variable>
			<xsl:variable name="negatePercent">
				<xsl:value-of select="(sum(../../../cours[position() &lt; $positCours]/étudiant[@id = $id]/note) div $nbCoursInscr) div $notemoy"/>
			</xsl:variable>
			<xsl:if test="$negatePercent &gt; 0">
					<xsl:call-template name="setPath">
						<xsl:with-param name="negatePercent" select="$negatePercent"/>
					</xsl:call-template>
				</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="setPath">
		<xsl:param name="negatePercent"/>
		<xsl:variable name="newAngle"><xsl:value-of select="2 * 3.14 * $negatePercent"/></xsl:variable>
		<xsl:variable name="idPath"><xsl:value-of select="concat('path',count(preceding::*))"/></xsl:variable>
		<script type="text/javascript">
			setPath("<xsl:value-of select="$idPath"/>",<xsl:value-of select="$newAngle"/>,<xsl:value-of select="1 - round($negatePercent)"/>);
		</script>
	</xsl:template>
	
</xsl:stylesheet>