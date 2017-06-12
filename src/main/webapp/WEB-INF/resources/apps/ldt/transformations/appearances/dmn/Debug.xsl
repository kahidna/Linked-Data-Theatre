
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:res="http://www.w3.org/2005/sparql-results#"
	xmlns:elmo="http://bp4mc2.org/elmo/def#"
	xmlns:html="http://www.w3.org/1999/xhtml/vocab#"
>

<xsl:variable name="debug" select="'false'" />

<xsl:template match="*" mode="xml-dump">

	<xsl:if test="$debug = 'true'">
		<hr />
			<xsl:apply-templates select="*" mode="xml-dump-tree" />
			<xsl:apply-templates select="." mode="xml-dump-textarea" />
		<hr />
	</xsl:if>
	
</xsl:template>

<xsl:template match="*" mode="xml-dump-tree">

	<script type="text/javascript">
		$(document).ready(function() {
			$(".xml-dump-hover").hover(
				function() { 
					change_color($(this).attr('name'), 'yellow'); 
				}, 
				function() { 
					change_color($(this).attr('name'), 'white'); 
				});
			}
		);
		
		function change_color(name, color) {
			$("[name='" + name + "']").css('background-color', color); 
		}		
	
	</script>
	<style>
		.xml-dump-hover {
			background-color: white;
		}
	</style>
	
	<xsl:apply-templates select="." mode="xml-dump-process" />
</xsl:template>


<xsl:template match="*" mode="xml-dump-process">
	
	<ul>
		<li><span class="xml-dump-hover" name="{name()}"><b><xsl:value-of select="concat(name(), '&#xA;')"/></b></span>
		[
		 <xsl:for-each select="@*" >
            <xsl:if test="not(position() = 1)"><xsl:text>, </xsl:text></xsl:if>
            <span class="xml-dump-hover" title="{.}" name="{.}"><i><xsl:value-of select="name()"/></i> <span name="title_dump" /></span>
        </xsl:for-each>
		]
		{
			<xsl:value-of select="text()" />			
		}
		</li>
		<xsl:apply-templates select="*"  mode="xml-dump-process"/>
	</ul>
</xsl:template>

  <xsl:template match="*" mode="xml-dump-textarea">
    <textarea>
      <xsl:copy-of select="*"/>
    </textarea>
  </xsl:template>

</xsl:stylesheet> 