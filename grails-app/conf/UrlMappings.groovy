import org.codehaus.groovy.grails.commons.ConfigurationHolder

class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"pages", action:"show")
        "/setup"(controller: 'admin', action: "status")
        //custom pages first:
        "/pages/search-listings"(controller:"searchListings")
        "/pages/contact"(controller:"pages", action:"contact")
        "/pages/login"(controller:"login", action:"auth")
        "/pages/admin"(controller:"admin", action:"admin")

        //user pages               :
		"/pages/$urlPath"(controller:"pages", action:"show")

        //ckeditor's own support for this wasnt working,
        "/userData/$filepath**" (controller: "openFileManagerConnector", action: "show")

        //todo move these to stealthispipe's mappings:
        "/pages/pipes-log"(controller:"stealThisPipe", action:"guestbookLog")
        "/pages/pipes-show"(controller:"stealThisPipe", action:"guestbookShow")

        "/productImage/$id/$filepath**" (controller: "product", action: "productImage")
        "/productImage/$id" (controller: "product", action: "getProductImagesAjax")
        "500"(view:'/error')
        
        if(ConfigurationHolder.config.siteName == "stealthispipe"){
            "/pages/pipes-log"(controller:"stealThisPipe", action:"guestbookLog")
            "/pages/pipes-show"(controller:"stealThisPipe", action:"guestbookShow")
        }


	}
}
