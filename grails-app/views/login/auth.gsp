<head>
<meta name='layout' content='${siteName}' />
<title>Login</title>

</head>

<body>
<g:if test="${flash.message}">
  <div class="message">${flash.message}</div>
</g:if>
<g:render template="/templates/login"/>
Want to <a href="#" class="link" id="registerLink">Register</a>?
<script type='text/javascript'>
<!--
(function(){
	document.forms['loginForm'].elements['j_username'].focus();
})();
// -->
</script>
</body>
