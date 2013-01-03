<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Delete a page</h1>
Choose a page you would like to delete. Once a page is deleted, it is gone <b>there is no undo</b>.

<br/>
<br/>

<form class="uniForm ui-corner-all" id="newPageForm" method="post" action="/">
    <fieldset>
        <div class="ctrlHolder">
            <label>Delete the following page:</label>
            <g:select id="navId" name="navId" from="${pages}" noSelection="['':'Pick a page to delete']" optionKey="id" optionValue="name"/>
            <p class="formHint">Be careful, there is no undo for deletion!</p>
        </div>
        %{--only show the next div on sites that actually have products--}%
        <g:if test="${siteComponents.products}">
        <div class="ctrlHolder">
            <label>The page you are about to delete has:</label>
            <span id="numProducts" class="red" >0</span> Products.
            <p class="formHint">Products that belong to a page will be <b>deleted</b> when the page is deleted.</p>
        </div>
        </g:if>
        <div class="buttonHolder">
            <input type="button" id="deletePage" value="Delete selected page"/>
            <input type="button" id="exitNoSave" value="Back to admin"/>
        </div>
    </fieldset>
</form>
<script type="text/javascript">
    var productPages = {};
    <g:each in="${pages}">
    productPages["${it.id}"] = ${it.numProducts};
    </g:each>
    $(function(){
        $("#navId").change(function(){
            if(this.value != ""){
                $("#numProducts").text(productPages[this.value]);
            }
        }).val("");
        $("#deletePage").click(function(){
            var id = $("#navId").val();
            if(id == ""){
                $.jGrowl("Pick a page to delete");
            } else {
                var cfm = "Are you SURE you want to delete this page?";
                if(productPages[id] > 0){
                    cfm += "\n"+productPages[id]+" Product(s) belong to it, they will also be deleted!";
                }

                if(window.confirm(cfm)){
                    $.post(ctxPath+"/admin/deleteNavigationAjax?id="+id, function(data){
                        if(data.success){
                            $.jGrowl("Page deleted!");
                            window.location.href = ctxPath+"/admin/admin";
                        } else {
                            $.jGrowl("Could not delete page:"+data.error);
                        }
                    });
                }
            }
        });
    });

</script>
</body>
</html>