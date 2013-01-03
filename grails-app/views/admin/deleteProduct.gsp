<%@ page import="com.dogself.merchant.Product" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>

<h1>Delete a Product</h1>
Deleting a product will remove the product from the site, and also remove the product's images.<br/>
Deleting a product <b>cannot be undone</b>, tread carefully.<br/><br/>




<div>
    <g:form action="deleteProductSubmit" controller="admin" class="uniForm ui-corner-all">
        <fieldset>
        <div class="ctrlHolder">
            <label>Delete the following product:</label>
            <g:select id="products" name="productId" from="${products}" noSelection="['':'Select a product to delete']" optionKey="id" optionValue="name"/>
            <p class="formHint">Be careful, there is no undo for deletion!</p>
        </div>
        <div class="buttonHolder">
            <input type="button" id="delete" value="Delete selected product"/>
            <input type="button" id="exitNoSave" value="Back to admin"/>
        </div>
    </fieldset>


    </g:form>
</div>

<div style="clear: both;"></div>
<script type="text/javascript">
    $("#delete").click(function(){
        var id = $("#products").val();
        if(id == ""){
            $.jGrowl("Pick a product to delete");
        } else {
            if(window.confirm("Are you SURE you want to delete this product?")){
                $.post(ctxPath+"/admin/deleteProductSubmit?productId="+id, function(data){
                    $.jGrowl("Product deleted!");
                    window.location.href = ctxPath+"/admin/admin";
                });
            }
        }
    })

</script>
</body>
</html>