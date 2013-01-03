package com.dogself

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class LogoutController {

    def navigationService

    def afterInterceptor = [action:this.&injectModel]

    private Map injectModel(Map model){
      navigationService.setupModelForPage("home", model)
    }
	/**
	 * Index action. Redirects to the Spring security logout uri.
	 */
	def index = {
		// TODO  put any pre-logout code here
		redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
	}
}
