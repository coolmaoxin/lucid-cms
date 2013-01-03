package com.dogself.realestate

import com.google.common.base.Strings
import com.dogself.realestate.MlsListing

class MlsService {

    static transactional = true


    def Map getRanges(){
      def m = MlsListing.executeQuery("""select max(t.price)/1000,
                                                min(t.price)/1000,
                                                max(t.numberRooms),
                                                min(t.numberRooms),
                                                max(t.squareFeet),
                                                min(t.squareFeet),
                                                max(t.numberBedrooms),
                                                max(t.garageSpaces),
                                                max(t.numberFullBaths),
                                                max(t.numberHalfBaths) from MlsListing t""")[0];

      return ["priceMax": m[0],
              "priceMin": m[1],
              "roomsMax": m[2],
              "roomsMin": m[3],
              "areaMax": m[4],
              "areaMin": m[5],
              "bedroomsMin": m[6],
              "garagesMin": m[7],
              "fullbathMin": m[8],
              "halfbathMin": m[9]
      ]
    }
    def getListings(params) {

        params.max = Math.min(params?.max ? params.int('max') : 10, 100)
        params.offset = params.offset ? params.int('offset') : 0
        params.sort = params?.sort ?: "price"
        params.order = params?.order ?: "asc"

        List townIds = [];
        params.townIds.split(",").each{
          if(params[it]){
            townIds << Long.valueOf(it);
          }
        }

        List stuff =  MlsListing.createCriteria().list(
            max: params.max,
            offset: params.offset,
            sort: params.sort,

            order: params.order){
              'in' "town.townId", townIds
          
              if(params.bedroomsMin && !Strings.isNullOrEmpty(params.bedroomsMin)){
                ge "numberBedrooms", Integer.parseInt(params.bedroomsMin)
              }
              if(params.garagesMin && !Strings.isNullOrEmpty(params.garagesMin)){
                ge "garageSpaces", Integer.parseInt(params.garagesMin)
              }
              if(params.fullbathMin && !Strings.isNullOrEmpty(params.fullbathMin)){
                ge "numberFullBaths", Integer.parseInt(params.fullbathMin)
              }
              if(params.halfbathMin && !Strings.isNullOrEmpty(params.halfbathMin)){
                ge "numberHalfBaths", Integer.parseInt(params.halfbathMin)
              }
              if(params.areaMin && !Strings.isNullOrEmpty(params.areaMin) && !Strings.isNullOrEmpty(params.areaMax)){
                between("squareFeet", Double.parseDouble(params.areaMin), Double.parseDouble(params.areaMax))
              }
              if(params.priceMin && !Strings.isNullOrEmpty(params.priceMin) && !Strings.isNullOrEmpty(params.priceMax)){
                between("price", Double.parseDouble(params.priceMin) * 1000, Double.parseDouble(params.priceMax) * 1000)
              }
              if(params.roomsMin && !Strings.isNullOrEmpty(params.roomsMin) && !Strings.isNullOrEmpty(params.roomsMax)){
                between("numberRooms", Integer.parseInt(params.roomsMin), Integer.parseInt(params.roomsMax)) 
              }

        }
      return stuff;

    }

    void deleteAllListings(){
        MlsListing.executeUpdate("delete MlsListing m");
    }

    void insert(List<MlsListing> l, boolean flush = false){
        l.each { MlsListing listing ->
            listing.save(flush:flush);
            if(listing.hasErrors()){
                log.error ("batch mls listing insert failed. Mls searches are probably broken. "+listing.errors);
            }
        }
        log.info("inserted ${l.size()} mls listings")
    }
}

