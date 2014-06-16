<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:variable name="HoriginX">0</xsl:variable>
	<xsl:variable name="HoriginY">0</xsl:variable>
	<xsl:variable name="HendX">300</xsl:variable>
	<xsl:variable name="HmargeBot">80</xsl:variable>
	<xsl:variable name="HendY"><xsl:value-of select="$HmargeBot + 300"/></xsl:variable>
	<xsl:variable name="Hmarge">20</xsl:variable>
	<xsl:variable name="Htextsize">10</xsl:variable>
	
	<xsl:template name="histo_cours">
		<svg:svg xmlns:svg="http://www.w3.org/2000/svg" width="{$HendX + $Hmarge}" height="{$HendY}" version="1.1">
			<xsl:variable name="rectX"><xsl:value-of select="$HoriginX + $Hmarge"/></xsl:variable>
			<xsl:variable name="rectY"><xsl:value-of select="$HoriginY"/></xsl:variable>
			<xsl:variable name="rectW"><xsl:value-of select="$HendX - $Hmarge * 2"/></xsl:variable>
			<xsl:variable name="rectH"><xsl:value-of select="$HendY - $Hmarge * 2 - $HmargeBot"/></xsl:variable>
			<svg:rect x="{$rectX}" y="{$rectY}" width="{$rectW}" height="{$rectH}" style="fill:white;stroke:black;stroke-width:1;"/>
			<svg:text x="0" y="{$Htextsize}" transform="translate({$rectX - $Hmarge},{$rectY + 2})">20</svg:text>
			<svg:text x="0" y="{$Htextsize}" transform="translate({$rectX - $Hmarge},{$rectH div 4 - $rectY - ($Htextsize div 2)})">15</svg:text>
			<svg:text x="0" y="{$Htextsize}" transform="translate({$rectX - $Hmarge},{$rectH * 2 div 4 - $rectY - ($Htextsize div 2)})">10</svg:text>
			<svg:text x="0" y="{$Htextsize}" transform="translate({$rectX - $Hmarge},{$rectH * 3 div 4 - $rectY - ($Htextsize div 2)})">5</svg:text>
			<svg:text x="0" y="{$Htextsize}" transform="translate({$rectX - $Hmarge},{$rectH - $Htextsize - $rectY})">0</svg:text>
			<xsl:variable name="moy"><xsl:value-of select="sum(étudiant/note) div count(étudiant)"/></xsl:variable>
			<svg:line x1="{$rectX}" y1="{$rectH * (20 - $moy) div 20}" x2="{$rectX + $rectW}" y2="{$rectH * (20 - $moy) div 20}" style="stroke:green;strock-width:5;"/>
			<svg:line x1="{$rectX}" y1="{$rectH * 10 div 20}" x2="{$rectX + $rectW}" y2="{$rectH * 10 div 20}" style="stroke:red;strock-width:5;"/>
			<xsl:for-each select="étudiant">
				<xsl:variable name="w">15</xsl:variable>
				<xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
				<xsl:variable name="X"><xsl:value-of select="($w div 2) + ($rectW div (count(../étudiant) + 1)) * position()"/></xsl:variable>
				<xsl:variable name="Y"><xsl:value-of select="$rectH * note div 20"/></xsl:variable>
				<svg:text x="0" y="{$Htextsize}" transform="translate({$X + 10},{$rectH + 5}) rotate(60 0,0)">
					<xsl:value-of select="../../personnes/personne[@id = $id]/nom"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="../../personnes/personne[@id = $id]/prénom"/>
				</svg:text>
				<svg:rect x="{$X}" y="{$rectH - $Y}" width="{$w}" height="{$Y}" style="fill:blue;stroke:black;strock-width=2;"/>
			</xsl:for-each>
		</svg:svg>
	</xsl:template>
	
</xsl:stylesheet>