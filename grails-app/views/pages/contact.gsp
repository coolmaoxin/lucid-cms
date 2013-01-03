<%@ page contentType="text/html;charset=UTF-8" %>
<html>
  <head>
  <meta name="layout" content="${siteName}" />
  </head>
  <body>
  <style>
    .errors{
      color: red;
      float: left;
      font-size: 26px;
      font-weight: bold;
    }
  </style>
  <g:userEditableSection name="Contact Form"/>
  <g:formRemote class="uniForm ui-corner-all" id="contactForm" name="contact" url="[controller:'user', action:'sendContact']" onSuccess="contactMe(data)" onFailure="contactMeFailed()">
    <fieldset>
    <div class="ctrlHolder">Send us a message:</div>
    <div class="ctrlHolder">
      <label >Your Name</label>
      <input type="text" class="textInput" size="35" value="" name="name">
    </div>
    <div class="ctrlHolder">
      <label >Your E&ndash;Mail Address</label>
      <input type="text" class="textInput" size="35" value="" name="email" >
      <p class="formHint" id="emailValidation">Required. We will email you back at this address</p>
    </div>
    <div class="ctrlHolder">
      <label >Your Phone Number</label>
      <input type="text" class="textInput" size="35" value="" name="phone">
    </div>
    <div class="ctrlHolder">
      <label>Your Question</label>
      <textarea rows="80" cols="40" class="textInput" name="message" ></textarea>
      <p class="formHint" id="messageValidation">Required.</p>
    </div>

    <div class="buttonHolder"><span class="errors" id="errors"></span><button class="primaryAction" type="submit">Send Message</button></div>
    </fieldset>
  </g:formRemote>
  <script type="text/javascript">
      function contactMe(data){
        if(data.success){
          $("#contactForm").parent().html("Thank you for your question, we will get back to you as soon as possible");
        } else {
          $("#errors").text(data.error);
        }
      }

    function contactMeFailed(){
      $("#errors").text("Internal server error. Could not send email.");
    }
  </script>
  </body>
</html>