package com.dogself.realestate

class Zipcode {

  String zipcode
  String city
  String county
  String state
  String statePrefix
  String areaCode
  String timezone
  Double lat
  Double lon

  def beforeUpdate = {
    throw new RuntimeException("do not update zipcode")
  }

  static mapping = {
    table 'zipcode'
    id generator: 'assigned', name: "zipcode", column: 'zip_code', unique: true
    city column: 'city'
    county column: 'county'
    state column: 'state_name'
    zipcode column: 'zip_code'
    statePrefix column: 'state_prefix'
    areaCode column: 'area_code'
    timezone column: 'time_zone'
    lat column: 'lat'
    lon column: 'lon'
    version false
  }

}
