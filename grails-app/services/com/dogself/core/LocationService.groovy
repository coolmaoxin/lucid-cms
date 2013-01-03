package com.dogself.core

import com.dogself.realestate.Town
import groovy.sql.Sql
import com.dogself.realestate.Zipcode

class LocationService {

  def dataSource

  static transactional = true

  def deleteAllTowns(){
      Town.executeUpdate("delete Town t");
  }

  def saveNewTown(Town town) {
    def Town oldTown = Town.findByTownId(town.townId);
    if(oldTown?.name == town.name){
        return;
    }
    def q = """
    select sum(z.lat)/count(1) as lat, sum(z.lon)/count(1) as lon from zipcode z where z.city = '${town.name.replaceAll(/'/, "''")}' and z.state_prefix = '${town.state}'
    """.trim()
    def db = new Sql(dataSource)
    def result = db.rows(q)
    if(result && result.size()){
      town.lat = result[0].lat
      town.lon = result[0].lon
    }

    if(oldTown){
      oldTown.delete();
    }
    town.save();
  }


  def isZipcodeValid(String zipcode){
      Zipcode zip = Zipcode.findByZipcode(zipcode)
      return zip != null
  }

  def String getZipcodeByLatLon(double lat, double lon){
    def q = "select zip_code , abs(lat - ${lat}) + abs(lon - ${lon}) as b from zipcode where (abs(lat - ${lat}) + abs(lon - ${lon})) < 0.1 order by b asc"
    def db = new Sql(dataSource);
    List rows = db.rows(q);
    if(rows.size()){
      return rows[0].zipcode;
    } else {
      return "";
    }
  }

  //returns an array of objects [{name: "townsend, MA", id:123, distance: 2}, ... ]
  def getTownIdAndTownNameByRadius(String zip, String distance){
      Zipcode place = Zipcode.findByZipcode(zip)
      if(place){
        return getTownIdAndTownNameByRadius(place.lat, place.lon, distance)
      } else {
        return null
      }
  }
  //returns an array of objects [{name: "townsend, MA", id:123, distance: 2}, ... ]
  def getTownIdAndTownNameByRadius(double lat, double lon, String distance){


      def db = new Sql(dataSource) // Create a new instance of groovy.sql.Sql with the DB of the Grails app
      def q = """
        select t.town_id as id, concat(t.name, ', ', t.state) as name, acos((SIN( PI()* ${lat} /180 )*SIN( PI()*t.lat/180 )
        )+(cos(PI()* ${lat} /180)*COS( PI()*t.lat/180) *COS(PI()*t.lon/180-PI()* ${lon} /180))
        )* 3963.191 AS distance
        FROM town t
        WHERE 3963.191 * ACOS( (SIN(PI()* ${lat} /180)*SIN(PI() * t.lat/180)) +
        (COS(PI()* ${lat} /180)*cos(PI()*t.lat/180)*COS(PI() * t.lon/180-PI()* ${lon} /180))
        ) <= ${distance ?: 15}
        ORDER BY 3963.191 * ACOS(
        (SIN(PI()* ${lat} /180)*SIN(PI()*t.lat/180)) +
        (COS(PI()* ${lat} /180)*cos(PI()*t.lat/180)*COS(PI() * t.lon/180-PI()* ${lon} /180)))
      """
      return db.rows(q)
  }
}
