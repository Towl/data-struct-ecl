<?xml version="1.0" encoding="ISO-8859-1" ?>

<xsl:stylesheet version="1.0"
				xmlns="http://www.w3.org/1999/xhtml"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:include href="camembert.xsl"/>
	
	<xsl:template name="fiches_etudiants">
		<div class="fiches_etudiants">
			<xsl:call-template name="javascriptInitCamembert"/>
			<h2 id="fiches_etudiants">Fiches des étudiants</h2>
			<xsl:for-each select="//personne">
				<xsl:call-template name="fiche_etudiant">
					<xsl:with-param name="id" select="@id"/>
				</xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xsl:template name="fiche_etudiant">
		<xsl:param name="id"/>
		<xsl:if test="//étudiant[@id = $id]">
			<xsl:variable name="notemoy">
				<xsl:value-of select="sum(../../cours/étudiant[@id = $id]/note) div count(../../cours/étudiant[@id = $id]/note)"/>
			</xsl:variable>
			<h3 id="{@id}">
				<xsl:value-of select="prénom"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="nom"/>
			</h3>
			<h4>
				<xsl:text> moyenne : </xsl:text>
				<xsl:value-of select="round($notemoy)"/>
			</h4>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Cours</th>
						<th>Note</th>
						<th>Absences</th>
						<th>Appréciation</th>
						<th>Participation</th>
						<th>Legende</th>
						<th>Camembert</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="//étudiant[@id = $id]">
						<tr>
							<xsl:variable name="nbCoursInscr"><xsl:value-of select="count(../../cours/étudiant[@id = $id])"/></xsl:variable>
							<xsl:if test="note&lt;10">
							<xsl:attribute name="class"><xsl:text>danger</xsl:text></xsl:attribute>
							</xsl:if>
							<xsl:if test="note&gt;10 and note&lt;12">
								<xsl:attribute name="class"><xsl:text>warning</xsl:text></xsl:attribute>
							</xsl:if>
							<xsl:if test="note&gt;=15">
								<xsl:attribute name="class"><xsl:text>success</xsl:text></xsl:attribute>
							</xsl:if>
							<td><xsl:value-of select="../@intitulé"/></td>
							<td><xsl:value-of select="note"/></td>
							<td><xsl:value-of select="absences"/></td>
							<td><xsl:value-of select="comment"/></td>
							<td>
								<xsl:value-of select="round(((note div $nbCoursInscr) div $notemoy) * 100)"/><xsl:text> %</xsl:text>
							</td>
							<td>
								<xsl:variable name="uInt8Max">255</xsl:variable>
								<xsl:variable name="w">50</xsl:variable>
								<xsl:variable name="h">15</xsl:variable>
								<svg:svg xmlns:svg="http://www.w3.org/2000/svg" version="1.1" width="{$w}" height="{$h}">
									<svg:rect x="0" y="0" width="{$w}" height="{$h}" fill="rgb({round((position() div $nbCoursInscr) * $uInt8Max)},{round(0.5 * $uInt8Max)},{round((1 - (position() div $nbCoursInscr)) * $uInt8Max)})" stroke="black" stroke-width="2"/>
								</svg:svg>
							</td>
							<xsl:if test="position() = 1">
								<td class="camembert" rowspan="{$nbCoursInscr}">
									<xsl:call-template name="camembert">
										<xsl:with-param name="id" select="$id"/>
									</xsl:call-template>
								</td>
							</xsl:if>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>