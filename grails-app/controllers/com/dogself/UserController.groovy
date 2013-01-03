package com.dogself

import com.dogself.core.User
import org.apache.commons.validator.EmailValidator
import org.springframework.web.servlet.ModelAndView

class UserController {

  def springSecurityService
  def emailConfirmationService
  def grailsApplication
  def navigationService
  def userService

  def afterInterceptor = [action:this.&injectModel, except:'index']

  private Map injectModel(Map model){
    navigationService.setupModelForPage("home", model); //TODO FIX THIS, should be 'login'
  }

  def confirmWelcome = {
    return [:]
  }

  def confirmInvalid = {
    return [:]
  }

  def editProfile = {
      return new ModelAndView("/user/editProfile", [user:  springSecurityService.currentUser])
  }

  def registerUser = {
    def rv =[:]
    def errors = [];

    User user = params;
    user.enabled = false;
    if(!user.username || user.username == ""){
      errors << ["key":"username", "value":"Email is required."]
    }
    if(!user.password || user.password == ""){
      errors << ["key":"password", "value":"Password is required."]
    }
    if(User.findByUsername(user.username)){
      errors << ["key":"username", "value":"This email address is already registered."]
    }
    rv["errors"] = errors;
    rv["success"] = errors.size() == 0
    if(rv["success"]){
      userService.createUser(user)
      emailConfirmationService.sendConfirmation(user.username, "Please confirm your email for MLS search", [view:'/email/emailConfirmRequestTemplate'])
    }

    render(contentType:"text/json") {
	   rv
    }

  }

  def loginUser = {

  }
  /**
   * from the contact me page
   */
  def sendContact = {
    def ret = ["success":false]
    def emailValidator = EmailValidator.getInstance()
    if(params.message && emailValidator.isValid(params.email)){
      sendMail {
          to grailsApplication.config.contactEmail
          subject "${grailsApplication.config.domainName} - contact email"
          body """
          Someone has connected you through your website:

          Name: ${params.name}
          Email: ${params.email}
          Phone: ${params.phone}
          Message: ${params.message}
          """
      }
      ret["success"] = true
    } else {
      if(emailValidator.isValid(params.email)){ 
        ret["error"] = "Message is required."
      } else {
        ret["error"] = "Valid E-mail is required."
      }
    }
      render(contentType:"text/json") {
        ret
      }

  }

}
