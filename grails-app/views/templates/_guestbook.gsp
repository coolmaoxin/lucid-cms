<div id="guestbookForm">
<g:form  controller="guestbook" action="addEntry" class="uniForm ui-corner-all">
  <fieldset>
  <div class="ctrlHolder">A bit about yourself...</div>
  <div class="ctrlHolder">
    <label>Your Name</label>
    <input type="text" class="textInput" size="35" value="" name="fields.name">
    <p class="formHint">Required.</p>
  </div>
  <div class="ctrlHolder">
    <label>Pipe You Stole</label>
    <select name="fields.pipe">
        <option value="">Pick One...</option>
        <option value="S1">S1</option>
        <option value="S2">S1</option>
        <option value="S3">S1</option>
    </select>
    <p class="formHint">Required. You can find the serial by blah blah blah</p>
  </div>
  <div class="ctrlHolder">
    <label>Pipe Pin</label>
    <input type="text" class="textInput" maxlength="5" value="" name="fields.pin">
    <p class="formHint">Required. You can find the pin by blah blah blah</p>
  </div>
  <div class="ctrlHolder">
    <label>Your ZIP Code</label>
    <input type="text" class="textInput" maxlength="5" value="" id="zipcode" name="fields.zipcode">
  </div>
  <div class="ctrlHolder">
    <label>Comments</label>
    <textarea name="fields.comments"></textarea>
  </div>
  <div class="ctrlHolder">
    <label>Date You Stole It</label>
    <input type="text" id="date" class="textInput" maxlength="12" value="<g:dateFormat date="${new Date()}" />" name="fields.date">
  </div>

  <g:hiddenField name="guestbookName" value="${leaf.urlPath}"/>
  <div class="buttonHolder" id="message"></div>
  <div class="buttonHolder"><input type="button" id="sub" value="Submit"/></div>
  </fieldset>
</g:form>
</div>
<div class="ui-helper-clearfix"></div>
<script type="text/javascript">
    $(function(){
        $("#sub").click(function(){
            var ser = $("#guestbookForm form").serialize();
            $("#message").html("");
            $.post(ctxPath+"/guestbook/addEntry?"+ser, function(data){
                $("#message").html(data.message).show().css("color", data.valid?"black":"red")
            })
        })
        $("#zipcode").constrain("[0-9]");
        $("#date").datepicker();
        setZipcodeViaGeolocation($("#zipcode"));
    });
</script>