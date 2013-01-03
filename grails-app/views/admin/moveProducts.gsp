<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>

    <h1>Move products from on page to another</h1>

${flash.message}<br/>

<div>
    <g:form action="moveProductsSubmit" controller="admin" class="uniForm ui-corner-all">

        <div class="ctrlHolder">
            <label>Move products from</label>
            <g:select required="required" id="from" name="fromId" value="" from="${navs}" noSelection="['':'Select a page']" optionKey="id" optionValue="${{it.crumb + ' (has '+it.products.size()+' products)'}}" />
            <p class="formHint">This is the source page from which the products will be moved</p>
        </div>
        <div class="ctrlHolder hidden" id="list">
            <label>Select products to move</label>
            <ul id="moveList"></ul>
            <p class="formHint"></p>
        </div>
        <div class="ctrlHolder">
            <label>Move products to</label>
            <g:select required="required" id="to" name="toId" from="${navs}" noSelection="['':'Select a page']" optionKey="id" optionValue="${{it.crumb + ' (has '+it.products.size()+' products)'}}" />
            <p class="formHint">This is the destination page to which the products will be moved</p>
        </div>

        <g:submitButton name="move" value="Move Products"/>
        <input type="button" value="Back to admin" id="exitNoSave"/>
    </g:form>
</div>

<script type="text/javascript">

    var map = ${map};

    $(function(){
        $("#from").change(function(){
            if(this.value != ""){
                $("#list").show();
                $("#moveList").html(buildList(this.value));
            }
        })
    })

    function buildList(id){
        var out = [];
        var names = [];
        $.each(map[id], function(){
            names.push("p_"+this.id);
            out.push("<li><input type='checkbox' name='p_"+this.id+"' checked='checked' value='true'/>"+this.name+"</li>");
        })
        out.push("<input type='hidden' name='productIds' value='"+names.join(",")+"'/>");
        return out.join("");
    }

</script>
</body>
</html>

