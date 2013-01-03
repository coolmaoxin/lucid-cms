function updateTable(data) {
    $("#ajaxContent").html(data);
    $("#searchListingsMessages").remove();
    $("#ajaxContent .paginateButtons").find("a").click(makeAjaxed);
    $("#ajaxContent .sortable a").click(makeAjaxed);
}
//e is either an event or a callback fn.
function fetchTowns(e){

    $.getJSON(ctxPath+"/ajax/radius?zipcode="+$("#location").val()+"&distance="+$("#distance").val(), function(d){
      if(d.length){
        var html = ["<ul style='top:0px'>"];
        var ids = [];
        for(var i = 0; i < d.length; i++){
          ids.push(d[i].id);
          html.push("<li><input class='townCheckbox' type='checkbox' name='"+d[i].id+"' id='town"+i+"' checked='checked'/> <label for='town"+i+"'>"+d[i].name+"</label><span class='distance'>"+(Math.round(d[i].distance*10)/10)+" miles</span></li>");
        }
        html.push("</ul>");
        html.push("<input type='hidden' name='townIds' value='"+ids.join(",")+"'/>");
        $("#towns").html(html.join(""));
        $("#towns input.townCheckbox").change(function(){
            if($("input.townCheckbox:checked").length == 0){
                $(this).attr("checked", "checked");
            }
        })
        if($.isFunction(e)){
            e();
        }
      } else {
          $("#towns").html("<br/>"+(d.error ? d.error : "No results found.<br/>"+$("#towns").html()));
      }
      $("#toggleSelected").attr("checked", "checked");
    });
    e && e.preventDefault && e.preventDefault();
}

$(function() {

    $(document).bind("rangeSliderChange sliderChange", function() {
        $("#offset").val("0"); //if user changes search settings they will be on page 1 next search
    });
    //show dialog when a listing is clicked
    var $dialog = $('<div style="display:none"></div>').appendTo('body');
    $dialog.dialog({"position": "top", "width": loggedIn ? "850px" : "500px", resizable:false, modal:loggedIn, title:"View MLS Listing", autoOpen:false});

    $("#mlsListings tr").live("click", function(e) {
        var $t = $(e.target).parents("tr");
        if ($t.is(".listingPopup")) {
            var id = $t.attr("listing");
            $dialog.load(
                ctxPath + "/searchListings/show?id=" + id,
                function () {
                    $dialog.dialog("open");
                    if(loggedIn){
                        $("#slideshowImages").galleria({height: 550});
                    } else {
                       setZipcodeViaGeolocation($("#zip"));
                    }
                }
            );
            e.preventDefault();
        }
    });



    $("#location").mask("99999");
    $("#distance").constrain("[0-9]");

    $("#location,#distance").blurOrEnter(fetchTowns);

    //toggle checkbox above search towns
    $("#toggleSelected").click(function(){
        var checked = !$(this).is(":checked");
        if(checked){
          $("#towns input.townCheckbox").each(function(){
            $(this).removeAttr("checked");
          });
          $("#towns input.townCheckbox:first").attr("checked","checked");
        } else {
          $("#towns input.townCheckbox").each(function(){
            $(this).attr("checked", "checked");
          });
        }
      });
})


function makeAjaxed(e) {
    var $this = $(this);
    var href = $this.attr("href");
    var sort = href.match(/sort=(\w+)/);
    var order = href.match(/order=(\w+)/);
    var offset = href.match(/offset=(\w+)/);
    if (sort && sort.length == 2) {
        $("#sort").val(sort[1]);
    }
    if (order && order.length == 2) {
        $("#order").val(order[1]);
    }
    if (offset && offset.length == 2) {
        $("#offset").val(offset[1]);
    }
    e.preventDefault();
    $("#mlsForm").submit();
}

//search starts
function loading() {
    var cont = $("#ajaxContent");
    cont.css("opacity", "0.5");
}

//search ends
function loaded() {
    var cont = $("#ajaxContent");
    cont.css("opacity", "1");

}