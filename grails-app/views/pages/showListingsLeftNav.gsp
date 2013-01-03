<%@ page contentType="text/html;charset=UTF-8" %>


<g:formRemote id="mlsForm" name="searchListings" url="[ controller: 'searchListings', action: 'search']" onSuccess="updateTable(data)" onFailure="updateTable()" onLoading="loading()" onLoaded="loaded()"
>
  <g:searchSliderRange beforeInput="\$" afterInput=",000" name="price" text="Price" min="${ranges.priceMin}" max="${ranges.priceMax > 1000 ? 1000 : ranges.priceMax}"/>
  <g:searchSliderRange beforeInput="" afterInput=" sq. ft." name="area" text="Area" min="${ranges.areaMin}" max="${ranges.areaMax > 5000 ? 5000 : ranges.areaMax}"/>
  <g:searchSliderRange beforeInput="" afterInput="" name="rooms" text="Rooms" min="${ranges.roomsMin}" max="${ranges.roomsMax}"/>
  <g:searchSlider name="bedrooms" text="Minimum Bedrooms" min="0" max="${ranges.bedroomsMin}"/>
  <g:searchSlider name="fullbath" text="Minimum Full Baths" min="0" max="${ranges.fullbathMin}"/>
  <g:searchSlider name="halfbath" text="Minimum Half Baths" min="0" max="${ranges.halfbathMin}"/>
  <g:searchSlider name="garages" text="Minimum Garage Spaces" min="0" max="${ranges.garagesMin}"/>
  <g:hiddenField id="offset" name="offset" value="${params.offset}"/>
  <g:hiddenField name="max" value="${params.max}"/>

  <div class="towns ui-corner-all">
    Search towns:
    <div style="padding-left:7px">
    <input type="text" value="10" maxlength="2" id="distance"> miles from <input type="text" maxlength="5" value="${zipcode ?: grailsApplication.config.defaultUserZip}" id="location"> zip code.
    </div>
    <ul style="margin-bottom:0px;top:0px">
      <li><input class='townCheckbox' type='checkbox' id='toggleSelected' checked='checked'/></li>
    </ul>
    <div id="towns">

    </div>
  </div>

  <g:hiddenField name="sort" id="sort" value="price"/>
  <g:hiddenField name="order" id="order" value="asc"/>
  <br/>
  <g:submitButton  name="submit" value="Search"/>

</g:formRemote>
<g:javascript src="mlsSearch.js" />

<script type='text/javascript'>

  $(function(){
      fetchTowns(function(){
          $("#mlsForm").submit();
      });
  });


 



</script>


