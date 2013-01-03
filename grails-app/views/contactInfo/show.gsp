
<%@ page import="com.dogself.core.ContactInfo" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="baystate" />
        <g:set var="entityName" value="${message(code: 'contactInfo.label', default: 'ContactInfo')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">

        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="scaffold">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "id")}</td>
                            
                        </tr>
                    

                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.mobilePhone.label" default="Mobile Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "mobilePhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.workPhone.label" default="Work Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "workPhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.adminUsername.label" default="Admin Username" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "adminUsername")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="contactInfo.adminPassword.label" default="Admin Password" /></td>

                            <td valign="top" class="value">${fieldValue(bean: contactInfoInstance, field: "adminPassword")}</td>

                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${contactInfoInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
