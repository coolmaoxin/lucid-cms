package grails

import com.dogself.realestate.MlsListing
import com.dogself.realestate.Town
import org.codehaus.groovy.grails.commons.ConfigurationHolder

class MlsDownloadJob {

  def locationService
  def contactService
  def adminService
  def mlsService

  static transactional = true
  def sessionRequired = true



  String towns = "http://idx.mlspin.com/towns.asp"

  static triggers = {
    cron name: 'mlsTrigger', cronExpression: "0 3 0 * * ?"
 //   simple name: 'mlsTrigger', startDelay: 1000, repeatInterval: 1000 * 60 * 60 * 24
  }
  def group = "mlsGroup"

  def execute(){
    if(adminService.getSiteComponents().mls){
        //todo this doesnt actually work right now, never finishes inserting both tables in one run. find out why
        scrapeTowns()
        scrapeListings()
    }
  }

  private void scrapeListings() {

    def downloadUrl =  "http://idx.mlspin.com/idx.asp?user=${adminService.getSiteConfig().mlsUsername}&pass=${adminService.getSiteConfig().mlsPassword}&proptype=SF"

    int count = 0;

    boolean skippedFirst = false
    List<MlsListing> newListings = [];
    mlsService.deleteAllListings();

    log.info "starting mls download"

    new URL(downloadUrl).openStream().eachLine() { String line ->
        if (!skippedFirst) {
          skippedFirst = true
        } else {
          MlsListing l = getMlsListingFromArray(line.split(/\|/, -1));
          newListings << l;
          count++;
        }

        if(newListings.size() == 5000){
            mlsService.insert(newListings);
            newListings.clear();
        }
    }
    mlsService.insert(newListings, true);
    log.info("mls download complete, scraped ${count}, in db: ${MlsListing.count()}");
  }

  private void scrapeTowns() {
    boolean skippedFirst = false
    log.info("starting to scrape towns")
    int count = 0;

    new URL(towns).openStream().eachLine() { String line ->
      if (!skippedFirst) {
        skippedFirst = true
      } else {
        Town t = getTownFromArray(line.split(/\|/, -1));
        locationService.saveNewTown(t)
        t = null;
        count++;
      }
    }
    log.info("scraped ${count} towns. in db: ${Town.count()}");
  }

  def Town getTownFromArray(String[] arr){
    return new Town(townId:getLong(arr[0]),
                    name: arr[1],
                    county: arr[2],
                    state: arr[3])
  }

  def MlsListing getMlsListingFromArray(String[] arr){
    //not a fan of this, but their format is crap
    if(arr.length < 10){
      contactService.sendEmailToSiteOwner("Your website's MLS search is down", """
        Your MLS user/pass changed but your website still has the old values,
        and thus cannot fetch new MLS listings. MLS Search will not work on your
        website until you update MLS user/pass in your website admin panel.
      """)
    }



    return new MlsListing(
            propType: arr[0],//PROP_TYPE
            listingId: getLong(arr[1]),//LIST_NO
            agentId: arr[2],//LIST_AGENT
            //LIST_OFFICE
            status: arr[4],//STATUS
            price: getDouble(arr[5]),//LIST_PRICE
            streetNumber: arr[6],//STREET_NO
            streetName: arr[7],//STREET_NAME
            unitNumber: arr[8],//UNIT_NO
            town: Town.findById(getLong(arr[9])),//TOWN_NUM
            area: arr[10],//AREA
            zipCode: arr[11],//ZIP_CODE
            //LENDER_OWNED
            photoCount: getInteger(arr[13]),//PHOTO_COUNT
            photoDate: arr[14],
            photoMask: arr[15],
            sfType: arr[16],
            style: arr[17],
            lotSize: getDouble(arr[18]),
            acres: getDouble(arr[19]),
            squareFeet: getDouble(arr[20]),
            garageSpaces: getInteger(arr[21]),
            garageParking: arr[22],
            basement: arr[23],
            numberRooms: getInteger(arr[24]),
            numberBedrooms: getInteger(arr[25]),
            numberFullBaths: getInteger(arr[26]),
            numberHalfBaths: getInteger(arr[27]),
            hasMasterBath: arr[28] == "Y",
            livingLevels: getInteger(arr[29])
    )
  }

  private Double getDouble(String arr) {
    if(arr.matches(/\d+\.?(\d+)?/)){
      return Double.parseDouble(arr)
    }
    return null;
  }

  private Long getLong(String arr) {
    if(arr.matches(/\d+/)){
      return Long.parseLong(arr)
    }
    return null
  }

  private Integer getInteger(String arr) {
    if(arr.matches(/\d+/)){
      return Integer.parseInt(arr)
    }
    return null
  }
}
