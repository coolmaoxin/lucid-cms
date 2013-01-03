package com.dogself.core

class SiteConfig {

    static constraints = {
        googleAppsMeta(nullable:true)
        statCounterProject(nullable:true)
        statCounterSecurity(nullable:true)
        mlsUsername(nullable:true)
        mlsPassword(nullable:true)
    }

    static transients = ["headerFont"]


    boolean adminCreated; //has an admin account been created yet?
    String googleAppsMeta; //<meta> tag to create google apps acct on site

    Map<String,String> metaTags;// html meta tags, see AdminService for names
    Map<String,String> misc = new HashMap();

    public String getHeaderFont(){ //font from google fonts api
        return misc["headerFont"]
    }

    public void setHeaderFont(String font){
        misc["headerFont"] = font;
    }



    //TODO: DONT FORGET TO ADD NULLABLE!

    boolean statCounterEnabled;
    String statCounterProject;
    String statCounterSecurity;

    String mlsUsername;
    String mlsPassword;
}
