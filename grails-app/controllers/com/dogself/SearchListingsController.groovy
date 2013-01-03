package com.dogself

import org.springframework.web.servlet.ModelAndView
import org.springframework.security.core.context.SecurityContextHolder as SCH

import com.dogself.realestate.MlsListing
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.plugins.springsecurity.Secured
import grails.MlsDownloadJob
import grails.ScrapeJob

class SearchListingsController {


  def navigationService
  def mlsService
  def springSecurityService
  def authenticationTrustResolver
  def zillowService
  def adminService
  def locationService
  def contactService


  def afterInterceptor = [action: this.&injectModel]
  def beforeInterceptor = [action: this.&checkComponentActive]

  def checkComponentActive = {
      if(adminService.isSiteComponentDisabled("mls")){
          redirect(uri:"/")
      }
  }

  private Map injectModel(Map model) {
    navigationService.setupModelForPage("search-listings", model)
  }

  def index = {
    redirect(action: "list", params: params)
  }

  def list = {

    def list = []
    def ranges = mlsService.getRanges()
    def config = SpringSecurityUtils.securityConfig

    String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

    return new ModelAndView("/pages/searchListings", [
            mlsListingInstanceList: list,
            mlsListingInstanceTotal: list.totalCount,
            ranges: ranges,
            rememberMeParameter: config.rememberMe.parameter,
            hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
            postUrl:postUrl])
  }

  def search = {
    Map p = params;
    def list = mlsService.getListings(p);

    return new ModelAndView("/pages/searchListingsAjax",
            [mlsListingInstanceList: list,
             mlsListingInstanceTotal: list.totalCount])
  }

  def show = {
    def mlsListingInstance = MlsListing.get(params.id)
    if (!mlsListingInstance) {
      flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'mlsListing.label', default: 'MlsListing'), params.id])}"
      redirect(action: "list")
    }
    else {
      if(springSecurityService.isLoggedIn()){
      //TODO zillowness
      //  zillowService.getZillowId(mlsListingInstance)
        return new ModelAndView("/pages/detailedListing", [listing: mlsListingInstance])
      } else {
        return new ModelAndView("/pages/userRegistrationForm", [:])
      }
    }
  }



  def showRegistration = {
    return new ModelAndView("/pages/userRegistrationForm", [:])
  }

  def leftNav = {

    return new ModelAndView("/pages/showListingsLeftNav", [
            zipcode: springSecurityService.isLoggedIn() ? springSecurityService.currentUser.zip : ""])
  }

  @Secured(['ROLE_ADMIN']) //force an mls listing scape via admin panel  
  def forceScrapeMls = {
    MlsDownloadJob j = new MlsDownloadJob();
    j.adminService = adminService// newing it doesnt autowire
    j.mlsService = mlsService
    j.locationService = locationService
    j.contactService = contactService
    j.execute()
  }

    @Secured(['ROLE_ADMIN']) //force an mls listing scape via admin panel
  def forceScrapeVt = {
    new ScrapeJob().execute();
  }

  private Map parseParams(params){
      params.max = Math.min(params.max ? params.int('max') : 10, 100)
      params.bedroomsMin = params.bedroomsMin ?: params.int('bedroomsMin')
      params.garagesMin = params.garagesMin ?: params.int('garagesMin')
      params.fullbathMin = params.fullbathMin ?: params.int('fullbathMin')
      params.halfbathMin = params.halfbathMin ?: params.int('halfbathMin')
      params.areaMin = params.areaMin ?: params.double('areaMin')
      params.areaMax = params.areaMax ?: params.double('areaMax')
      params.priceMin = params.priceMin ?: params.double('priceMin')
      params.priceMax = params.priceMax ?: params.double('priceMax')
      params.roomsMin = params.roomsMin ?: params.int('roomsMin')
      params.roomsMax = params.roomsMax ?: params.int('roomsMax')
      params.offset = params.offset ? params.int('offset') : 0
      params.sort = params.sort ?: "price"
      params.order = params.order ?: "desc"
      return params
  }
}
