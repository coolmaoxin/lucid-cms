<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-gb" lang="en-gb" dir="ltr">
<head>

    <title><g:layoutTitle default="${title}"/></title>

    <g:render template="/templates/header"/>

</head>

<body>
<div class="body">

    <!-- header -->
    <div class="header-top">
    <sec:ifLoggedIn>
      Logged in as <b><sec:username/></b> <g:link controller="logout">Log Out</g:link>
    </sec:ifLoggedIn>
    </div>
    <div class="topNav">
        <ul class="topLinks">
              <g:each in="${topNav}" var="item">
                <g:if test="${item.active}">
                  <li class="<g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="active"/>">
                    <g:link action="show" controller="pages" params="[urlPath:item.urlPath]">${item.name}</g:link>
                  </li>
                </g:if>
              </g:each>
        </ul>
    </div>
    <div class="content">

            <span class="left-nav" id="left">
                %{--if the current page is a user html page, it may have a left nav (non user pages have custom left nav / we dont worry about it here)--}%

                <g:if test="${leaf.userHtml}">
                   <g:if test="${leftNav}">
                        <g:if test="${breadCrumb[0].navigationHeading}">
                            <h3><span>${breadCrumb[0].navigationHeading}</span></h3>
                        </g:if>
                        <ul>
                              <g:each var="item" in="${leftNav}">
                                  %{--so it has a left nav, show the items--}%
                                <li class="ui-corner-all <g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="active"/>">
                                  <g:link class="" action="show" controller="pages" params="[urlPath:item.urlPath]"><span>${item.name}</span></g:link>
                                </li>
                              </g:each>
                        </ul>
                    </g:if>
                </g:if>
                <g:if test="${!leaf.userHtml}">
                  <g:include controller="${leaf.urlPath.replaceAll(/-\w/,{it[1].toUpperCase()})}" action="leftNav"/>
                </g:if>
            </span>
            <span class="main" id="main">
                    <g:layoutBody />
                     <g:if test="${leaf.products.size() > 0}">
                          <g:render template="/templates/products"/>
                     </g:if>
                    <div class="clear"></div>
            </span>
        <div class="clear"></div>
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
<div id="footer">
</div>
<span id="copyright">&copy;2010 - 2011 ${grailsApplication.config.copyrightText} <g:link action="login" class="adminLink" controller="pages">&nbsp;&nbsp;<img style="position: absolute; top: -4px;" src="${resource(dir: 'images', file: 'lock.png')}"></img></g:link></span>
</div>
</body>
</html>