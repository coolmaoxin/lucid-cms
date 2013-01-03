package com.dogself.realestate

/**
 * This is scarped from the VT site by the quartz job
 */
class VisualTour {

    static constraints = {

    }

    Date dateCreated //By merely defining a lastUpdated and dateCreated property these will be automatically updated for you by GORM.


    String zip
    Integer slides
    String street
    String state
    String city
    String sqFt
    String photoFullPath
    String price
    String bedsBaths
    Double longitude
    Double latitude
    String tourTitle
    Integer tourId

    public String toString() {
        return tourTitle;
    }
}
