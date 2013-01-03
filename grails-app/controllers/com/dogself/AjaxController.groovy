package com.dogself


import grails.plugins.springsecurity.Secured
import com.dogself.core.UserHtmlPage
import com.dogself.realestate.VisualTour
import com.dogself.core.UserEditableSection

class AjaxController {

  def dataSource
  def locationService
    
  def visualTours = {
    render(contentType:"text/json") {
       VisualTour.list()
    }
  }

  def radius = {
    String zip = params.zipcode
    String distance = params.distance

    def result = locationService.getTownIdAndTownNameByRadius(zip, distance)
    render(contentType:"text/json") {
      if(result != null){
        result
      } else {
        [error:"Zip code ${zip} is not valid."]
      }
    }
  }

  def getZipcodeByLatLon = {
    double lat = params.getDouble("lat")
    double lon = params.getDouble("lon")
    render(contentType:"text/json") {
      [zipcode:locationService.getZipcodeByLatLon(lat, lon)]
    }
  }

    @Secured(['ROLE_ADMIN'])
    def getEditableHtml = {
        def id = params.id
        render(contentType:"text/json") {
          ["html": params.which == "section" ?
              UserEditableSection.findById(Long.parseLong(params.id)).html :
              UserHtmlPage.findById(id).html];
        }
    }
}
