package com.dogself.realestate

import com.dogself.realestate.MlsListing
import com.dogself.realestate.ZillowListing

class ZillowService {

  def grailsApplication

  static transactional = true

  def ZillowListing getZillowId(MlsListing mlsListingInstance) {
  //TODO zillow integration: http://www.zillow.com/howto/api/GetSearchResults.htm
    def cityState = URLEncoder.encode("${mlsListingInstance.town.name},${mlsListingInstance.town.state}")
    def street = URLEncoder.encode("${mlsListingInstance.streetNumber} ${mlsListingInstance.streetName}");
    def url = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=${grailsApplication.config.zillowApiKey}&address=${street}&citystatezip=${cityState}"
    String xml = new URL(url).openStream().text
    def records = new XmlSlurper().parseText(xml);
    boolean success = records.message.code == "0"
    println records.message.code
    println xml
    println url
    if(success){
      ZillowListing z = new ZillowListing();
      def rec = records.response.results[0].result[0];
      z.zpid = rec.zpid.text();
      z.estimate = rec.zestimate.amount.text();
      z.valueLow = rec.zestimate.valuationRange.low.text();
      z.valueHigh = rec.zestimate.valuationRange.high.text();
    }
  }
}
