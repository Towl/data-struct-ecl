<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	
	<xsl:template name="liste_personnes">
		<div class="liste_personnes">
			<h2 id="liste_personnes">Liste des personnes</h2>
			<xsl:apply-templates select="//personnes"/>
		</div>
	</xsl:template>
	
	<xsl:template match="personnes">
		<table class="table table-hover">
			<thead>
				<tr>
					<th><xsl:text></xsl:text></th>
					<th><xsl:text>Prénom</xsl:text></th>
					<th><xsl:text>Nom</xsl:text></th>
					<th><xsl:text>Téléphone</xsl:text></th>
					<th><xsl:text>email</xsl:text></th>
					<th><xsl:text>Adresse</xsl:text></th>
					<th><xsl:text>ville</xsl:text></th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates/>
			</tbody>
		</table>
	</xsl:template>
	
	<xsl:template match="personne">
		<tr>
			<td><a type="button" href="#{@id}" class="btn btn-xs btn-default">v</a></td>
			<xsl:choose>
				<xsl:when test="prénom">
					<td><xsl:apply-templates select="prénom"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="nom">
					<td><xsl:apply-templates  select="nom"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="phone">
					<td><xsl:apply-templates  select="phone"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="email">
					<td><a href="{concat('mailto:',text())}"><xsl:apply-templates  select="email"/></a></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="adresse">
					<td><xsl:apply-templates  select="adresse"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="ville">
					<td><xsl:apply-templates  select="ville"/></td>
				</xsl:when>
				<xsl:otherwise>
					<td><xsl:text> </xsl:text></td>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>
</xsl:stylesheet>