package com.dogself.core

import com.dogself.core.UserRole
import com.dogself.core.Role
import com.dogself.core.User

class UserService {

    def springSecurityService

    static transactional = true

    /**
     * create a new user. must have username nad password set.
     * will return NULL if another user with the same username exists
     * @param user
     * @return
     */
    User createUser(User user){
        if(User.findByUsername(user.username) == null){
            def userRole = Role.findByAuthority("ROLE_USER");
            user.password = springSecurityService.encodePassword(user.password)
            user.save(failOnError:true, flush: true)
            UserRole.create(user, userRole)
            return user;
        } else {
            return null;
        }
    }
    
    void deleteUser(User user){
        UserRole.removeAll(user);
        user.delete(flush: true);
    }
}
