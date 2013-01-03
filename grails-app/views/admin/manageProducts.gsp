<%@ page import="com.dogself.merchant.Product" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<g:if test="${createNew}">
    <h1>Create a new product</h1>
</g:if>

<g:if test="${!createNew}">
    <h1>Edit an existing product</h1>
    <g:select id="products" from="${products}" noSelection="['':'Select a Product to Edit']" optionKey="id" optionValue="name"/>
</g:if>

${flash.message}<br/>

<div>
    <g:form action="createOrUpdateProductSubmit" controller="admin" class="uniForm ui-corner-all">
        <g:if test="${createNew}">
            <g:render template="/templates/admin/editProduct" model="['p':new Product(),'navs':navs]"/>
        </g:if>
        <div id="ajaxProduct"></div>
        <g:submitButton name="createMore" value="Save and create another"/>
        <g:submitButton name="manageImages" value="Save and manage product images"/>
        <g:submitButton name="saveAndExit" value="Save and exit"/>
        <input type="button" value="Back to admin" id="exitNoSave"/>
    </g:form>
</div>

<div style="clear: both;"></div>
<script type="text/javascript">
    $(function(){
        var $form = $("form");
<g:if test="${createNew}">
        $form.validator();
</g:if>
<g:if test="${!createNew}">
        $form.hide();
        $("#products").change(function(){
            destroyValidator($form);
            $.get(ctxPath+"/admin/editProductAjax?id="+this.value, function(d){
                if (CKEDITOR.instances.editor){
                    CKEDITOR.instances.editor.destroy();
                }
                $("#ajaxProduct").html(d)
                $form.show();
                setTimeout(setMainContentHeight, 200);
                $form.validator();
            })
        }).val("");
</g:if>
    })

</script>
</body>
</html>