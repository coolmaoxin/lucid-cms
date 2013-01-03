<html>
  <head>
      <meta name="layout" content="${siteName}"/>
  </head>
  <body>
    <g:userEditableSection name="Register Pipe - Page Top"/>
    <div id="guestbookForm">
        <g:form controller="stealThisPipe" action="addEntry" class="uniForm ui-corner-all">
            <fieldset>
                <div class="ctrlHolder">
                    <label>Your Name</label>
                    <input type="text" class="textInput" maxlength="20" value="" name="name">
                    <p class="formHint">Required.</p>
                </div>
                <div class="ctrlHolder">
                    <label>Pipe You Stole</label>
                    <select id="myPipe" name="fields.pipe">
                        <option value="">Pick One...</option>
                        <g:each in="${pipes}">
                            <option value="${it}">${it}</option>
                        </g:each>
                    </select>
                    <p class="formHint">Required. <g:userEditableSection name="Register Pipe - Serial Hint">You can find the serial by blah blah blah</g:userEditableSection></p>
                </div>
                <div class="ctrlHolder">
                    <label>Pipe Pin</label>
                    <input type="text" class="textInput" maxlength="5" value="" name="fields.pin">
                    <p class="formHint">Required. <g:userEditableSection name="Register Pipe - Pin Hint">You can find the pin by blah blah blah</g:userEditableSection></p>
                </div>
                <div class="ctrlHolder">
                    <label>Your ZIP Code</label>
                    <input type="text" class="textInput" maxlength="5" value="" id="zipcode" name="fields.zipcode">
                    <p class="formHint"><g:userEditableSection name="Register Pipe - Zipcode Hint"/></p>
                </div>
                <div class="ctrlHolder">
                    <label>Comments</label>
                    <textarea name="comment"></textarea>
                    <p class="formHint"><g:userEditableSection name="Register Pipe - Comments Hint"/></p>
                </div>

                <div class="buttonHolder" id="message"></div>
                <div class="buttonHolder"><input type="button" id="sub" value="Submit"/></div>
            </fieldset>
        </g:form>
    </div>
    <div class="ui-helper-clearfix"></div>
    <script type="text/javascript">
        $(function() {
            $("#sub").click(function() {
                var viewLinks = "<span>&nbsp;<a style='color:red !important;' href='"+ctxPath+"/pages/pipes-show?show="+$("#myPipe").val()+"'>See where your pipe has been</a></span>";
                var ser = $("#guestbookForm form").serialize();
                $("#message").html("");
                $.post(ctxPath + "/stealThisPipe/addEntry?" + ser, function(data) {
                    $("#message").html(data.message+(data.valid ? viewLinks : "")).show().css("color", data.valid ? "black" : "red")
                })
            })
            $("#zipcode").constrain("[0-9]");
            $("#date").datepicker();
            setZipcodeViaGeolocation($("#zipcode"));
        });
    </script>
</body>
</html>