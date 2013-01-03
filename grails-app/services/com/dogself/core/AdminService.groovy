package com.dogself.core

import com.dogself.core.UserRole
import com.dogself.core.Role
import com.dogself.core.User
import com.dogself.core.SiteConfig
import com.dogself.core.SiteComponent

class AdminService {

    static transactional = true

    /*
    make a user into an admin (change role)
     */
    boolean makeUserAdmin(User user) {
        boolean good = true;
        Role userRole = UserRole.findByUser(user).getRole()
        Role adminRole = Role.findByAuthority("ROLE_ADMIN")
        good &= UserRole.remove(user, userRole)
        good &= (UserRole.create(user, adminRole) != null)
        return good
    }

    boolean isAdmin(User user) {
        if(user != null){
            UserRole role = UserRole.findByUser(user)
            if(role != null){// this was null once because or weird cookie happening
                return role.getRole().getAuthority() == "ROLE_ADMIN" 
            }
        }
        return false;
    }

    /**
     * get the site config, if one doesnt exist, it is created.
     * @return
     */
    SiteConfig getSiteConfig(){
        def list = SiteConfig.list()
        SiteConfig s;
        if(list.size() == 0){
            s = createNewSiteConfig();
        } else {
            s = list.get(0);
        }
        return s;
    }

    SiteConfig updateSiteConfig(SiteConfig s){
        return s.save();
    }

    private SiteConfig createNewSiteConfig(){
        SiteConfig s = new SiteConfig();
        s.metaTags = [
                "googleApps":"",
                "description":"",
                "keywords":""
        ]
        s.adminCreated = false;
        s.statCounterEnabled = false;
        return s.save();
    }

    /**
     * what is and isnt enabled in this application?
     * @return
     */
    SiteComponent getSiteComponents(){
        def list = SiteComponent.list()
        SiteComponent s;
        if(list.size() == 0){
            s = new SiteComponent();
            s.login = true;
            s.save()
        } else {
            s = list.get(0);
        }
        return s;
    }

    boolean isSiteComponentDisabled(String name){
        SiteComponent s = getSiteComponents();
        return !(s[name] ?: false);
    }
}
