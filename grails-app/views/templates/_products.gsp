
<div class="products ui-corner-all">
    <g:each in="${leaf.products}">
        <div class="row">
            <div class="bottom_separator">
                <div class="ui-helper-clearfix productBlock">
                    <div class="imageRight">
                        <g:if test="${it.mainProductImageName}">
                            <a class="slideshow" href="${it.id}" rel="${it.mainProductImageName}"><img class="productImage" src="${request.contextPath}/productImage/${it.id}/thumb/${it.mainProductImageName}"></a>
                        </g:if>
                    </div>
                    <div class="detailLeft">
                        <h2 class="title">
                            ${it.name}
                        </h2>
                        <div class="shortDesc">
                            ${it.shortDesc}
                        </div>
                        <div class="browsePriceContainer">
                            <g:if test="${it.salePrice}">
                                <span class="oldPrice">$<g:formatNumber number="${it.price}" format="###,###.00"/></span>
                                <span class="price">$<g:formatNumber number="${it.salePrice}" format="###,###.00"/></span>
                            </g:if>
                            <g:else>
                                <span class="price">$<g:formatNumber number="${it.price}" format="###,###.00"/></span>
                            </g:else>
                        </div>
                        <g:if test="${it.longDesc}">
                            <div class="productDetailsContainer">
                                <a title="Product Details" class="productDetailsLink" href="#">Product Details &raquo;</a>
                                <div class="productDetails hidden">
                                    ${it.longDesc}
                                </div>
                            </div>
                        </g:if>
                    </div>
                </div>
            </div>
        </div>
    </g:each>
</div>
<script type="text/javascript">
    $(function(){
        $(".productDetailsLink").click(function(){
            $(this).next(".productDetails").slideToggle("fast");
            return false;
        });
        $(".slideshow").click(function() {
            var id = $(this).attr("href");
            var mainImageName = $(this).attr("rel");
            $.get("${request.contextPath}/productImage/"+id, function(d){
                var urls = ["${request.contextPath}/productImage/"+id+"/"+mainImageName]; //make the main image show up first
                for(var i = 0; i < d.length; i++){
                    if(d[i] != mainImageName){
                        urls.push("${request.contextPath}/productImage/"+id+"/"+d[i]);
                    }
                }
                $.fancybox(urls, {
                    'padding' : 0,
                    'transitionIn' : 'none',
                    'transitionOut' : 'none',
                    'type' : 'image',
                    'changeFade' : 0,
                    'overlayShow': true,
                    'titlePosition' : 'over', 
                    'titleFormat' : function(title, currentArray, currentIndex, currentOpts) {
                        return '<span id="fancybox-title-over">Image ' + (currentIndex + 1) + ' / ' + currentArray.length + ' ' + title + '</span>';
                     }
                });
            });
            return false;
        });

    })
</script>