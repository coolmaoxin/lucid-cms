
<%@ page import="com.dogself.realestate.MlsListing" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="${siteName}" />
        <g:set var="entityName" value="${message(code: 'mlsListing.label', default: 'MlsListing')}" />
        
    </head>
    <body>
        <div class="nav">

        </div>
        <sec:ifNotLoggedIn>
          <div class="message" id="searchListingsMessages">Registration is required to view detailed listings. We ask only for a valid email in order to <a href="#" class="link" id="registerLink">Register</a>.</div>
          <div class="body" id="ajaxContent">
            <br/><br/>
            <g:render template="/templates/login"/>
          </div>
        </sec:ifNotLoggedIn>
        <sec:ifLoggedIn>
          <div class="message" id="searchListingsMessages">Thank you for logging in, you can now view detailed listings.<br/>
          <input type="button" value="Search Listings" onclick="$('#mlsForm').submit()"/>
          </div>
          <div class="body" id="ajaxContent"></div>
        </sec:ifLoggedIn>
        <div style="clear:both"></div>
    </body>
</html>
