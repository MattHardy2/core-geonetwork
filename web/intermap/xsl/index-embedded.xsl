<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
	<xsl:output method="html"/>

	<xsl:template match="/">
		<xsl:call-template name="bigmap"/>
	</xsl:template>
		

	<xsl:template name="bigmap">

		<xsl:call-template name="localization"/>
		
		<div id="intermap_root"> <!-- class will be set to current tool -->		
			
			<table class="padded_content">
				<tr>
					<!-- TOOLBAR -->
					<td>
						<table id="im_toolbar" class="padded_content">
							<tr id="im_toolSelector"> <!--class="im_tool"-->
								<td class="im_tool" id="im_tool_fullextent" onClick="javascript:im_bm_fullExtent()"><img src="{/root/gui/url}/images/zoomfull.png" title="{/root/gui/strings/fullExtent}"/></td>
								<td class="im_tool" id="im_tool_zoomin" onClick="javascript:setTool('zoomin');" ><img src="{/root/gui/url}/images/zoomin.png" title="{/root/gui/strings/zoomIn}"/></td>
								<td class="im_tool" id="im_tool_zoomout" onClick="javascript:setTool('zoomout');"><img  src="{/root/gui/url}/images/zoomout.png" title="{/root/gui/strings/zoomOut}"/></td>
								<td class="im_tool" id="im_tool_pan" onClick="javascript:setTool('pan');"><img src="{/root/gui/url}/images/pan.png" title="{/root/gui/strings/pan}"/></td>															
<!-- TODO							<td class="im_tool" id="im_tool_mark" onClick="javascript:setTool('mark');"><img src="{/root/gui/url}/images/marker.png" title="{/root/gui/strings/marker}"/></td>															-->
<!--								<td class="im_tool" id="im_tool_zoomsel"	onClick="javascript:imc_zoomToLayer(activeLayerId)"><img src="{/root/gui/url}/images/zoomsel.png" title="Zoom to selected layer extent"/></td> -->
<!--								<td class="im_tool" id="im_tool_aoi"		onClick="javascript:setTool('aoi')"><img src="{/root/gui/url}/images/im_aoi16x16.png" title="Select an Area Of Interest"/></td> --> 
								<td class="im_tool" id="im_tool_identify"	onClick="javascript:setTool('identify');"><img src="{/root/gui/url}/images/info.png" title="{/root/gui/strings/identify}"/></td>
								<td width="100%" style="border-top:0px;"/> <!-- spacer -->
								<td class="im_tool" id="im_tool_refresh" onClick="javascript:im_bm_refresh()"><img src="{/root/gui/url}/images/reload.png" title="{/root/gui/strings/refresh}"/></td>
<!--								<td class="im_tool"  				onClick="javascript:im_bm_toggleImageSize()">+/- map</td>-->
								<td class="im_tool" id="im_tool_reset" onClick="javascript:im_reset();"><img src="{/root/gui/url}/images/reset.png" title="{/root/gui/strings/reset}"/></td>
							</tr>							
						</table>						
					</td>
					
					<!--  LAYERS -->
					<!-- This is only a placeholder structure: layers will be inserted dinamically. -->
					<td rowspan="3" valign="top">
						<div id="im_layers" >
							
							<div id="im_layersHeader">
								<h3>
									<xsl:value-of select="/root/gui/strings/layers"/>
								</h3>
							</div>
							
							<!-- Layers -->
							<div id="im_layersDiv">
								<ul id="im_layerList" />
							</div>
							
<!--							<table id="im_refresh">
								<tr>
									<td>
										<button id="im_refreshButton" class="im_disabled">
											<xsl:value-of select="/root/gui/strings/refresh" />
										</button>
									</td>
								</tr>
							</table>
