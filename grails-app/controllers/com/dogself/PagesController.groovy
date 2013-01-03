package com.dogself

import org.springframework.web.servlet.ModelAndView
import com.dogself.realestate.VisualTourService
import com.dogself.core.NavigationService
import com.dogself.core.Navigation

class PagesController {

    def NavigationService navigationService;
    def VisualTourService visualTourService
    def adminService
    def grailsApplication

    def index = {
        show()
    }

    def show = {
        String urlPath = params.urlPath

        if(navigationService.getRootNavigation().children.size() == 0){
        //there are no user pages, so we cant really be here...
           Navigation cust = navigationService.getCustomNavigation().find {
               it.active
           };
           return redirect(uri:"/pages/${cust.urlPath}");
            
        }
        Map model = navigationService.getModelForPage(urlPath);
        if(adminService.getSiteComponents().visualTours){
           model["featuredVisualTour"] = visualTourService.getRandomTour();
        }

        return new ModelAndView("/home/index", model);
    }

    def contact = {
        Map model = navigationService.getModelForPage("contact");
        return model;
    }
}
