
<%@ page import="com.dogself.realestate.MlsListing" %>

<div class="nav">
    %{--<span class="menuButton"><a class="list" href="javascript:history.back()">Back to search</a></span>--}%
</div>
<div class="body">

  <div class="detailedListing">
    <div class="details">
      <div class="address">
        <h1><b>${listing.streetNumber} ${listing.streetName}</b></h1>
        <h1><b>${listing.town.name}, ${listing.town.state}</b></h1>
        <h2>Price: <b>$${listing.price}</b></h2>
        <br/>
      </div>
      <table>
        <tbody>
        <tr>
          <td>Bedrooms:</td>
          <td>${listing.numberBedrooms}</td>
        </tr>
        <tr>
          <td>Bathrooms:</td>
          <td>${listing.numberFullBaths}</td>
        </tr>
        <tr>
          <td>Lot Size:</td>
          <td>${listing.squareFeet} sq ft / ${listing.acres} acres</td>
        </tr>
        <tr>
          <td>Living Levels:</td>
          <td>${listing.livingLevels}</td>
        </tr>
        <tr>
          <td>Garage Spaces:</td>
          <td>${listing.garageSpaces}</td>
        </tr>
        </tbody>
      </table>
    </div>
    <div class="picture">
      <div id="slideshowImages">
      <g:each in="${0..listing.photoCount-1}" var="count">
        <a onclick="return false;" href="http://idx.mlspin.com/photo/photo.aspx?mls=${listing.listingId}&n=${count}&w=64&h=64"><img src="http://idx.mlspin.com/photo/photo.aspx?mls=${listing.listingId}&n=${count}"></a>
      </g:each>
      </div>
    </div>
  </div>
  %{--<img class="zillowBranding" src="http://www.zillow.com/widgets/GetVersionedResource.htm?path=/static/logos/Zillowlogo_150x40.gif" width="150" height="40" alt="Zillow Real Estate Search" />--}%
</div>
