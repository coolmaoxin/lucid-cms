package com.dogself.realestate

class MlsListing {

    static constraints = {
        propType(nullable:true)
        listingId(nullable:true)
        agentId(nullable:true)
        status(nullable:true)
        price(nullable:true)
        streetNumber(nullable:true)
        streetName(nullable:true)
        unitNumber(nullable:true)
        area(nullable:true)
        zipCode(nullable:true)
        photoCount(nullable:true)
        photoDate(nullable:true)
        photoMask(nullable:true)
        sfType(nullable:true)
        style(nullable:true)
        lotSize(nullable:true)
        acres(nullable:true)
        squareFeet(nullable:true)
        garageSpaces(nullable:true)
        garageParking(nullable:true)
        basement(nullable:true)
        numberRooms(nullable:true)
        numberBedrooms(nullable:true)
        numberFullBaths(nullable:true)
        numberHalfBaths(nullable:true)
        hasMasterBath(nullable:true)
        livingLevels(nullable:true)
    }

    static mapping = {
        id generator: 'assigned', name: "listingId", type: 'double'
    }

    static hasOne = [town: Town]

    //PROP_TYPE|LIST_NO|LIST_AGENT|LIST_OFFICE|STATUS|LIST_PRICE|STREET_NO|STREET_NAME|UNIT_NO|
    // TOWN_NUM|AREA|ZIP_CODE|LENDER_OWNED|PHOTO_COUNT|PHOTO_DATE|PHOTO_MASK|SF_TYPE|
    // STYLE|LOT_SIZE|ACRE|SQUARE_FEET|GARAGE_SPACES|
    // GARAGE_PARKING|BASEMENT|NO_ROOMS|NO_BEDROOMS|NO_FULL_BATHS|NO_HALF_BATHS|MASTER_BATH|
    // LIV_LEVEL|LIV_DIMEN|DIN_LEVEL|DIN_DIMEN|FAM_LEVEL|FAM_DIMEN|KIT_LEVEL|KIT_DIMEN|MBR_LEVEL|MBR_DIMEN|BED2_LEVEL|BED2_DIMEN|BED3_LEVEL|BED3_DIMEN|BED4_LEVEL|BED4_DIMEN|BED5_LEVEL|BED5_DIMEN|BTH1_LEVEL|BTH1_DIMEN|BTH2_LEVEL|BTH2_DIMEN|BTH3_LEVEL|BTH3_DIMEN|LAUNDRY_LEVEL|LAUNDRY_DIMEN|OTH1_ROOM_NAME|OTH1_LEVEL|OTH1_DIMEN|OTH2_ROOM_NAME|OTH2_LEVEL|OTH2_DIMEN|OTH3_ROOM_NAME|OTH3_LEVEL|OTH3_DIMEN|OTH4_ROOM_NAME|OTH4_LEVEL|OTH4_DIMEN|OTH5_ROOM_NAME|OTH5_LEVEL|OTH5_DIMEN|OTH6_ROOM_NAME|OTH6_LEVEL|OTH6_DIMEN

    Date dateCreated //By merely defining a lastUpdated and dateCreated property these will be automatically updated for you by GORM.


    String propType
    Long listingId
    String agentId
    String status
    Double price
    String streetNumber
    String streetName
    String unitNumber
    String area
    String zipCode
    Integer photoCount
    String photoDate
    String photoMask
    String sfType
    String style
    Double lotSize
    Double acres
    Double squareFeet
    Integer garageSpaces
    String garageParking
    String basement
    Integer numberRooms
    Integer numberBedrooms
    Integer numberFullBaths
    Integer numberHalfBaths
    Boolean hasMasterBath
    Integer livingLevels


}
