package com.dogself.realestate

class ZillowListing {

  static constraints = {
     id generator: 'assigned', name: "zpid", type: 'String'
  }

  String zpid;

  double estimate;
  double valueLow;
  double valueHigh;

}
