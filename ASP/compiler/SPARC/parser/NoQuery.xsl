<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  version="1.0"
    xmlns:tns="http://www.ttu.edu/KRLab/AnswerSetSchema">

<xsl:output method="html"/>

<xsl:template match="tns:answersets">
<html>
<body>
   <xsl:choose>
      <xsl:when test="tns:answerset">
       <ol>
		<xsl:apply-templates select="tns:answerset"/>

       </ol>
      </xsl:when>
      <xsl:otherwise>
          No Answer Set 
      </xsl:otherwise>
    </xsl:choose>


</body></html>

</xsl:template>


<xsl:template match="tns:answerset">

<li>

	<xsl:apply-templates select="tns:literal"></xsl:apply-templates>
	
</li>

</xsl:template>


<xsl:template match="tns:literal">

<h1><xsl:value-of select="@name"></xsl:value-of></h1>

<table>

	<th>Lit</th>
	<xsl:apply-templates select = "tns:instance"></xsl:apply-templates>
	
</table>



</xsl:template>

<xsl:template match="tns:instance">

<tr> 

<td>
<xsl:if test="@sign = 'false'">
<xsl:text>-</xsl:text>
</xsl:if>
<xsl:value-of select="../@name"></xsl:value-of>
<xsl:if test="tns:term">
<xsl:text>(</xsl:text>
</xsl:if>
</td>

<xsl:for-each select="tns:term">

	<td>
		<xsl:value-of select="@name"></xsl:value-of>
		<xsl:if test="tns:term">
		<xsl:text>(</xsl:text>
		<xsl:apply-templates select="tns:term"/> 
		<xsl:text>)</xsl:text>
		</xsl:if>
	</td>

</xsl:for-each>	


<xsl:if test="tns:term">
<td><xsl:text>)</xsl:text></td>
</xsl:if>

</tr>

</xsl:template>


<xsl:template match="tns:term">
	
	 <xsl:if test="position()>1">
            <xsl:text>,</xsl:text>
    </xsl:if>
	<xsl:value-of select="@name"></xsl:value-of>
	<xsl:if test="tns:term">
		<xsl:text>(</xsl:text>
		<xsl:apply-templates select="tns:term"/> 
		<xsl:text>)</xsl:text>
	</xsl:if>
	

</xsl:template>



</xsl:stylesheet>




