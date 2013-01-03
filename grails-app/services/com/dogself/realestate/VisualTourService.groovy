package com.dogself.realestate

import com.dogself.realestate.VisualTour

class VisualTourService {

  static transactional = true
  Random rand = new Random()

  def VisualTour getRandomTour() {
    List tours = VisualTour.list();
    if(tours.size() > 0){
      return tours.get(rand.nextInt(tours.size()))
    }
    return null;
  }
}
