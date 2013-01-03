<fieldset>
    <div class="ctrlHolder">
        <label>Product Name</label>
        <input type="text" required="required" class="textInput" maxlength="255" value="${p.name}" name="name">
        <p class="formHint">Required.</p>
    </div>
    <div class="ctrlHolder">
        <label>Short Description</label>
        <input type="text" required="required" class="textInput" maxlength="255" value="${p.shortDesc}" name="shortDesc">
        <p class="formHint">Required.</p>
    </div>
    <div class="ctrlHolder">
        <label>Long Description</label>
        <ckeditor:editor id="editor" name="longDesc" width="53%" toolbar="Basic">${p.longDesc}</ckeditor:editor>
        <p class="formHint"></p>
    </div>
    <div class="ctrlHolder">
        <label>Price</label>
        <input type="text" required="required" class="textInput" maxlength="25" value="${p.price}" name="price">
        <p class="formHint">Required. Regular price of the product</p>
    </div>
    <div class="ctrlHolder">
        <label>Sale Price</label>
        <input type="text" class="textInput" maxlength="25" value="${p.salePrice}" name="salePrice">
        <p class="formHint">Optional. This can be added later.</p>
    </div>
    <div class="ctrlHolder productCat">
        <label>Product Will Appear Under</label>
        <g:select required="required" id="navigationId" name="navigationId" value="${p.navigationId}" from="${navs}" optionKey="id" optionValue="${{it.crumb + ' (has '+it.products.size()+' products)'}}" />
        <p class="formHint">A product must appear under a navigation item. </p>
    </div>
    <input type='hidden' name="productId" value="${p.id}"/>
</fieldset>