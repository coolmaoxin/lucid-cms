package com.dogself.sites.stealthispipe

import com.dogself.blog.GuestbookEntry
import org.springframework.web.servlet.ModelAndView

import com.dogself.realestate.Zipcode

class StealThisPipeController {

    def domainValidatorService
    def navigationService
    def locationService

    List pipes = [
            ["NH01": "xx"],
            ["NH02": "xx"],
            ["NH03": "xx"],
            ["NH04": "xx"],
            ["NH05": "xx"],

            ["MA01": "xx"],
            ["MA02": "xx"],
            ["MA03": "xx"],
            ["MA04": "xx"],
            ["MA05": "xx"],
    ]


    def guestbookLog = {
        def p = []
        pipes.each { Map m ->
            p << m.keySet().asList().get(0)
        }
        Map model = ["pipes": p]
        navigationService.setupModelForPage("pipes-log", model)
        return new ModelAndView("/guestbook/sites/stealthispipeLog", model)
    }

    def guestbookShow = {
        String show = params.show;
        List<GuestbookEntry> list = GuestbookEntry.findAll()
        if (show) {
            list = list.findAll {
                return it.fields.pipe.startsWith(show)
            }
        }

        for(GuestbookEntry ge : list){
            Zipcode z = Zipcode.findByZipcode(ge.fields.zipcode)
            ge.fields.put("place",z?.getCity()+", "+z?.getStatePrefix());
        }

        def p = []
        def mostActive = "N/A";
        int mostEntries = 1;
        pipes.each { Map m ->
            p << m.keySet().asList().get(0)
            List s = GuestbookEntry.findAll().findAll {
                return it.fields.pipe.startsWith(m.keySet().asList().get(0))
            }
            if (s.size() > mostEntries) {
                mostEntries = s.size()
                mostActive = s.get(0).fields.pipe
            }
        }

        Map model = ["list": list.reverse(), "show": show ?: "", "pipes": p, "mostActive": mostActive];
        navigationService.setupModelForPage("pipes-show", model)
        return new ModelAndView("/guestbook/sites/stealthispipeShow", model)
    }


    def addEntry = {
        GuestbookEntry e = params;
        e.fields = params["fields"];
        Map v = validateGuestbookEntry(e)
        if (v.valid) {
            e.save(flush: true)
        }

        render(contentType: "text/json") {
            v
        }
    }

    Map validateGuestbookEntry(GuestbookEntry it) {

        Map valids = [:]
        pipes.each { Map m ->
            valids.putAll(m)
        }
        if (!it.name) {
            return ["valid": false,
                    "message": "Name is required."]
        }
        if (!locationService.isZipcodeValid(it.fields.zipcode)) {
            return ["valid": false,
                    "message": "Invalid zipcode."]
        }
        if (!it.fields.pipe) {
            return ["valid": false,
                    "message": "Select a pipe you stole."]
        }
        if (!it.fields.zipcode) {
            return ["valid": false,
                    "message": "Zip code is required."]
        }


        if (it.fields.pin.toUpperCase() == valids[it.fields.pipe]) {
            return ["valid": true, "message": "Thank you."]
        } else {
            return ["valid": false,
                    "message": "The pin you provided does not match the pin on file for that pipe."]
        }
    }

    def getMarkers = {
        String show = params.show;
        List wholeList = GuestbookEntry.findAll()
        List pipesToShow = []
        List allMarkers = []; //the thing is, when user clicks on a entry on the left, i need to show the marker on the map, but all i have is the marker's index, so i need to make sure the entries are in the same order as the entries listing on the page (which is sorted by date)


        List<GuestbookEntry> sortedList = wholeList;
        if (show) {
            sortedList = wholeList.findAll {
                return it.fields.pipe.startsWith(show)
            }
        }
        for(GuestbookEntry a : sortedList){
            allMarkers << getMarker(a);
        }

        pipes.each { Map m ->
            pipesToShow << m.keySet().asList().findAll {
                it.startsWith(show)
            }
        }
        pipesToShow = pipesToShow.flatten()

        List pipeLives = []
        pipesToShow.each { String pipeName ->



            List list = wholeList.findAll {
                return it.fields.pipe.startsWith(pipeName)
            }

            List markers = new ArrayList();
            for (GuestbookEntry a: list) {
                Map am = getMarker(a)
                markers.add(am);
            }
            pipeLives << ["name":pipeName, "markers" : markers]
        }
        render(contentType: "text/json") {
            ["lives":pipeLives, "markers":allMarkers]
        }
    }

    public Map getMarker(GuestbookEntry a){
        Map am = new HashMap();
        Zipcode z = Zipcode.findByZipcode(a.fields.zipcode)
        am.put("latitude", z?.lat);
        am.put("longitude", z?.lon);
        am.put("html", a.name.encodeAsHTML() + " stole " + a.fields.pipe.encodeAsHTML() + " on "
                + new java.text.SimpleDateFormat("MM/dd/yyyy").format(a.dateCreated)+" in "+
        z.city+" "+z.statePrefix);
        am.put("popup", false);
        am.put("id", a.id);
        return am;
    }

}
