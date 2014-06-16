<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0"
				xmlns="http://www.w3.org/1999/xhtml"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="fiches_cours">
		<div class="fiches_cours">
			<h2 id="fiches_cours">Fiches des cours</h2>
			<xsl:for-each select="//cours">
				<xsl:call-template name="fiche_cours"/>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template name="fiche_cours">
		<div class="cours">
			<h3><xsl:value-of select="@intitulÃ©"/></h3>
			<xsl:variable name="profID"><xsl:value-of select="@prof"/></xsl:variable>
			<h4>
				<xsl:text>Enseignant : </xsl:text>
				<xsl:value-of select="../personnes/personne[@id = $profID]/prÃ©nom"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="//personne[@id = $profID]/nom"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="//personne[@id = $profID]/phone"/>
				<xsl:text> </xsl:text>
				<a>
					<xsl:attribute name="href">
						<xsl:text>emailto:</xsl:text>
						<xsl:value-of select="//personne[@id = $profID]/email"/>
					</xsl:attribute>
					<xsl:value-of select="//personne[@id = $profID]/email"/>
				</a>
			</h4>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Eleves</th>
						<th>Note</th>
						<th>Absences</th>
						<th>Commentaires</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="Ã©tudiant">
						<tr>
							<xsl:call-template name="detail_etudiant">
								<xsl:with-param name="id" select="@id"/>
							</xsl:call-template>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</div>
	</xsl:template>
	
	<xsl:template name="detail_etudiant">
		<xsl:param name="id"/>
		<xsl:if test="note&lt;10">
			<xsl:attribute name="class"><xsl:text>danger</xsl:text></xsl:attribute>
		</xsl:if>
		<xsl:if test="note&gt;10 and note&lt;12">
			<xsl:attribute name="class"><xsl:text>warning</xsl:text></xsl:attribute>
		</xsl:if>
		<xsl:if test="note&gt;=15">
			<xsl:attribute name="class"><xsl:text>success</xsl:text></xsl:attribute>
		</xsl:if>
		<td>
			<xsl:value-of select="//personne[@id = $id]/prÃ©nom"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="//personne[@id = $id]/nom"/>
		</td>
		<td><xsl:value-of select="note"/></td>
		<td><xsl:value-of select="absences"/></td>
		<td><xsl:value-of select="comment"/></td>
	</xsl:template>
	
</xsl:stylesheet>