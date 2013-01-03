var $main;
var $tab;
var $logo;
var $footer;
var $leftNav;
//there is also a global var: topTabName, ctxPath

$(function(){
   $main = $("#mainContent");
   $tab = $("#tabContent");
   $logo = $("#logoContent");
   $footer = $("#footerContent");
   $leftNav = $("#leftNav");
   $(".dialog").dialog({ autoOpen: false });
    
   setMainContentHeight();
   $(window).resize(setMainContentHeight);



   wireLeftNav();


   var leftNavCont = $.trim($("#leftNav").text());
   if(leftNavCont == ""){
       $("#leftNav").css("width", "0");
       $("#rightContent").css("width", "100%");
   }
   bindRegistrationLink();

   $("#tabs ul#tabContent li").hover(function(){
       $(this).addClass("ui-state-hover");
   },function(){
       $(this).removeClass("ui-state-hover")
   });

});

function bindRegistrationLink(){
    $("#registerLink").click(function(e){
        var $dialog = $('<div style="display:none"></div>').appendTo('body');
        $dialog.dialog({width:"500px", resizable:false, modal:false, title:"Register", autoOpen:false});
        $dialog.load(
            ctxPath + "/searchListings/showRegistration",
            function () {
                $dialog.dialog("open");
                setZipcodeViaGeolocation($("#zip"));
            }
        );
        e.preventDefault();
    });
}

function setZipcodeViaGeolocation($input){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position){
        $.getJSON(ctxPath+"/ajax/getZipcodeByLatLon?lat="+position.coords.latitude+"&lon="+position.coords.longitude, function(data){
          $input.val(data.zipcode);
        });
      }, function(){});
    }
}

function userRegComplete(data){
    if(data.success){
        $("#registerUserInfo").html("<div>Regisgration sucessful.</div><div>Check your email for a validation link to active your account.</div>");
    } else {
        $.each(data.errors, function(){
            $("#"+this.key+"Validation").html("<span style='color:red'>"+this.value+"</span>");
        });
    }
}


function setMainContentHeight(){
    if($main.length == 0){//non standard layout used
        return
    }
    if($(window).height() == $(document).height()){
        var height = Math.max($leftNav.height(), $(window).height() - ($main.offset().top + $tab.height() + $footer.outerHeight()));
        $main.height(height)
    }
}


function wireLeftNav(){
    var $nav = $("li.link");
    $nav.bind("mouseenter mouseleave",function(){
        if(!$(this).hasClass("nolink")){
            $(this).toggleClass("ui-tabs-selected ui-state-active")
        }
    });
}

function viewVisualTour(id){
    var url = "http://www.visualtour.com/applets/flashviewer2/viewer.asp?t="+id;
    var vtWindow = window.open(url, 'VirtualTour', 'resizable=yes,scrollbars=no,toolbar=no');
    vtWindow.document.bgColor="black";
}


/************** utils ****************/

function createRangeSlider(id, min, max, step){
    step = step || 1;
    min = ~~min;
    max = ~~max;
    var $minInput = $("#"+id+"Min");
    var $maxInput = $("#"+id+"Max");
    var $minInputVis = $("#"+id+"MinVisible");
    var $maxInputVis = $("#"+id+"MaxVisible");
    $("#"+id).slider({
        range: true,
        min: min,
        max: max,
        step: step,
        values: [ min, max ],
        slide: function(event, ui) {
            $minInputVis.val(formatNumber(ui.values[0]));
            $maxInputVis.val(formatNumber(ui.values[1]));
            $minInput.val((ui.values[0]));
            $maxInput.val((ui.values[1]));
            $(document).trigger("rangeSliderChange");
        }
    });
    $minInputVis.val(formatNumber(min));
    $minInput.val((min));
    $maxInputVis.val(formatNumber(max));
    $maxInput.val((max));
    $minInputVis.change(function(){
        var v = $minInputVis.val().replace(/,/g,'');
        $minInput.val(v);
        $(document).trigger("rangeSliderChange");
        $("#"+id).slider("values", 0, v);
    });
    $maxInputVis.change(function(){
        var v = $maxInputVis.val().replace(/,/g,'');
        $maxInput.val(v);
        $(document).trigger("rangeSliderChange");
        $("#"+id).slider("values", 1, v);
    });

}

function createSlider(id, min, max, step){
    step = step || 1;
    min = ~~min;
    max = ~~max;
    var initialValue = min;
    var $inputVis = $("#"+id+"MinVisible");
    var $input = $("#"+id+"Min");
    $("#"+id).slider({
        min: min,
        max: max,
        step: step,
        values: [initialValue],
        slide: function( event, ui ) {
            $inputVis.val(formatNumber(ui.value));
            $input.val((ui.value));
            $(document).trigger("sliderChange");
        }
    });
    $inputVis.val(formatNumber(initialValue));
    $input.val(initialValue);
    $inputVis.change(function(){
        var v = $inputVis.val().replace(/,/g,'');
        $input.val(v);
        $("#"+id).slider("value", v);
        $(document).trigger("sliderChange");
    })
}


function formatNumber(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

(function($) {
    $.fn.constrain = function(rgx) {
        var re = new RegExp(rgx);
        $.each(this, function() {
            var input = $(this);

            var keypressEvent = function(e) {
                e = e || window.event;
                var k = e.charCode || e.keyCode || e.which;
                if (e.ctrlKey || e.altKey || k == 8 || k == 13) {//Ignore
                    return true;
                } else if ((k >= 41 && k <= 122) || k == 32 || k > 186) {//typeable characters
                    return (re.test(String.fromCharCode(k)));
                }
                e.preventDefault();
            }
            input.bind("keypress", keypressEvent);
        });
        return this;
    };

    $.fn.blurOrEnter = function(settings) {
        var onBlur = typeof settings === "object" ? settings.blur : settings;
        var onEnter = settings.enter || onBlur;

        var that = this;
        var blurFn = function(e) {
            that.unbind("keydown.grails");
            onBlur.call(that, e);
            that.bind("keydown.grails", keyupFn);
        };
        var keyupFn = function(e) {
            if (e.keyCode == 13) {
                that.unbind("blur.grails");
                onEnter.call(that, e);
                that.bind("blur.grails", blurFn);
                return false;
            }
            return true;
        }
        return this.bind("blur.grails", blurFn).bind("keydown.grails", keyupFn);
    }

})(jQuery);


/**
 * handy function to get url query params
 * @param name
 */
function getParameterByName(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.href);
  if(results == null){
    return "";
  } else {
    return decodeURIComponent(results[1].replace(/\+/g, " "));
  }
}

function destroyValidator($form){
    var v = $form.data("validator");
    if(v){
        v.destroy();
    }
}