
def site = "hunters"

switch(site){
    case "suigeneris":
        siteName="suigeneris"//used in templates
        siteTitle="Sui Generis Desserts" //used in title and emails
        domainName = "suigenerisdesserts.com" //do not include http://
        contactEmail = "fbenjamin@gmail.com"
        copyrightText = "Lucid Web Code <sub>(r83)</sub>"

        break
    case "baystate":
        siteName="baystate"
        siteTitle="Baystate Homes For Sale"
        domainName = "baystatehomesforsale.com" //do not include http://
        contactEmail = "natashacarter@gmail.com"
        zillowApiKey = "X1-ZWz1d3fn0n4qa3_4dboj"
        defaultUserZip = "01460"
        copyrightText = "Lucid Web Code <sub>(r82)</sub> | Remax Landmark"
        break
    case "dogself":
        siteName="dogself"
        siteTitle="Dogself Demo"
        domainName = "dogself.com" //do not include http://
        contactEmail = "koryak+dogself@gmail.com"
        copyrightText = "Lucid Web Code"
        break
    case "stealthispipe":
        siteName="stealthispipe"
        siteTitle="Steal This Pipe"
        domainName = "stealthispipe.com" //do not include http://
        contactEmail = "sandandfire@gmail.com"
        copyrightText = "Lucid Web Code <sub>(r83)</sub>"
        break
    case "hunters":
        siteName="hunters"
        siteTitle="Hunters Rendezvous"
        domainName = "huntersrendezvous.com" //do not include http://
        contactEmail = "koryak@gmail.com"
        copyrightText = "Lucid Web Code <sub>(r83)</sub>"
        break
}



maxNavigationLevels = 2; //top nav and left nav

info {
    appStartTime: ""
}


grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
grails.json.legacy.builder=false
grails.views.javascript.library="jquery"

//grails.mail.host = 'smtp.gmail.com'

jquery {
    sources = 'jquery' // Holds the value where to store jQuery-js files /web-app/js/
    version = '1.4.4' // The jQuery version in use
}
grails {
  mail {
  host = "localhost"
  }
}

emailConfirmation.from="no-reply@${domainName}"
grails.mail.default.from="no-reply@${domainName}"

// set per-environment serverURL stem for creating absolute links
environments {
    production {
      grails.serverURL = "http://${domainName}"
    }
    development {
      grails.serverURL = "http://localhost:8080/${appName}"
    }
    test {
      grails.serverURL = "http://localhost:6060/${appName}"
    }

}

// log4j configuration
log4j = {
      appenders {
        rollingFile name: 'applog', file: "${System.properties.getProperty('catalina.base') ?:'logs'}${File.separator}logs${File.separator}${site}.log".toString(), layout: pattern(conversionPattern: '%d{dd-MM-yyyy HH:mm:ss,SSS} %5p %c{1} - %m%n'), maxFileSize: '1MB'
        file name: 'stacktrace', file: "${System.properties.getProperty('catalina.base')?:'logs'}${File.separator}logs${File.separator}${site}-stacktrace.out".toString(), layout: pattern(conversionPattern: '%d{dd-MM-yyyy HH:mm:ss,SSS} %5p %c{1} - %m%n')
        console name:'stdout', layout:pattern(conversionPattern: '%d{dd-MM-yyyy HH:mm:ss} %5p %c{1} - %m%n')
      }

      error stacktrace: "StackTrace"

      error 'org.codehaus.groovy.grails.web.servlet',  //  controllers
              'org.codehaus.groovy.grails.web.pages', //  GSP
              'org.codehaus.groovy.grails.web.sitemesh', //  layouts
              'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
              'org.codehaus.groovy.grails.web.mapping', // URL mapping
              'org.codehaus.groovy.grails.commons', // core / classloading
              'org.codehaus.groovy.grails.plugins', // plugins
              'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
              'org.springframework',
              'org.hibernate',
              'net.sf.ehcache.hibernate'

      warn 'org.mortbay.log'

      info applog: 'grails.app'
}

// Added by the Spring Security Core plugin:
grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.dogself.core.User'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.dogself.core.UserRole'
grails.plugins.springsecurity.authority.className = 'com.dogself.core.Role'
//grails.plugins.springsecurity.failureHandler.defaultFailureUrl = '/'
grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/pages/admin'


grails.plugins.springsecurity.controllerAnnotations.staticRules = [
   '/openFileManagerConnector/show': ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/standardFileManagerConnector/show': ['IS_AUTHENTICATED_ANONYMOUSLY'],
   '/openFileManagerConnector/**': ['ROLE_ADMIN'],
   '/standardFileManagerConnector/**': ['ROLE_ADMIN'],
]

ckeditor {
	config = "/js/ckEditorConfig.js"
    skipAllowedItemsCheck = false
	defaultFileBrowser = "ofm"
	upload {
		basedir = "/uploads/${site}/"
        baseurl = "/grails/userData/"//ckeditor doesnt give a crap about context paths
        overwrite = false
        enableContentController = true
        link {
            browser = true
            upload = false
            allowed = []
            denied = ['html', 'htm', 'php', 'php2', 'php3', 'php4', 'php5',
                      'phtml', 'pwml', 'inc', 'asp', 'aspx', 'ascx', 'jsp',
                      'cfm', 'cfc', 'pl', 'bat', 'exe', 'com', 'dll', 'vbs', 'js', 'reg',
                      'cgi', 'htaccess', 'asis', 'sh', 'shtml', 'shtm', 'phtm']
        }
        image {
            browser = true
            upload = true
            allowed = ['jpg', 'gif', 'jpeg', 'png']
            denied = []
        }
        flash {
            browser = false
            upload = false
            allowed = ['swf']
            denied = []
        }
	}
}

/////////////////////////////////datasource
dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = ""
    dialect = "org.hibernate.dialect.MySQL5InnoDBDialect"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost/${site}?autoreconnect=true"
 //         loggingSql = true
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:mysql://localhost/${site}?autoreconnect=true"
            password = "car12a"

        }
        ckeditor.upload.basedir = "/srv/grailsUpload/${site}/"
        ckeditor.upload.baseurl = "/userData/" //ckeditor doesnt give a crap about context paths
    }
}

