<!DOCTYPE html>

<html>
    <head>
      <title><g:layoutTitle default="${title}"/></title>
      <g:render template="/templates/header"/>
    </head>
    <body>

    <div class="pageBody">
      <sec:ifLoggedIn>
      <div class="ui-corner-bottom ui-widget-content userBar">Logged in as <sec:username/>
          <sec:ifAllGranted roles="ROLE_ADMIN" > - Admin </sec:ifAllGranted>|
          %{--<g:link controller="user" action="editProfile">Edit Profile</g:link> | --}%
          <g:link controller="logout">Log Out</g:link></div>
          
      </sec:ifLoggedIn>
      <div id="logoContent" class="header">
        <span class="header-logo">
            <g:userEditableSection name="Header">
              <img id="logo" src="${resource(dir:'images/baystate',file:'portrait.png')}">
            </g:userEditableSection>
        </span>
        <span class="header-contact">
              
               <g:userEditableSection name="Contact Info"/>
              <span id="remaxLogo" style="position:relative;float:right;opacity:0"><img src="${resource(dir:'images/baystate',file:'remax_logo.gif')}" alt="remax"/></span>
        </span>
      </div>
      <div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
        <ul id="tabContent" class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
          <g:each in="${topNav}" var="item">
              %{--loop over the items in the topNav and if its active, display it. if the current top tab is the item being looped over,--}%
              %{--display it differently--}%
            <g:if test="${item.active}">
              <li class="ui-state-default ui-corner-top <g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="ui-tabs-selected ui-state-active"/>">
                <g:link action="show" controller="pages" params="[urlPath:item.urlPath]">${item.name}</g:link>
              </li>
            </g:if>
          </g:each>
        </ul>
        <div id="mainContent" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
         <p>
          <div id="leftNav">
            %{--if the current page is a user html page, it may have a left nav (non user pages have custom left nav / we dont worry about it here)--}%
            <g:if test="${leaf.userHtml}">
              <g:if test="${leftNav}">
                <g:if test="${breadCrumb[0].navigationHeading}">
                    <p class="flag"><em>${breadCrumb[0].navigationHeading}</em></p>
                </g:if>
                <ul class="ui-helper-reset ui-helper-clearfix">
                  <g:each var="item" in="${leftNav}">
                      %{--so it has a left nav, show the items--}%
                    <li class="link ui-state-default ui-corner-right <g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="ui-corner-right ui-tabs-selected ui-state-active nolink"/>">
                      <g:link action="show" controller="pages" params="[urlPath:item.urlPath]">${item.name}</g:link>
                    </li>
                  </g:each>
                </ul>
              </g:if>

              %{--custom html pages also include the featured tour.. here its is --}%
              <g:if test="${featuredVisualTour}">
                <p class="flag"><em>Featured Visual Tour</em></p>
                <table class="featuredVisualTour"><tbody>
                <tr>
                  <td colspan="2">
                    <a href="javascript:viewVisualTour('${featuredVisualTour.tourId}')">
                      <img src="${featuredVisualTour.photoFullPath}"/>
                    </a></td>
                </tr>
                <tr>
                  <td>Price:</td><td>${featuredVisualTour.price}</td>
                </tr>
                <tr>
                  <td>Area:</td><td>${featuredVisualTour.sqFt}</td>
                </tr>
                <tr>
                  <td>Address:</td>
                  <td>${featuredVisualTour.street}</td>
                </tr>
                <tr>
                  <td></td>
                  <td>${featuredVisualTour.city}, ${featuredVisualTour.state}</td>
                </tr>
                <tr>
                  <td colspan="2"><a href="javascript:viewVisualTour('${featuredVisualTour.tourId}')">View Tour</a></td>
                </tr>
                </tbody></table>
              </g:if>
              <div style="margin-top:20px">
                  <g:userEditableSection name="Left Panel"/>
              </div>
            </g:if>
            <g:if test="${!leaf.userHtml}">
              <g:include controller="${leaf.urlPath.replaceAll(/-\w/,{it[1].toUpperCase()})}" action="leftNav"/>
            </g:if>
          </div>
          <div id="rightContent">
            <div id="rightInnerContent">
              <g:layoutBody />
            </div>
          </div>
         </p>
         <div style="clear:both"></div>
        </div>
        <div id="bottomContent"></div>
      </div>

      <div id="footerContent" class="ui-corner-top ui-widget-content">
        &copy;2010 - 2011 ${grailsApplication.config.copyrightText}
      </div>
    </div>

    <g:if test="${siteConfig.statCounterEnabled}">
        <!-- Start of StatCounter Code -->
        <script type="text/javascript">
        var sc_project=${siteConfig.statCounterProject}; 
        var sc_invisible=1;
        var sc_security="${siteConfig.statCounterSecurity}";
        </script>
        <script type="text/javascript"
        src="http://www.statcounter.com/counter/counter.js"></script>
        <noscript><div class="statcounter"><a title="tumblr visitor
        stats" href="http://statcounter.com/tumblr/"
        target="_blank"><img class="statcounter"
        src="http://c.statcounter.com/${siteConfig.statCounterProject}/0/${siteConfig.statCounterSecurity}/1/"
        alt="tumblr visitor stats"></a></div></noscript>
        <!-- End of StatCounter Code -->
    </g:if>


    </body>
</html>