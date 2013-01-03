/**
 * jQuery gMap v3
 *
 * @url         http://www.smashinglabs.pl/gmap
 * @author      Sebastian Poreba <sebastian.poreba@gmail.com>
 * @version     3.1.0 RC2
 * @date        13.04.2011
 *
 */
(function($){var $googlemaps=google.maps,$geocoder=new $googlemaps.Geocoder(),opts={},$markersToLoad=0,methods={init:function(options){opts=$.extend({},$.fn.gMap.defaults,options);for(var k in $.fn.gMap.defaults.icon){if(!opts.icon[k]){opts.icon[k]=$.fn.gMap.defaults.icon[k];}}
return this.each(function(){var $this=$(this),center=methods._getMapCenter.apply($this,[]),mapOptions={zoom:opts.zoom,center:center,mapTypeControl:opts.mapTypeControl,zoomControl:opts.zoomControl,panControl:opts.panControl,scaleControl:opts.scaleControl,streetViewControl:opts.streetViewControl,mapTypeId:opts.maptype,scrollwheel:opts.scrollwheel};if(opts.log){console.log('map center is:');}
if(opts.log){console.log(center);}
var $gmap=new $googlemaps.Map(this,mapOptions);$this.data("$gmap",$gmap);$this.data('gmap',{'opts':opts,'gmap':$gmap,'markers':[],'infoWindow':null});if(opts.controls.length!==0){for(var i=0;i<opts.controls.length;i+=1){$gmap.controls[opts.controls[i].pos].push(opts.controls[i].div);}}
if(opts.markers.length!==0){for(var i=0;i<opts.markers.length;i+=1){methods.addMarker.apply($this,[opts.markers[i]]);}}
methods._onComplete.apply($this,[]);});},_onComplete:function(){var $data=this.data('gmap'),that=this;if($markersToLoad!==0){window.setTimeout(function(){methods._onComplete.apply(that,[])},1000);return;}
$data.opts.onComplete();},_setMapCenter:function(center){if(opts.log){console.log('delayed setMapCenter called');}
var $data=this.data('gmap');if($data.gmap!==undefined){$data.gmap.setCenter(center);}else{var that=this;window.setTimeout(function(){methods._setMapCenter.apply(that,[center]);},500);}},_getMapCenter:function(){var center,that=this;if(opts.latitude&&opts.longitude){center=new $googlemaps.LatLng(opts.latitude,opts.longitude);return center;}else{center=new $googlemaps.LatLng(0,0);}
if(opts.address){$geocoder.geocode({address:opts.address},function(result,status){if(status===google.maps.GeocoderStatus.OK){methods._setMapCenter.apply(that,[result[0].geometry.location]);}else{if(opts.log){console.log("Geocode was not successful for the following reason: "+status);}}});return center;}
if($.isArray(opts.markers)&&opts.markers.length>0){var selectedToCenter=null;for(var i=0;i<opts.markers.length;i+=1){if(opts.markers[i].latitude&&opts.markers[i].longitude){selectedToCenter=opts.markers[i];break;}
if(opts.markers[i].address){selectedToCenter=opts.markers[i];}}
if(selectedToCenter===null){return center;}
if(selectedToCenter.latitude&&selectedToCenter.longitude){return new $googlemaps.LatLng(selectedToCenter.latitude,selectedToCenter.longitude);}
if(selectedToCenter.address){$geocoder.geocode({address:selectedToCenter.address},function(result,status){if(status===google.maps.GeocoderStatus.OK){methods._setMapCenter.apply(that,[result[0].geometry.location]);}else{if(opts.log){console.log("Geocode was not successful for the following reason: "+status);}}});}}
return center;},processMarker:function(marker,gicon,gshadow,location){var $data=this.data('gmap'),$gmap=$data.gmap;if(location===undefined){location=new $googlemaps.LatLng(marker.latitude,marker.longitude);}
if(!gicon){var _gicon={image:opts.icon.image,iconSize:new $googlemaps.Size(opts.icon.iconsize[0],opts.icon.iconsize[1]),iconAnchor:new $googlemaps.Point(opts.icon.iconanchor[0],opts.icon.iconanchor[1]),infoWindowAnchor:new $googlemaps.Size(opts.icon.infowindowanchor[0],opts.icon.infowindowanchor[1])};gicon=new $googlemaps.MarkerImage(_gicon.image,_gicon.iconSize,null,_gicon.iconAnchor);}
if(!gshadow){var _gshadow={image:opts.icon.shadow,iconSize:new $googlemaps.Size(opts.icon.shadowsize[0],opts.icon.shadowsize[1]),anchor:(_gicon&&_gicon.iconAnchor)?_gicon.iconAnchor:new $googlemaps.Point(opts.icon.iconanchor[0],opts.icon.iconanchor[1])};}
var gmarker=new $googlemaps.Marker({position:location,icon:gicon,title:marker.title,map:$gmap});gmarker.setShadow(gshadow);$data.markers.push(gmarker);var infoWindow;if(marker.html){var infoOpts={content:opts.html_prepend+marker.html+opts.html_append,pixelOffset:marker.infoWindowAnchor};if(opts.log){console.log('setup popup with data');}
if(opts.log){console.log(infoOpts);}
infoWindow=new $googlemaps.InfoWindow(infoOpts);$googlemaps.event.addListener(gmarker,'click',function(){if(opts.log){console.log('opening popup '+marker.html);}
if(opts.singleInfoWindow&&$data.infoWindow){$data.infoWindow.close();}
infoWindow.open($gmap,gmarker);$data.infoWindow=infoWindow;});}
if(marker.html&&marker.popup){if(opts.log){console.log('opening popup '+marker.html);}
infoWindow.open($gmap,gmarker);}},_geocodeMarker:function(marker,gicon,gshadow){$markersToLoad+=1;var that=this;$geocoder.geocode({'address':marker.address},function(results,status){$markersToLoad-=1;if(status===$googlemaps.GeocoderStatus.OK){methods.processMarker.apply(that,[marker,gicon,gshadow,results[0].geometry.location]);}else{if(opts.log){console.log("Geocode was not successful for the following reason: "+status);}}});},addMarker:function(marker){if(opts.log){console.log("putting marker at "+marker.latitude+', '+marker.longitude+" with address "+marker.address+" and html "+marker.html);}
var _gicon={image:opts.icon.image,iconSize:new $googlemaps.Size(opts.icon.iconsize[0],opts.icon.iconsize[1]),iconAnchor:new $googlemaps.Point(opts.icon.iconanchor[0],opts.icon.iconanchor[1]),infoWindowAnchor:new $googlemaps.Size(opts.icon.infowindowanchor[0],opts.icon.infowindowanchor[1])},_gshadow={image:opts.icon.shadow,iconSize:new $googlemaps.Size(opts.icon.shadowsize[0],opts.icon.shadowsize[1]),anchor:_gicon.iconAnchor};marker.infoWindowAnchor=_gicon.infoWindowAnchor;if(marker.icon){if(marker.icon.image){_gicon.image=marker.icon.image;}
if(marker.icon.iconsize){_gicon.iconSize=new $googlemaps.Size(marker.icon.iconsize[0],marker.icon.iconsize[1]);}
if(marker.icon.iconanchor){_gicon.iconAnchor=new $googlemaps.Point(marker.icon.iconanchor[0],marker.icon.iconanchor[1]);}
if(marker.icon.infowindowanchor){_gicon.infoWindowAnchor=new $googlemaps.Size(marker.icon.infowindowanchor[0],marker.icon.infowindowanchor[1]);}
if(marker.icon.shadow){_gshadow.image=marker.icon.shadow;}
if(marker.icon.shadowsize){_gshadow.iconSize=new $googlemaps.Size(marker.icon.shadowsize[0],marker.icon.shadowsize[1]);}}
var gicon=new $googlemaps.MarkerImage(_gicon.image,_gicon.iconSize,null,_gicon.iconAnchor);var gshadow=new $googlemaps.MarkerImage(_gshadow.image,_gshadow.iconSize,null,_gshadow.anchor);if(marker.address){if(marker.html==='_address'){marker.html=marker.address;}
if(marker.title=='_address'){marker.title=marker.address;}
if(opts.log){console.log('geocoding marker: '+marker.address);}
methods._geocodeMarker.apply(this,[marker,gicon,gshadow]);}
else{if(marker.html==='_latlng'){marker.html=marker.latitude+', '+marker.longitude;}
if(marker.title=='_latlng'){marker.title=marker.latitude+', '+marker.longitude;}
var gpoint=new $googlemaps.LatLng(marker.latitude,marker.longitude);methods.processMarker.apply(this,[marker,gicon,gshadow,gpoint]);}},removeAllMarkers:function(){var markers=this.data('gmap').markers,i;for(i=0;i<markers.length;i+=1){markers[i].setMap(null);}
markers=[];}};$.fn.gMap=function(method){if(methods[method]){return methods[method].apply(this,Array.prototype.slice.call(arguments,1));}else if(typeof method==='object'||!method){return methods.init.apply(this,arguments);}else{$.error('Method '+method+' does not exist on jQuery.gmap');}};$.fn.gMap.defaults={log:false,address:'',latitude:null,longitude:null,zoom:3,markers:[],controls:{},scrollwheel:true,maptype:google.maps.MapTypeId.ROADMAP,mapTypeControl:true,zoomControl:true,panControl:false,scaleControl:false,streetViewControl:true,singleInfoWindow:true,html_prepend:'<div class="gmap_marker">',html_append:'</div>',icon:{image:"http://www.google.com/mapfiles/marker.png",iconsize:[20,34],iconanchor:[9,34],infowindowanchor:[9,2],shadow:"http://www.google.com/mapfiles/shadow50.png",shadowsize:[37,34]},onComplete:function(){}};}(jQuery));


