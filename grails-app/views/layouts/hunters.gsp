<!DOCTYPE html>

<html>
<head>
    <title><g:layoutTitle default="${title}"/></title>

    <g:render template="/templates/header"/>

</head>
<body>

<div class="pageBody ui-helper-clearfix">
    <sec:ifLoggedIn>
        <div class="ui-corner-bottom ui-widget-content userBar">Logged in as <sec:username/>
            <sec:ifAllGranted roles="ROLE_ADMIN" > - Admin </sec:ifAllGranted>|
        %{--<g:link controller="user" action="editProfile">Edit Profile</g:link> | --}%
            <g:link controller="logout">Log Out</g:link></div>

    </sec:ifLoggedIn>
    <div class="leftContent">
        <div class="logoHolder">
            <img id="logo" src="${resource(dir:'images/hunters',file:'logo.png')}">
        </div>
        <div class="tabs">
            <ul id="tabContent">
                <g:each in="${topNav}" var="item">
                %{--loop over the items in the topNav and if its active, display it. if the current top tab is the item being looped over,--}%
                %{--display it differently--}%
                    <g:if test="${item.active}">
                        <li class="<g:setClassWhenNavigationInCrumb breadCrumb="${breadCrumb}" nav="${item}" clazz="active"/>">
                            <g:link action="show" controller="pages" params="[urlPath:item.urlPath]">${item.name}</g:link>
                        </li>
                    </g:if>
                </g:each>
            </ul>
        </div>
    </div>
        <div class="mainContent ui-corner-bottom">
            <div class="mast" id="logoContent" >
                <img src="${resource(dir:'images/hunters',file:'mast.jpg')}">
                <div class="mastRight">
                    <a style="color:#ffffff; text-decoration:none;" href="http://www.buckskingallery.com/">Click Here
                    to go to the <b><span style="color:#FCFF0A;">Buckskin Gallery</span></b></a>
                </div>
                <ul>
                    <li>
                        <g:link action="show" controller="pages" params="[urlPath:'']">Home</g:link>
                    </li>
                    <li>
                        <g:link action="show" controller="pages" params="[urlPath:'about-us']">About Us</g:link>
                    </li>
                    <li>
                        <g:link action="show" controller="pages" params="[urlPath:'contact']">Contact Us</g:link>
                    </li>
                    <li>
                        <g:link action="show" controller="pages" params="[urlPath:'directions']">Directions</g:link>
                    </li>

                </ul>
            </div>

            <div class="innerContent">
                <g:layoutBody />
                <g:if test="${leaf.products.size() > 0}">
                    <g:render template="/templates/products"/>
                </g:if>
                <div id="footerContent">
                    <span><g:userEditableSection name="Footer"/></span>
                    <span>&copy;2010 - 2012 ${grailsApplication.config.copyrightText}</span>
                </div>
            </div>
        </p>
            <div style="clear:both"></div>

        </div>
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