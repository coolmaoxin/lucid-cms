<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Rename a page</h1>
Here you can rename a tab or a left navigation item. Choose a page to rename.

<br/>
<br/>

<form class="uniForm ui-corner-all" id="newPageForm" method="post" action="/">
    <fieldset>
        <div class="ctrlHolder">
            <label>Rename the following page:</label>
            <g:select id="navId" name="navId" from="${pages}" noSelection="['':'Pick a page to rename']" optionKey="id" optionValue="name"/>
        </div>
        <div class="ctrlHolder hidden edit">
            <label>New Name:</label>
            <input type="text" maxlength="35" class="textInput" id="name" name="name" value=""/>
            <p class="formHint">Required. This new name will be the tab or left navigation name</p>
        </div>
        <div class="ctrlHolder hidden edit">
            <label>New SEO URL:</label>
            <input id="urlPath" type="text" class="textInput" size="45" value="" name="urlPath">
            <p class="formHint">Required. The URL of your new tab will include this. It is generated for you and you shouldnt need to change it.</p>
        </div>
        <div class="buttonHolder">
            <input type="button" class="edit hidden" id="renamePage" value="Rename selected page"/>
            <input type="button" id="startOver" value="Start Over"/>
            <input type="button" id="exitNoSave" value="Back to admin"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    $(function(){
        var $edit = $(".edit");
        var $sel = $("#navId");

        $sel.removeAttr("disabled");
        
        $("#name").change(function() {
            generateUrlPath();
        }).val("");

        $sel.change(function(){
            if(this.value != ""){
                $sel.attr("disabled", "disabled");
                $edit.show();
            } else {
                $sel.removeAttr("disabled");
                $edit.hide();
            }
        }).val("");

        $("#renamePage").click(function(){
            var id = $("#navId").val();
            var name = $("#name").val();
            var urlPath = $("#urlPath").val();
            if(id == ""){
                $.jGrowl("Pick a page to rename");
            } else if(name == ""){
                $.jGrowl("Name must not be blank");
                $("#name").focus();
            } else if(urlPath == ""){
                $.jGrowl("SEO URL must not be blank");
                $("#urlPath").focus();
            } else {
                $.post(ctxPath+"/admin/renameNavigationAjax",{
                    "id":id,
                    "name":name,
                    "urlPath":$("#urlPath").val()
                }, function(data){
                    if(data.success){
                        $.jGrowl("Page renamed!");
                        window.location.reload();
                    } else {
                        $.jGrowl("Could not rename page: "+data.error);
                    }
                });
            }
        });
    });
</script>
</body>
</html>