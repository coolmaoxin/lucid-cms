<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Edit MLS Username and Password</h1>
This website requires your MLS username and password in order to maintain its searchable mls database. If you change your MLS
password, you will also need to update it here.
<br/><br/>
${flash.message}<br/><br/>


<div>
    <g:form action="editMlsConfigSubmit" controller="admin" class="uniForm ui-corner-all">
        <fieldset>
            <div class="ctrlHolder">
                <label>MLS Username</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.mlsUsername}" name="mlsUsername">
                <p class="formHint"></p>
            </div>
            <div class="ctrlHolder">
                <label>MLS Password</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.mlsPassword}" name="mlsPassword">
                <p class="formHint"></p>
            </div>
        </fieldset>
        <g:submitButton name="sub" value="Save"/>
        <input type="button" value="Back to admin" id="exitNoSave"/>
    </g:form>

</div>
</body>
</html>