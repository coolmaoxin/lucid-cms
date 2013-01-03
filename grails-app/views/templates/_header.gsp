<meta http-equiv="content-type" content="text/html; charset=UTF-8">

<meta name="google-site-verification" content="${siteConfig.metaTags.googleApps}"/>
<meta name="description" content="${siteConfig.metaTags.description}"/>
<meta name="keywords" content="${siteConfig.metaTags.keywords}"/>
<uf:resources type="css"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'grails.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'fileuploader.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'css/common', file: 'jquery.fancybox-1.3.4.css')}"/>
<link rel="stylesheet" href="${resource(dir: 'js/jquery/galleria-theme', file: 'galleria.classic.css')}"/>

<g:if test="${siteConfig.headerFont}">
<link  href="http://fonts.googleapis.com/css?family=${siteConfig.headerFont.replaceAll(' ','+')}:regular" rel="stylesheet" type="text/css" >
<style>
.styledFont {
  font-family: '${siteConfig.headerFont}', serif;
  font-size: 36px;
  font-style: normal;
  font-weight: 400;
  text-shadow: 2px 2px 2px #aaa;
  text-decoration: none;
  text-transform: none;
  letter-spacing: 0em;
  word-spacing: 0em;
  line-height: 1.2;
}
h1 {
    font-family: '${siteConfig.headerFont}', serif;
    font-size: x-large;
}
</g:if>
</style>
%{--<link rel="shortcut icon" href="${resource(dir:'images',file:'icon.ico')}" type="image/x-icon" />--}%
<g:layoutHead/>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<g:javascript src="application.js"/>
<g:javascript src="jquery/jquery.min.js"/>
<g:javascript src="jquery/jquery-ui.custom.min.js"/>
<g:javascript src="jquery/jquery.maskedinput-1.2.2.min.js"/>
<g:javascript src="jquery/galleria.js"/>
<g:javascript src="jquery/jquery.gmap.js"/>
<g:javascript src="jquery/jquery.fancybox-1.3.4.pack.js"/>
<g:javascript src="jquery/jquery.jgrowl.js"/>
<g:javascript src="fileuploader.js"/>
<script src="http://cdn.jquerytools.org/1.2.5/form/jquery.tools.min.js"></script>
<g:javascript src="custom.js" />

<sec:ifAllGranted roles="ROLE_ADMIN" >
    <g:javascript src="custom-admin.js" />
</sec:ifAllGranted>

<g:javascript src="sites/${siteName}/custom.js"/>
<script>Galleria.loadTheme('${resource(dir:'js/jquery/galleria-theme',file:'galleria.classic.js')}');</script>

<sec:ifAllGranted roles="ROLE_ADMIN">
    <ckeditor:resources />
    <script type="text/javascript">
         CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;
    </script>
</sec:ifAllGranted>

<script type="text/javascript">
    var topTabName = "${breadCrumb[0].name}";
    var ctxPath = "${request.contextPath}";
    var loggedIn = false;
    <sec:ifLoggedIn>
    loggedIn = true;
    </sec:ifLoggedIn>
</script>
<link type="text/css" href="<g:resource dir='css/${siteName}' file='jquery-ui.custom.css'/>" rel="stylesheet"/>
<link type="text/css" href="<g:resource dir='css/${siteName}' file='custom.css'/>" rel="stylesheet"/>