/*
Polylines with arrows in Google Maps API v3
by Pavel Zotov
http://yab.hot-line.su/
2011-02-19
*/
GPolylineWithArrows = function( options ) {
	this.options = options;
	this.arrows = [];
}
GPolylineWithArrows.prototype = new google.maps.OverlayView();
GPolylineWithArrows.prototype.onAdd = function() {
	this.polyline = new google.maps.Polyline({
		path: this.options.path,
		strokeColor: this.options.strokeColor,
		strokeWeight: this.options.strokeWeight,
		strokeOpacity: this.options.strokeOpacity
	});
	this.polyline.setMap( this.getMap() );
}
GPolylineWithArrows.prototype.onRemove = function() {
	for( var i=this.arrows.length; i>0; i-- ){
		this.arrows[i-1].setMap( null );
		delete this.arrows[i-1];
		this.arrows.length--;
	}
	this.polyline.setMap(null);
	delete this.polyline;
}
GPolylineWithArrows.prototype.draw = function() {
	for( var i=this.arrows.length; i>0; i-- ){
		this.arrows[i-1].setMap( null );
		delete this.arrows[i-1];
		this.arrows.length--;
	}

	var prj = this.getProjection(), middle;
	for( var i=1; i<this.options.path.length; i++ ){
		var p1 = prj.fromLatLngToContainerPixel( this.options.path[i] ),
			p0 = prj.fromLatLngToContainerPixel( this.options.path[i-1] ),
			vector = new google.maps.Point( p1.x - p0.x, p1.y - p0.y ),
			length = Math.sqrt( vector.x * vector.x + vector.y * vector.y ),
			normal = new google.maps.Point( vector.x/length, vector.y/length );

		if( length>this.options.arrowSize ){
			if( this.options.middleArrow ) middle = new google.maps.Point( (p1.x + p0.x)/2, (p1.y + p0.y)/2 );
			else middle = p1;
			var offsetMiddle = new google.maps.Point( normal.x*this.options.arrowSize, normal.y*this.options.arrowSize ),
				arrowPart1 = new google.maps.Point( -offsetMiddle.y*0.4, offsetMiddle.x*0.4 ),
				arrowPart2 = new google.maps.Point( offsetMiddle.y*0.4, -offsetMiddle.x*0.4 ),
				arrowPoint1 = new google.maps.Point( middle.x - offsetMiddle.x + arrowPart1.x, middle.y - offsetMiddle.y + arrowPart1.y ),
				arrowPoint2 = new google.maps.Point( middle.x - offsetMiddle.x + arrowPart2.x, middle.y - offsetMiddle.y + arrowPart2.y );

			this.arrows[i-1] = new google.maps.Polygon({
				map: this.getMap(),
				path: [
					prj.fromContainerPixelToLatLng(middle),
					prj.fromContainerPixelToLatLng(arrowPoint1),
					prj.fromContainerPixelToLatLng(arrowPoint2)
				],
				fillColor: this.options.fillColor ? this.options.fillColor : this.options.strokeColor,
				fillOpacity: this.options.fillOpacity ? this.options.fillOpacity : this.options.strokeOpacity,
				strokeColor: this.options.arrowStrokeColor ? this.options.arrowStrokeColor : this.options.strokeColor,
				strokeOpacity: this.options.arrowStrokeOpacity ? this.options.arrowStrokeOpacity : this.options.strokeOpacity,
				strokeWeight: this.options.arrowStrokeWeight ? this.options.arrowStrokeWeight : this.options.strokeWeight
			});
		}
	}
}
