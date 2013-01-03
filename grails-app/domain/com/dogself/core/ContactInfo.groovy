package com.dogself.core

class ContactInfo {

  static constraints = {
    name(blank:false)
    mobilePhone(blank:false)
    workPhone(blank:false)
    email(blank:false)
  }

  String name
  String mobilePhone
  String workPhone
  String email

  public String toString(){
      return name;
  }
}
