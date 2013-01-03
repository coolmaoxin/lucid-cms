<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="${siteName}" />
  </head>
  <body>
    We are sorry, but your verification code is <b>not valid</b>, this might happen for the following reasons:<br/>
    <ul>
      <li>Your confirmation is over 30 days old.</li>
      <li>You have already confirmed this email address.</li>
    </ul>
    <br/>
    If you cannot remember your password, or you want to re-register with your current email to obtain a new password,
    please <g:link controller="user" action="reregister">click here</g:link>.
  </body>
</html>