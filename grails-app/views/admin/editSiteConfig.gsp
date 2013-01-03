<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Edit Site Config</h1>
Edit various things...
<br/><br/>
${flash.message}<br/><br/>


<div>
    <g:form action="editSiteConfigSubmit" controller="admin" class="uniForm ui-corner-all">
        <fieldset>
            <div class="ctrlHolder">
                <label>Google Font Name</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.headerFont}" name="headerFont">
                <p class="formHint">Spice up your site by <a href="http://www.google.com/webfonts/preview" target="_blank">picking a google font</a>.<br/>Example font name: <b>Permanent Marker</b></p>
            </div>
        </fieldset>
        <g:submitButton name="sub" value="Save"/>
        <input type="button" value="Back to admin" id="exitNoSave"/>
    </g:form>

</div>
</body>
</html>