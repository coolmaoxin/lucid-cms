

<%@ page import="com.dogself.core.ContactInfo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="${siteName}" />
        <g:set var="entityName" value="${message(code: 'contactInfo.label', default: 'ContactInfo')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">

        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${contactInfoInstance}">
            <div class="errors">
                <g:renderErrors bean="${contactInfoInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${contactInfoInstance?.id}" />
                <g:hiddenField name="version" value="${contactInfoInstance?.version}" />
                <div class="scaffold">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="contactInfo.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${contactInfoInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mobilePhone"><g:message code="contactInfo.mobilePhone.label" default="Mobile Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'mobilePhone', 'errors')}">
                                    <g:textField name="mobilePhone" value="${contactInfoInstance?.mobilePhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="workPhone"><g:message code="contactInfo.workPhone.label" default="Work Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'workPhone', 'errors')}">
                                    <g:textField name="workPhone" value="${contactInfoInstance?.workPhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="contactInfo.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${contactInfoInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="adminUsername"><g:message code="contactInfo.adminUsername.label" default="Admin Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'adminUsername', 'errors')}">
                                    <g:textField name="adminUsername" value="${contactInfoInstance?.adminUsername}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="adminPassword"><g:message code="contactInfo.adminPassword.label" default="Admin Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contactInfoInstance, field: 'adminPassword', 'errors')}">
                                    <g:passwordField name="adminPassword" value="${contactInfoInstance?.adminPassword}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    
                </div>
            </g:form>
        </div>
    </body>
</html>
