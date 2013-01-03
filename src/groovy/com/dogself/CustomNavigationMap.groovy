package com.dogself

import com.dogself.core.CustomNavigation


abstract class CustomNavigationMap {

    abstract List<CustomNavigation> getCustomNav();

    public void createCustomNavIfNeeded(){
        List<CustomNavigation> list = getCustomNav()
        list.each { CustomNavigation nav ->
            if(!CustomNavigation.findByUrlPath(nav.urlPath)){
                nav.save(flush:true)
            }
        }
    }

}
