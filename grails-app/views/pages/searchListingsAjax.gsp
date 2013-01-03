<%@ page contentType="text/html;charset=UTF-8" %>
<h1>
       <span>
       <g:if test="${mlsListingInstanceTotal > 0}">${mlsListingInstanceTotal} listings found</g:if>
       <g:if test="${mlsListingInstanceTotal == 0}">No listings found, broaden your search criteria</g:if>

       <input style="margin-left:50px" type="button" value="Search" onclick="$('#mlsForm').submit()"/>
     </span>


</h1>
  <div class="paginateButtons">
                <g:paginate total="${mlsListingInstanceTotal}"   />
            </div>

            <div id="mlsListings" class="list">
<table>
    <thead>
        <tr>

            <td>Photo</td>
            <g:sortableColumn action="search" property="price" title="Price"  />

            <g:sortableColumn action="search" property="acres" title="${message(code: 'mlsListing.acres.label', default: 'Acres')}" />

            <g:sortableColumn action="search" property="garageSpaces" title="Garage Spaces" />

            <g:sortableColumn action="search" property="livingLevels" title="Living Levels" />

            <g:sortableColumn action="search" property="numberRooms" title="Rooms" />
            <g:sortableColumn action="search" property="squareFeet" title="Square Feet" />
            <th>Town</th>
            <th>State</th>

        </tr>
    </thead>
    <tbody>
<g:each in="${mlsListingInstanceList}" status="i" var="mlsListingInstance">
    <tr listing="${mlsListingInstance.listingId}" class="${(i % 2) == 0 ? 'odd' : 'even'} listingPopup">

        <td><img src="http://idx.mlspin.com/photo/photo.aspx?mls=${mlsListingInstance.listingId}&n=0&w=64&h=64"></td>
        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "price")}</td>

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "acres")}</td>

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "area")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "basement")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "garageParking")}</td>--}%

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "garageSpaces")}</td>

        %{--<td valign="top" class="value"><g:formatBoolean boolean="${mlsListingInstance?.hasMasterBath}" /></td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "listingId")}</td>--}%

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "livingLevels")}</td>

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "lotSize")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "numberBedrooms")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "numberFullBaths")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "numberHalfBaths")}</td>--}%

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "numberRooms")}</td>

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "photoCount")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "photoDate")}</td>--}%

        %{--<td valign="top" class="name"><g:message code="mlsListing.photoMask.label" default="Photo Mask" /></td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "photoMask")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "propType")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "sfType")}</td>--}%

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "squareFeet")}</td>

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "status")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "streetName")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "streetNumber")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "style")}</td>--}%

        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "town.name")}</td>
        <td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "town.state")}</td>

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "unitNumber")}</td>--}%

        %{--<td valign="top" class="value">${fieldValue(bean: mlsListingInstance, field: "zipCode")}</td>--}%

    </tr>


</g:each>
<tr class="hidden hiddenRow">
  <td>
    <span id="searchListingPaginationAjax">

    </span>
  </td>
</tr>
</tbody></table>

</div>
            <div class="paginateButtons" id="searchListingPagination">
                <g:paginate total="${mlsListingInstanceTotal}"   />
            </div>