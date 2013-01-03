package com.dogself

import com.dogself.core.Navigation

class EntryController {

    def navigationService

    /**
     * sole purpose of this controller is to redirect you to the right place based on first enabled tab
     * when you go to /
     */
    def index = {
        if(navigationService.getRootNavigation().children.size() == 0){
           //there are no user pages, must redirect to a URLMapped custom controller
           Navigation cust = navigationService.getCustomNavigation().find {
               it.active
           };
           return redirect(uri:"/pages/${cust.urlPath}");
        } else {
            
        }
    }
}
