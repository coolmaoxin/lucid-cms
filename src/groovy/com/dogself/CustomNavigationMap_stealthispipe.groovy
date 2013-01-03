package com.dogself

import com.dogself.core.CustomNavigation

/**
 * If a site should have any truely custom tabs, they should be defined in a
 * CustomNavigationMap_SITENAME
 * file. also, the url mappings must be defined for the urlPaths.
 */
class CustomNavigationMap_stealthispipe extends CustomNavigationMap {
    
    public List<CustomNavigation> getCustomNav(){
        List<CustomNavigation> list = [
            new CustomNavigation(name:"Register Pipe", urlPath:"pipes-log", site: "stealthispipe"),
            new CustomNavigation(name:"View Pipes", urlPath:"pipes-show", site: "stealthispipe")
        ]
        return list;
    }
}
