$(function(){
    setMainContentHeight();
    $(window).resize(setMainContentHeight)

    var noLeftNav = $.trim($("#left").text()) == "";
    if(noLeftNav){
        $("#main").css("width", "95%");
    }

    if(loggedIn && topTabName == "Admin"){
        $(".content").css("backgroundColor", "rgba(0, 0, 0, 0.2)");
    }

});

function setMainContentHeight(){
    var height = $(document).height();
    $("div.body").height(height + 25);
}