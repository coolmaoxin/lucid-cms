<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<style>
    guestbookView tr:hover {
        background-color:
    }
</style>
<g:userEditableSection name="View Pipes - Page Top"/>
<g:form controller="stealThisPipe" action="guestbookShow">
    <span style="font-family: 'Permanent Marker',serif;font-size:25px">Track a pipe</span>: <select id="track" name="show">
    <option value="">Show all pipes</option>
    <option value="MA">Show all MA pipes</option>
    <option value="NH">Show all NH pipes</option>
    <g:each in="${pipes}">
        <option value="${it}">Show only ${it}</option>
    </g:each>
</select>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="font-family: 'Permanent Marker',serif;font-size:25px">Most Active Pipe:</span> <a style="color:red" href='${request.contextPath}/pages/pipes-show?show=${mostActive}'>${mostActive}</a>
</g:form>
<span class="guestbookLeft">
    <g:each in="${list}" status="stat" var="guest">
        <table class="guestbookView" id="${list.size() - stat - 1}">
        <tbody>
        <tr>
            <td width="25%">Name:</td>
            <td width="75%">${guest.name.encodeAsHTML()}</td>
        </tr><tr>
        <td>Pipe Stolen:</td>
        <td><span class="${guest.fields.pipe.encodeAsHTML()}">${guest.fields.pipe.encodeAsHTML()}</span></td>
    </tr><tr>
        <td>Place Stolen:</td>
        <td>${guest.fields.place.encodeAsHTML()}</td>
    </tr><tr>
        <td>Date Logged:</td>
        <td><g:dateFormat date="${guest.dateCreated}"/></td>
    </tr><tr>
        <td>Comments:</td>
        <td>${guest.comment.encodeAsHTML()}</td>
    </tr>
        <tr>
            <td colspan="2"><div class="guestbookSep"></div></td>
        </tr>
        </tbody>
</table>
    </g:each>
</span>


<div class="guestbookMap">
    <div id="map"></div>&nbsp;
</div>
<script type="text/javascript">
    var colors = {
        "MA01":"#800000",
        "MA02":"#FF0000",
        "MA03":"#800080",
        "MA04":"#FF00FF",
        "MA05":"#FFA500",
        "NH01":"#008000",
        "NH02":"#00FF00",
        "NH03":"#000080",
        "NH04":"#FF0000",
        "NH05":"#CC6633"
    }
    $(function(){
        var $entries = $(".guestbookView");
        $entries.click(function(){
            var idx = this.id;
            var markers = $("#map").data("gmap").markers;
            var map = $("#map").data("gmap").gmap;
            for(var i = 0; i < markers.length; i++){
                markers[i].setAnimation(i == idx ? google.maps.Animation.BOUNCE : null)
                if(i == idx){
                    map.panTo(markers[i].getPosition());
                }
            }
            $entries.css("backgroundColor", "inherit");
            $(this).css("backgroundColor", "#4F4221");
        });
        for(var pipe in colors){
            $("."+pipe).css("color",colors[pipe]);
        }
        $.getJSON(ctxPath+"/stealThisPipe/getMarkers?show=${show}", function(data){
            var m = data.lives;
            if(m.length){

                var markers = data.markers;

                $("#map").gMap({
                    zoom: 8,
                    "markers":markers
                });

                $.each(m, function(){

                    var map1 = $("#map").data("gmap").gmap;
                    var pts1 = [];
                    $.each(this.markers, function(){
                        pts1.push(new google.maps.LatLng( this.latitude, this.longitude ))
                    });
                    var poly1 = new GPolylineWithArrows({
                        path: pts1,
                        strokeColor: colors[this.name],
                        strokeOpacity: 1,
                        strokeWeight: 2,
                        arrowStrokeColor: '#000000',
                        arrowStrokeOpacity: 1,
                        arrowStrokeWeight: 1,
                        fillColor: colors[this.name],
                        fillOpacity: 1,
                        arrowSize: 13
                    });
                    poly1.setMap(map1);

                })

                

            }
        });
    });

    $("#track").change(function(){
        $("form").submit();
    }).val("${show}")
</script>
</body></html>