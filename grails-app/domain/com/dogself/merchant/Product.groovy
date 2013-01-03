package com.dogself.merchant

import com.dogself.core.Navigation

class Product {

    static constraints = {
        longDesc(nullable: true)
        longDesc(maxSize:1024000)
        shortDesc(nullable: true)
        price(min: 0D)
        salePrice(min: 0D)
        salePrice(nullable:true)
        mainProductImageName(nullable: true)
    }

    Date dateCreated
    Date lastUpdated

    Navigation navigation

    String name
    String longDesc = ""
    String shortDesc = ""
    Double price
    Double salePrice

    String mainProductImageName //this is the MAIN product image absolute file path

    boolean sold //mark as sold to leave on the site for SEO reasons
    boolean active

    public String toString(){
        return name;
    }
}
