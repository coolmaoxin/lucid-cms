package com.dogself.core

class User {

  String username
  String password
  boolean enabled
  boolean accountExpired
  boolean accountLocked
  boolean passwordExpired

  String phone = ""
  String zip = ""
  String name = ""



  static constraints = {
      username blank: false, unique: true
      password blank: false
      name(nullable: true);
      zip(nullable: true);
      phone(nullable: true);
  }

  static mapping = {
      password column: '`password`'
  }

  Set<Role> getAuthorities() {
      UserRole.findAllByUser(this).collect { it.role } as Set
  }
}
