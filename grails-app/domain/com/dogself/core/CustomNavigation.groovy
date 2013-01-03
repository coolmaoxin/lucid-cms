package com.dogself.core

//sites will have custom top level tabs (as in tabs with custom code like contact me)
class CustomNavigation {

    static constraints = {
    }

    String name; //text that appaers on tab name
    String urlPath; //SEOd name (About Me = about-me)

    String site;//which site should this nav appear under
}
