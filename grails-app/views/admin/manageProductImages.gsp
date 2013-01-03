<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Manage Pictures of Product: ${product.name}</h1>
<style>

    .mainProductImage {
        border: 1px solid red;
    }
    .imageOptions a{
        color:blue;
        display:block;
    }
    .qq-upload-list {
        display:none;
    }
    #upload {
        margin-left:25px;
        margin-bottom:10px;
    }


    .rotateLeft, .rotateRight {
        background: white url(${request.contextPath}/images/rotateCC.gif) no-repeat center center;
        border: none;
        height: 26px;
        margin: 2px 3px;
        width: 25px;
        float:right;
    }
    .rotateLeft:hover {
        background: #3B5998 url(${request.contextPath}/images/rotateCCover.gif) no-repeat center center;
    }
    .rotateRight {
        background: white url(${request.contextPath}/images/rotateCW.gif) no-repeat center center;
    }
    .rotateRight:hover {
        background: #3B5998 url(${request.contextPath}/images/rotateCWover.gif) no-repeat center center;
    }

</style>


<div id="upload" ></div>

<ul id="gallery">
<g:each in="${images}">
    <li>
    <img height="172" src="${request.contextPath}/productImage/${product.id}/thumb/${it}?a=a"/>
    <span class="imageOptions ${it == product.mainProductImageName ? 'mainProductImage':''}">
      <h3>${it}</h3>
      Main Product Image:<input type="radio" name="mainProductImage" class="productImageRadio" value="${it}"
          ${it == product.mainProductImageName ? 'checked':''}/><br/>
      <input class="rotateRight rotate" data-fn="${it}" data-clockwise="true"/>
      <input class="rotateLeft rotate" data-fn="${it}" data-clockwise="false"/>
      <a href="${request.contextPath}/productImage/${product.id}/${it}" data-val="${(int)Math.random()*1000}" class="viewFullSize">View Full Size</a>
      <a class="deleteImage" href="${it}">Delete Image</a>
    </span>
    </li>
</g:each>
</ul>
<input type="button" value="Back to admin" id="exitNoSave"/>
<div class="ui-helper-clearfix"></div>
<script type="text/javascript">
    var uploader = new qq.FileUploader({
        element: document.getElementById('upload'),
        // path to server-side upload script
        action: ctxPath+'/upload/productImages',
        params: {
            id: '${product.id}'
        },
        onSubmit: function(id, fn){
            $.jGrowl("Uploading "+fn+"...");
        },
        onComplete: function( id, fileName, responseJSON ) {
          if( responseJSON.success ){
           $('#gallery').append(
                '<li>'+
                  '<img height="172" src="${request.contextPath}/productImage/${product.id}/thumb/'+fileName+'?a=a"/>'+
                  '<span class="imageOptions">'+
                  '<h3>'+fileName+'</h3>'+
                  'Main Product Image:<input type="radio" value="'+fileName+'" class="productImageRadio" name="mainProductImage"><br/>'+
                  '<input class="rotateRight rotate" data-fn="'+fileName+'" data-clockwise="true"/>'+
                  '<input class="rotateLeft rotate" data-fn="'+fileName+'" data-clockwise="false"/>'+
                  '<a class="viewFullSize" href="'+ctxPath+'/productImage/${product.id}/'+fileName+'" data-val="0">View Full Size</a>'+
                  '<a href="'+fileName+'" class="deleteImage">Delete Image</a>'+
                '</span></li>'
              );
            $("#mainContent").css("height","auto");
          } else {
            $.jGrowl("Upload Failed: "+fileName);
          }
        }
    });
    $(function(){

        var rotating = false;
        $(".rotate").click(function(){
            if(rotating){
                $.jGrowl("Server is rotating an image, let that finish, or refresh this page.");
                return false;
            }
            rotating = true;
            var $this = $(this);
            var fn = $this.data("fn");
            var cw = $this.data("clockwise");
            $.get(ctxPath+"/admin/rotateProductImageAjax?productId=${product.id}&imageName="+fn+"&clockwise="+cw, function(d){
                if(d.success){
                    var $full = $this.siblings((".viewFullSize"));
                    var rnd = parseInt(Math.random()*1000, 10);
                    $full.data("val", rnd);
                    var $thumb = $this.parents("li").find("img");
                    $thumb.attr("src", $thumb.attr("src")+"&rnd="+rnd);
                } else {
                    $.jGrowl("Server error, could not rotate.");
                }
                rotating = false;
            })
        });

        $("#gallery").delegate(".deleteImage", "click", function(e){
            deleteImage($(e.target).attr("href"), e.target);
            return false;
        })

        $("#gallery").delegate(".viewFullSize", "click", function(e){
            var val = $(e.target).data("val");
            $.fancybox({
                'padding' : 0,
                'href' : $(this).attr("href")+"?val="+val
            })
            return false;
        })

        $("#gallery").delegate(".productImageRadio", "click", function(e){
            $(e.target).attr("checked","checked");
            $(".imageOptions").removeClass("mainProductImage");
            $.get(ctxPath+"/admin/setMainProductImageAjax?productId=${product.id}&imageName="+this.value, function(d){
                $(e.target).parent().addClass("mainProductImage");
            })
        });

        var $mpi = $(".mainProductImage");
        if($mpi.length == 0){
            $(".productImageRadio:first").click(); //if we dont have a main product image, select 1st
        } else {
            $mpi.find("input").attr("checked","checked"); //otherwise make sure its checked
        }
    })
    function deleteImage(fn, link){
        if(confirm("Are you sure you want to delete this image?")){
            var $li = $(link).parents("li");
            $li.remove();
            if($(link).parent().hasClass("mainProductImage")){ //we just removed the main product image,
                $(".productImageRadio:first").click(); //make the first image the main product image
            }
            $.get(ctxPath+"/admin/removeProductImageAjax?productId=${product.id}&imageName="+fn, function(d){
                $.jGrowl("Image Removed");
            })
        }
    }

</script>
</body>
</html>
