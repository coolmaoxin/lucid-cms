$(function(){
    floatRemaxLogo()
})

function floatRemaxLogo(){
    var $it = $("#remaxLogo");
    var top = $it.offset().top;
    $it.animate({
        opacity: 1,
        top: '-='+top
      }, topTabName == "Home" ? 5000 : 0);
}