-->														
							<!-- layers toolbar -->
							<!--<div id="im_layersToolbar"/>-->
														
						</div>
					</td>					
				</tr>
				
				
				<xsl:variable name="mapwidth">
					<xsl:choose>
						<xsl:when test="/root/response/width"><xsl:value-of select="/root/response/width"/></xsl:when>
						<xsl:otherwise>370</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="mapheight">
					<xsl:choose>
						<xsl:when test="/root/response/width"><xsl:value-of select="/root/response/height"/></xsl:when>
						<xsl:otherwise>278</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="mapsrc">
					<xsl:choose>
						<xsl:when test="/root/response/imgUrl"><xsl:value-of select="/root/response/imgUrl"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="/root/gui/url"/>/images/default_bigmap.gif</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="mapscale">
					<xsl:choose>
						<xsl:when test="/root/response/scale"><xsl:value-of select="/root/response/scale"/></xsl:when>
						<xsl:otherwise>?</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				
				<tr>
					<td id="im_mapContainer" style="position:relative;width:{$mapwidth}px;height:{$mapheight}px;">
						<div id="im_map" style="position: relative;">
							<img id="im_bm_image" src="{$mapsrc}" />
							<!--<img id="im_mapImg" src="{//mapRoot/response/url}" />-->
							<img id="im_resize"
								src="{/root/gui/url}/images/transpcorner.png" 
								style="z-index:1000; position:absolute; bottom:0px; right:0px; cursor:se-resize" 
								alt="resize"/>
							<div id="im_bm_image_waitdiv" style="position: absolute; display:none; "><xsl:value-of select="/root/gui/strings/loadingMap" /></div>							
							<div id="im_scale" style="position: absolute; top:0px;" >
								1:<xsl:value-of select="$mapscale"/>
							</div>
						</div>
					</td>					
				</tr>
				
				<tr height="20px">
					<td>
						<table id="im_subtoolbar" class="padded_content">
							<tr>
								<td style="padding:2px"><a onClick="im_addLayer();"><img src="{/root/gui/url}/images/im_addLayer.png" title="{/root/gui/strings/findMapsMapServers}"/></a></td>
								<td style="padding:2px" onClick="im_openPDFform();" ><a><img src="{/root/gui/url}/images/acroread.png" title="{/root/gui/strings/exportAsPDF}"/></a></td>
								<!-- <td style="padding:2px" onClick="im_openPictureForm();" ><a><img src="{/root/gui/url}/images/im_exportPic.png" title="{/root/gui/strings/exportAsImage}"/></a></td> -->

								<!-- WMC buttons: you can choose between the full WMC menu, or single buttons that address the single services in the menu  -->
								<!-- This is the menu -->
 							   <!--<td style="padding:2px" onClick="im_openWMCform();" ><a><img src="{/root/gui/url}/images/wmc.png" title="{/root/gui/strings/wmcbuttonmain}"/></a></td>-->
								<!-- Following are the standalone buttons  -->
								<td style="padding:2px" onClick="im_openWMCform('mail');" ><a><img src="{/root/gui/url}/images/im_mail.png" title="{/root/gui/strings/wmcbuttonmail}"/></a></td>								
								<td style="padding:2px" onClick="im_openWMCform('upload');" ><a><img src="{/root/gui/url}/images/fileopen.png" title="{/root/gui/strings/wmcbuttonupload}"/></a></td>								
								<td style="padding:2px" onClick="im_downloadWMC();" ><a><img src="{/root/gui/url}/images/filesave.png" title="{/root/gui/strings/wmcbuttondownload}"/></a></td>
								
								<td width="100%" style="border-top:0px;"/> <!-- spacer -->								
								<td class="im_tool" id="im_tool_scale">
									<select name="im_setscale" id="im_setscale" onchange="javascript:im_bm_setScale();">
										<option id="im_currentscale" value=""><xsl:value-of select="/root/gui/strings/setScale" /></option>										
										<option value="50000000">1:50.000.000</option>
										<option value="10000000">1:10.000.000</option>
										<option value="5000000">1:5.000.000</option>
										<option value="1000000">1:1.000.000</option>
										<option value="500000">1:500.000</option>
										<option value="100000">1:100.000</option>
										<option value="50000">1:50.000</option>
										<option value="10000">1:10.000</option>
										<option value="5000">1:5.000</option>
										<option value="1000">1:1.000</option>										
									</select>
								</td>
								
							</tr>
						</table>						
					</td>					
				</tr>	
				
				<tr>
					<td colspan="2">
						<div id="im_whiteboard" style="position:relative;"/>
					</td>
				</tr>
			</table>
							
<!--			<div id="im_inspector" style="display:none;">
				<div id="im_transparencySlider" style="display:none;">
					<div id="im_transparencyHandle" style="display:none;"/> 
				</div>
				<div id="im_transparencyValue" style="display:none;"/>
				<div id="im_legendButton" style="display:none;"/>
			</div>
								
			<div id="im_addLayers" />
				
			<div id="im_debug" />
			<div id="im_geonetRecords" style="display:none" />  
-->
			
		</div> <!-- END OF IM CONTAINER -->
<!--			</html>
		</root>-->
<!--			</body>
		</html>-->
	</xsl:template>
	
	<xsl:template name="localization">
		<xsl:comment>These fields are needed for js on-the-fly translations</xsl:comment>	
		<xsl:for-each select="/root/gui/strings/*[@js='true']">			
			<input type="hidden" id="i18n_{name(.)}" value="{.}" />
		</xsl:for-each>				
		<xsl:comment>End of i18n fields</xsl:comment>	
	</xsl:template>	
	
</xsl:stylesheet>
