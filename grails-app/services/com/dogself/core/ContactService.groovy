package com.dogself.core

import com.dogself.core.ContactInfo

class ContactService {

  def grailsApplication

  static transactional = true

  def getContactInfo() {
    ContactInfo.list()[0]
  }

  def sendEmailToSiteOwner(String s, String b){
    sendMail {
        to grailsApplication.config.contactEmail
        subject s
        body b
    }
  }
}
