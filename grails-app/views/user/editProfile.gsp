<%@ page contentType="text/html;charset=UTF-8" %>


  <fieldset>

    <div class="ctrlHolder">
      <div>Edit Profile</div>
    </div>
    <g:formRemote id="editProfile" class="uniForm ui-corner-all pad10" name="editProfile" url="[ controller: 'user', action: 'editProfile']" onSuccess="userEditComplete(data)" onFailure="userEditComplete({success:false})">
    <div class="ctrlHolder">
      <label for="name">Your Name</label>
      <input type="text" class="textInput" size="65" value="${user.name}" name="name" id="name">
    </div>
    <div class="ctrlHolder">
      <label for="username">Your E&ndash;Mail Address</label>
      <input type="text" class="textInput" size="35" value="${user.username}" name="username" id="username">
    </div>
    <div class="ctrlHolder">
      <label for="zip">Your ZIP Code</label>
      <input type="text" class="textInput" size="9" value="${user.zip}" name="zip" id="zip">
    </div>
    <div class="ctrlHolder">
      <label for="phone">Your Phone Number</label>
      <input type="text" class="textInput" size="15" value="${user.phone}" name="phone" id="phone">
    </div>
    <div class="buttonHolder"><button class="primaryAction" type="submit">Change</button></div>
    </g:formRemote>
  </fieldset>
