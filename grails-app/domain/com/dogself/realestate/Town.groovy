package com.dogself.realestate

class Town {

  static constraints = {
      lat(nullable:true)
      lon(nullable:true)
  }

  static mapping = {
    id generator: 'assigned', name: "townId", type: 'long'
  }

  static hasMany = [listings: MlsListing]

  Long townId
  String name
  String county
  String state
  Double lat
  Double lon

}
