<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Create a new page</h1>
Ok, you want to add a new page. When you add a new page it must appear under a navigation tab. It can either appaer as
a top level tab, or it can appear inside one of the top tabs. <br/><br/>
<span class="important">Top level tabs are good for content that will draw a user's attention because it will always be visible.</span><br/>
On the other hand, if you create a navigation item under one of the top level tabs, this item will not be visible until
the user clicks on the tab this item is under.<br/><br/>
<span class="important">Navigation items under a tab are good for content that can be groupped together</span>. For example a top
level tab 'Services' might have 3 left navigation items under it 'Sales', 'Marketing' and 'Logistics'.<br/><br/>


<div id="newPageEdit">
    <form class="uniForm ui-corner-all" id="newPageForm" method="post" action="/grails/admin">
        <fieldset>
            <div class="ctrlHolder">Create a new top tab:</div>
            <div class="ctrlHolder">
                <label>Display page in navigation:</label>
                <input type="checkbox" name="showInNav" checked="checked" id="showInNav"/>
                <p class="formHint">Uncheck if you dont not wish for this page to appear in the page naviation. You may want to do this if you want to create a link to this page manually but do not want it to appear as a naviation item.</p>
            </div>
            <div class="ctrlHolder">
                <label>Tab Text</label>
                <input required="required" id="name" type="text" class="textInput" size="35" value="" name="name">
                <p class="formHint">Required. This is will be the text of the tab. ex: 'Contact Us'</p>
            </div>
            <div class="ctrlHolder">
                <label>SEO URL</label>
                <input required="required" id="urlPath" type="text" class="textInput" size="45" value="" name="urlPath">
                <p class="formHint">Required. The URL of your new tab will include this. It is generated for you and you shouldnt need to change it.</p>
            </div>
            <div class="ctrlHolder">
                <label>Create navigation under:</label>
                <g:select id="parentId" name="parentId" from="${navs}" noSelection="['':'[Create a new top level tab]']" optionKey="id" optionValue="name"/>
                <p class="formHint">Choose where the navigation for this page will appear. Choose 'Top level tab' if you want to create a new tab, or choose a tab under which a new left navigation item will be created</p>
            </div>
            <div class="ctrlHolder">
                <label>Navigation Heading</label>
                <input id="navHeading" type="text" class="textInput" size="70" value="" name="parentNavigationHeading">
                <p class="formHint">Left navigation items can have an optional navigation title that will appear above the navigation. ex: 'Services'</p>
            </div>
            <div class="buttonHolder">
                <input type="button" id="createNewPage" value="Create page and edit it's content"/>
                <input type="button" id="exit" value="Back to admin"/>
            </div>
        </fieldset>
    </form>

</div>
<script type="text/javascript">
    var $options = $("#options");
    var navTitles = ${navigationHeadingsJson};



    $(function() {
        var $createNewPageForm = $("#newPageForm");

        $createNewPageForm.validator();
        $("#name").change(function() {
            generateUrlPath();
        }).val("");
        $("#urlPath").val("")
        $("#navHeading").attr("disabled", "disabled").val("");
        $("#parentId").val("");

        var $disableList = $("#parentId,#navHeading");
        $("#showInNav").change(function(){
            if($(this).is(":checked")){
                $disableList.removeAttr("disabled");
            } else {
                $disableList.attr("disabled", "disabled");
            }
        });

        $("#parentId").change(function(){ //when they select a parent, set its navigation heading into form
            var id = this.value;
            if(id in navTitles){
                $("#navHeading").removeAttr("disabled").val(navTitles[id]);
            } else {
                $("#navHeading").attr("disabled", "disabled").val("");
            }
        });

        $("#createNewPage").click(function(){
            if(!$createNewPageForm.data("validator").checkValidity()){
                return false;
            }
            $.post(ctxPath+"/admin/createNavigationAjax?"+$createNewPageForm.serialize(), function(data){
                if(data.success){
                    $.jGrowl("Page created!");
                    window.location.href = ctxPath+"/admin/editUserHtml?id="+data.htmlId;
                } else {
                    $.jGrowl("Could not create page:"+data.error);
                }
            })

        });
    });
</script>
</body>
</html>