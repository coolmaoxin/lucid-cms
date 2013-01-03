$(function() {
    
    var $s  = $(".scaffold");
    if($s.is(".list")){
        var $table = $s.find("table");
        $table.click(function(e){
           var $target = $(e.target);
           if($target.is("td")){
               var $firstTd = $target.prevAll("td:last");
               $firstTd = $firstTd.length ? $firstTd : $target;
               var link = $firstTd.find("a").attr("href");
               window.location.href = link;
               e.preventDefault();
           }
        });
    }

    $("#exit").click(function(){
        if (window.confirm("Are you sure you want to leave without saving?")) {
            window.location.href = ctxPath + "/admin/admin";
        }
    });
    $("#exitNoSave").click(function(){
        window.location.href = ctxPath + "/admin/admin";
    });
    $("#startOver").click(function(){
        window.location.reload();
    });

});

// function to create SEO URL from a name, aka urlPath
function generateUrlPath() {
    var val = $.trim($("#name").val());
    var urlPath = val.replace(/[\W+]/g, " ").replace(/ +/g, "-").replace(/-$|^-/g, "").toLowerCase();
    $("#urlPath").val(urlPath)
    $("#name").val(val); //just 'name' gets the trimmed value
}