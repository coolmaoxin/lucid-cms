<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-gb" lang="en-gb" dir="ltr">
<head>

    <title><g:layoutTitle default="${title}"/></title>

    <g:render template="/templates/header"/>

</head>

<body id="body">
<div class="extra">

    <!-- header -->
    <div id="header">
        <div class="menu-bg">
            <div class="main">
                <div id="topmenu">
                    <ul class="menu-nav">
                      <g:each in="${topNav}" var="item">
                          %{--loop over the items in the topNav and if its active, display it. if the current top tab is the item being looped over,--}%
                          %{--display it differently--}%
                        <g:if test="${item.active}">
                          <li class="<g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="active"/>">
                            <g:link action="show" controller="pages" params="[urlPath:item.urlPath]">${item.name}</g:link>
                          </li>
                        </g:if>
                      </g:each>
                        
                        
                </div>
            </div>
        </div>
        <div class="main">
            <div class="clear">
                <div class="float-right">

                </div>
                <div class="logo-bg">
                    <div id="logo">
                        <g:userEditableSection name="Logo">
                        <a href="${request.contextPath}/">[logo here]</a>
                        </g:userEditableSection>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <!-- END header -->
    <div class="main">
        <div id="wrapper">
            <div class="clear">
                %{--if the current page is a user html page, it may have a left nav (non user pages have custom left nav / we dont worry about it here)--}%
              <div id="left">
               <g:if test="${leaf.userHtml}">
               <g:if test="${leftNav}">
                    <div class="clear">
                        <div class="module-categories">
                            <g:if test="${breadCrumb[0].navigationHeading}">
                                <h3><span>${breadCrumb[0].navigationHeading}</span></h3>
                            </g:if>
                            <div class="boxIndent">
                                <div id="relative_div" style="position:relative;z-index:0"></div>
                                <ul class="level1">
                                      <g:each var="item" in="${leftNav}">
                                          %{--so it has a left nav, show the items--}%
                                        <li class="level1 item1 <g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="active"/>">
                                          <g:link class="level1 item1" action="show" controller="pages" params="[urlPath:item.urlPath]"><span>${item.name}</span></g:link>
                                        </li>
                                      </g:each>
                                </ul></div>
                        </div>
%{--
                        <div class="module-login">

                            <h3><span>Login Form</span></h3>
                            <div class="boxIndent">
                                    <div class="part1">
                                        <div class="clear">
                                            <div class="username">
                                                <input name="username" id="mod_login_username" type="text" class="inputbox" value="Username" onblur="if (this.value == '') this.value = 'Username'" onfocus="if (this.value == 'Username') this.value = ''" alt="Username"/>
                                            </div>

                                            <div class="password">
                                                <input type="password" id="mod_login_password" name="passwd" class="inputbox" value="password" alt="Password" onfocus="this.value = null"/>
                                            </div>
                                        </div>
                                        <div id="inputs">
                                            <div class="rememberCheck">
                                                <input type="checkbox" name="remember" id="mod_login_remember" class="checkbox" value="yes" alt="Remember Me"/>
                                                <label for="mod_login_remember" class="remember">
                                                    Remember Me</label>

                                            </div>
                                            <input type="submit" name="Submit" class="button" value="Log in"/>
                                        </div>
                                    </div>
                                    <div id="form-login-remember">
                                        No Account Yet?<br/>
                                        <a class="reg" href="/virtuemart_32405/index.php?option=com_user&amp;task=register#content">
                                            Create an account</a>
                                    </div>

                            </div>
                        </div>
--}%
                    </div>
                </g:if>
                </g:if>
                <g:if test="${!leaf.userHtml}">
                  <g:include controller="${leaf.urlPath.replaceAll(/-\w/,{it[1].toUpperCase()})}" action="leftNav"/>
                </g:if>
                </div>
                <div class="container">

                    <g:layoutBody />
                      <g:if test="${leaf.products.size() > 0}">
                          <g:render template="/templates/products"/>
                      </g:if>
                </div>
            </div>
        </div>
        <div class="block"/></div>
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
 <span><g:userEditableSection name="Footer"/></span>
 <span>&copy;2010 - 2011 ${grailsApplication.config.copyrightText}</span>
</div>
</body>
</html>