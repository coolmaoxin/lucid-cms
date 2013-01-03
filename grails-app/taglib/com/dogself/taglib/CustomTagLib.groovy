package com.dogself.taglib

import com.dogself.core.UserEditableSection

class CustomTagLib {

    def userEditingService

    def dateFormat = { attrs, body ->
        out << new java.text.SimpleDateFormat("MM/dd/yyyy").format(attrs.date)
    }

    //if the current navigation item is in the bread crumb, it will require extra classes on the UI
    def setClassWhenNavigationInCrumb = { attrs, body ->
        String clazz = ""
        attrs["breadCrumb"].each {
            if (it.id == attrs["nav"].id) {
                clazz = attrs["clazz"]
            }
        }
        out << clazz
    }

    def userEditableSection = { attrs, body ->
        def bodyCont = body();
        String bodyStr;
        if(bodyCont instanceof String){
            bodyStr = bodyCont;
        } else {
            bodyStr = bodyCont.readAsString(); //if body is not empty it will be a stream
        }
        UserEditableSection sec = userEditingService.getUserEditableSection(attrs.name, bodyStr)
        out << sec.html
    }


    def searchSliderRange = {attrs, body ->
        out << """<div class="searchSlider ui-corner-all">
  <div class="data">${attrs["text"]}:
    <span class="input">${attrs["beforeInput"]}
      <input type='hidden' id="slider-${attrs["name"]}Min" name="${attrs["name"]}Min" value="">
      <input type='text' id="slider-${attrs["name"]}MinVisible" value="">${attrs["afterInput"]}
    </span>&nbsp;to
    <span class="input">${attrs["beforeInput"]}
      <input type='hidden' id="slider-${attrs["name"]}Max" name="${attrs["name"]}Max" value="">
      <input type='text' id="slider-${attrs["name"]}MaxVisible" value="">${attrs["afterInput"]}
    </span>
  </div>
  <div id="slider-${attrs["name"]}"></div>
</div>
<script type="text/javascript">
  \$(function(){
    createRangeSlider("slider-${attrs["name"]}", ${attrs["min"]}, ${attrs["max"]});
  })
</script>"""
    }

    def searchSlider = {attrs, body ->
        out << """<div class="searchSlider ui-corner-all">
  <label for="slider-${attrs["name"]}Min">${attrs["text"]}:</label>
  <span class="input">
    <input type="hidden" id="slider-${attrs["name"]}Min" name="${attrs["name"]}Min"/>
    <input type="text" id="slider-${attrs["name"]}MinVisible"/>
  </span>
  <div id="slider-${attrs["name"]}"></div>
</div>

<script type="text/javascript">
  \$(function(){
    createSlider("slider-${attrs["name"]}", ${attrs["min"]}, ${attrs["max"]})
  });
</script>"""
    }


}
