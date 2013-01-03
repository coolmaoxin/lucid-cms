<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
  <meta name="layout" content="${siteName}" />
  </head>
  <body>
  <h1>Site Administration</h1>

  <div>I would like to...</div><br/>

  <ul>
      <li><g:link controller="admin" action="editUserHtml">Edit the contents of a page</g:link></li>
      <li><g:link controller="admin" action="createNavigation">Create a new page</g:link></li>
      <li><g:link controller="admin" action="renameNavigation">Rename a page</g:link></li>
      <li><g:link controller="admin" action="deleteNavigation">Delete a page</g:link></li>
      <g:if test="${hasSections}">%{-- sections will only exist if the userEditableSection tag is used somewhere in template--}%
        <li><g:link controller="admin" action="editSection">Edit a section</g:link></li>
      </g:if>
      %{--<li><g:link controller="admin" action="siteUsers">View users that have registered.</g:link></li>--}%
  </ul>
  <br/>
  Edit general site settings:<br/><br/>
  <ul>
      <li><g:link controller="admin" action="editMetaData">Edit site meta-data</g:link></li>
      <li><g:link controller="admin" action="editSiteConfig">Edit site configuration</g:link></li>
  </ul>
  <g:if test="${siteComponents.mls || siteComponents.visualTours}">
      <br/>
      Edit real estate related settings:<br/><br/>
      <ul>
          <g:if test="${siteComponents.mls}">
            <li><g:link controller="admin" action="editMlsConfig">Update MLS username and password</g:link></li>
            <li><a href="#" id="forceScrapeMls">Force MLS Listings update now</a></li>
          </g:if>
          <g:if test="${siteComponents.visualTours}">
            <li><a href="#" id="forceScrapeVt">Force Visual Tour update now</a></li>
          </g:if>
      </ul>
  </g:if>
  <br/>
  <g:if test="${siteComponents.products}">
      <br/>
      Manage Products:<br/><br/>
      <ul>
         <li><g:link controller="admin" action="createProduct">Create a new product</g:link></li>
         <li><g:link controller="admin" action="editProduct">Edit an existing product</g:link></li>
         <li><g:link controller="admin" action="deleteProduct">Delete a product</g:link></li>
         <li><g:link controller="admin" action="moveProducts">Move products from one page to another</g:link></li>
      </ul>
  </g:if>
  <br/>
  <br/>
  <br/>
  <g:link controller="admin" action="status">Server Status</g:link>

  <script type="text/javascript">
      $("#forceScrapeMls").click(function(){
          if (window.confirm("This process runs daily - running it now will use a lot of server resouces. Are you sure?")){
              $.get(ctxPath+"/searchListings/forceScrapeMls");
              $.jGrowl("Running...");
          }
      })
      $("#forceScrapeVt").click(function(){
          if (window.confirm("This process runs daily - running it now will use a lot of server resouces. Are you sure?")){
              $.get(ctxPath+"/searchListings/forceScrapeVt");
              $.jGrowl("Running...");
          }
      })
  </script>

  </body>
</html>