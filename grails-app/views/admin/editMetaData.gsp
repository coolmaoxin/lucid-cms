<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${siteName}"/>
</head>
<body>
<h1>Edit site meta-data</h1>
Meta data helps search engines to rank your site higher. It is a good idea to set up at least 5 keywords.
<br/><br/>
${flash.message}<br/><br/>


<div>
    <g:form action="editMetaDataSubmit" controller="admin" class="uniForm ui-corner-all">
        <fieldset>
            <div class="ctrlHolder">
                <label>Site Description</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.metaTags.description}" name="description">
                <p class="formHint">A brief description of the site or a tagline</p>
            </div>
            <div class="ctrlHolder">
                <label>Site keywords</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.metaTags.keywords}" name="keywords">
                <p class="formHint">Comma seperated list of keywords</p>
            </div>
            <div class="ctrlHolder">
                <label>Google apps activation meta-data</label>
                <input type="text" class="textInput" maxlength="255" value="${siteConfig.metaTags.googleApps}" name="googleApps">
                <p class="formHint">Used when registering for google apps</p>
            </div>
        </fieldset>
        <g:submitButton name="sub" value="Save"/>
        <input type="button" value="Back to admin" id="exitNoSave"/>
    </g:form>

</div>
</body>
</html>