package com.dogself.core

class UserEditingService {

    static transactional = true

    def UserEditableSection getUserEditableSection(String name, String defaultBody) {
        UserEditableSection sec = UserEditableSection.findByName(name)
        if(!sec){
            sec = new UserEditableSection(html:defaultBody, name:name)
            sec.save()
        }
        return sec;
    }
}
