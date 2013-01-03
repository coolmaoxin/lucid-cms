
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head><title>Application Info</title>
  <g:javascript src="jquery/jquery-1.4.4.js"/>
  </head>
  <body>
   <script type="text/javascript">
        var ctxPath = "${request.contextPath}";
   </script>

  ${grailsApplication.config.domainName}<br/>
  Now: ${new Date()}<br>
  %{--Application started: ${grailsApplication.config.info.appStartTime}<br/>--}%
  <%
//    Long ms = new Date().getTime() - grailsApplication.config.info.appStartTime.getTime();
//    Long x = ms / 1000
//    Long seconds = x % 60
//    x /= 60
//    Long minutes = x % 60
//    x /= 60
//    Long hours = x % 24
//    x /= 24
//    Long days = x
//    out.println("Uptime: "+days+" days "+hours+" hours "+minutes+" minutes "+seconds+" seconds<br><br/>")

    Runtime runtime = Runtime.getRuntime();
    out.println("Free mem: "+Math.ceil(runtime.freeMemory() / (1024*1024))+"MB<br/>")
    out.println("Total mem: "+Math.ceil(runtime.totalMemory() / (1024*1024))+"MB<br/>")
    out.println("Max mem: "+Math.ceil(runtime.maxMemory() / (1024*1024))+"MB<br/>")
  %>
  <br/>

  %{--Last VT Scrape: ${grailsApplication.config.info.lastVtScrape}<br/>--}%
  %{--VT Scrape Recrods: ${grailsApplication.config.info.vtScrapeRecords}<br/><br/>--}%
  %{--Last MLS Scrape: ${grailsApplication.config.info.lastMlsScrape}<br/>--}%
  %{--MLS Scrape Records: ${grailsApplication.config.info.MlsScrapeRecords}<br/>--}%
<hr/>
  <div class="homePagePanel">
                <div class="panelTop"></div>
                <div class="panelBody">
                    <h1>Application Status</h1>
                    <ul>
                        <li>App version: <g:meta name="app.version"></g:meta></li>
                        <li>Grails version: <g:meta name="app.grails.version"></g:meta></li>
                        <li>Groovy version: ${org.codehaus.groovy.runtime.InvokerHelper.getVersion()}</li>
                        <li>JVM version: ${System.getProperty('java.version')}</li>
                        <li>Controllers: ${grailsApplication.controllerClasses.size()}</li>
                        <li>Domains: ${grailsApplication.domainClasses.size()}</li>
                        <li>Services: ${grailsApplication.serviceClasses.size()}</li>
                        <li>Tag Libraries: ${grailsApplication.tagLibClasses.size()}</li>
                    </ul>
                    <h1>Installed Plugins</h1>
                    <ul>
                        <g:set var="pluginManager"
                               value="${applicationContext.getBean('pluginManager')}"></g:set>

                        <g:each var="plugin" in="${pluginManager.allPlugins}">
                            <li>${plugin.name} - ${plugin.version}</li>
                        </g:each>

                    </ul>
                </div>
                <div class="panelBtm"></div>
            </div>
  <hr/>
    <g:if test="${! haveAdmin}">
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${siteComponentInstance}">
            <div class="errors">
                <g:renderErrors bean="${siteComponentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${siteComponentInstance?.id}" />
                <g:hiddenField name="version" value="${siteComponentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="visualTours"><g:message code="siteComponent.visualTours.label" default="Visual Tours" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'visualTours', 'errors')}">
                                    <g:checkBox name="visualTours" value="${siteComponentInstance?.visualTours}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mls"><g:message code="siteComponent.mls.label" default="Mls" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'mls', 'errors')}">
                                    <g:checkBox name="mls" value="${siteComponentInstance?.mls}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="products"><g:message code="siteComponent.products.label" default="Products" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'products', 'errors')}">
                                    <g:checkBox name="products" value="${siteComponentInstance?.products}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contact"><g:message code="siteComponent.contact.label" default="Contact" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'contact', 'errors')}">
                                    <g:checkBox name="contact" value="${siteComponentInstance?.contact}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="login"><g:message code="siteComponent.login.label" default="Login" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'login', 'errors')}">
                                    <g:checkBox name="login" value="${siteComponentInstance?.login}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="guestbook"><g:message code="siteComponent.guestbook.label" default="Guestbook" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: siteComponentInstance, field: 'guestbook', 'errors')}">
                                    <g:checkBox name="guestbook" value="${siteComponentInstance?.guestbook}" />
                                </td>
                            </tr>

                        </tbody>
                    </table>
                    <div class="ctrlHolder">
                    <label>Username</label>
                    <input type="text" class="textInput" size="35" value="" name="username">
                </div>
                <div class="ctrlHolder">
                    <label>Password</label>
                    <input type="text" class="textInput" size="35" value="" name="password">
                </div>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="firstTimeSetup" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                </div>
            </g:form>
        </div>
        There is no admin user on the site. Create one now.

    </g:if>
  </body>
</html>