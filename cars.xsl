<?xml version="1.0" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:output method="html"/>

	<xsl:template match="/">
		
		<html>
			<head><title>Cars</title></head>
			<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

			<style>
				.genStyle {padding: 10px; text-align: center;}  

				#images {
					position: relative;
					float: left;
				}

				#images img {
					padding-left: 75px;
					position: absolute;
					top: 0;
					left: 0;
					display: none;
					height: 250px;
					width: 300px;
				}
			</style>

			<script type="text/javascript">
	
				$(document).ready(function() {
					var slideNum = 0;
					var slideCount = 0;

					var slides = $('#images img');

					slides.eq(slideNum).show();

					var sliderTimer = setInterval(function() {
					
						slides.eq(slideNum).fadeOut();

						slideNum++;

						if(slideNum >= slides.length) {
						  slideNum = 0;
						}

						slides.eq(slideNum).fadeIn(1500, function() {
							slideCount++;
						});
					}, 1500);

				});

			</script>

			<body>

				<h1>Cars! @<xsl:value-of select="cars/car/make"/>&#160;<xsl:value-of select="cars/car/model"/></h1>

				The <xsl:value-of select="cars/car/make"/> is located in the <xsl:value-of select="cars/car/location"/>.
				
				<div id="topLayer">
					<table border="1" style="display: inline-block; float: left; border: 5px solid orange; border-radius: 5px; margin-bottom: 40px;">
						<tr>
							<th class="genStyle">Make</th>
							<th class="genStyle">Model</th>
							<th class="genStyle">SubModel</th>
							<th class="genStyle">Color</th>
							<th class="genStyle">Location</th>
							<th class="genStyle">Nickname</th>
						</tr>
						
						<xsl:for-each select="cars/car">
							<xsl:sort select="make" order="ascending" data-type="text"/>

							<tr>
								<td class="genStyle">
									<xsl:apply-templates select="make"/>
								</td>
								<td class="genStyle"><xsl:value-of select="model"/></td>
								<td class="genStyle"><xsl:value-of select="subModel"/></td>
								<td class="genStyle"><xsl:value-of select="color"/></td>
								<td class="genStyle"><xsl:value-of select="location"/></td>

								<xsl:choose>
									<xsl:when test = "nickname">
										<td class="genStyle"><xsl:value-of select="nickname"/></td>
									</xsl:when>
									<xsl:otherwise>
										<td class="genStyle">none</td>
									</xsl:otherwise>
								</xsl:choose>
							</tr>
						</xsl:for-each>

					</table>

					<div id="images">
						<xsl:for-each select="cars/car">
							<xsl:sort select="make" order="ascending" data-type="text"/>
							<xsl:apply-templates select="logo"/>
						</xsl:for-each>
					</div>
				</div>
				
				<div style="clear: both; border: 1px solid red; border-radius: 5px; padding: 20px; margin-bottom: 25px; background-color: aliceblue;">
					<h1> History of Manufacturers </h1>

					<xsl:for-each select="cars/car">

						<xsl:sort select="make" order="ascending" data-type="text"/>

							<xsl:apply-templates select="history"/>

					</xsl:for-each>

				</div>

				<div style="border: 2px solid green; border-radius: 5px; padding: 10px;">
					<xsl:for-each select="cars/car">
						<xsl:sort select="make" order="ascending" data-type="text"/>
						<xsl:apply-templates select="color"/>
					</xsl:for-each>
				</div>

			</body>
		</html>
	</xsl:template>

	<xsl:template match="make">
		<xsl:choose>
			<xsl:when test = ". = 'Tesla'">
				<a>
					<xsl:attribute name="href">http://www.<xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>motors.com</xsl:attribute>
					<xsl:value-of select="."/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<a>
					<xsl:attribute name="href">http://www.<xsl:value-of select="translate(.,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>.com</xsl:attribute>
					<xsl:value-of select="."/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="history">
		<h3>
			<xsl:value-of select="../make"/>&#160;
			<xsl:value-of select="../model"/>&#160;
			<xsl:value-of select="../subModel"/><br/>
		</h3>
		<xsl:value-of select="."/>
		<br/><br/>
		<img>
			<xsl:attribute name="src"><xsl:value-of select="../picture"/></xsl:attribute>
      <xsl:attribute name="height">300</xsl:attribute>
	  </img><br/>
	</xsl:template>

	<xsl:template match="logo">
		<img>
			<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
      <xsl:attribute name="height">250</xsl:attribute>
      <xsl:attribute name="width">300</xsl:attribute>
	  </img><br/>
	</xsl:template>

	<xsl:template match="color">
		<xsl:choose>
			<xsl:when test = ". = 'Red' and ../make = 'Toyota'">
				<h1> The complex expression test is True! The sub-model is <xsl:value-of select="../subModel"/>. </h1>
			</xsl:when>
			<xsl:when test = ". = 'Silver' and ../make = 'Honda'">
				<h1> The complex expression test is True! The sub-model is <xsl:value-of select="../subModel"/>. </h1>
			</xsl:when>
			<xsl:otherwise>
				<h1> The complex expression test is False! But! The car is located on/in the <xsl:value-of select="../location"/>. </h1>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>