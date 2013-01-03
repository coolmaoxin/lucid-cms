<form action='${postUrl}' method='POST' id='loginForm' class='uniForm ui-corner-all'>
  <fieldset>
  <div class="ctrlHolder">Please Log In</div>
  <div class="ctrlHolder">
    <label for="username">Your E&ndash;Mail Address</label>
    <input type="text" class="textInput" size="35" value="" name="j_username" id="username">
  </div>
  <div class="ctrlHolder">
    <label for="password">Your Password</label>
    <input type="password" class="textInput" size="35" value="" name="j_password" id="password">
  </div>
  <div class="ctrlHolder">
    <label for='remember_me'>Remember me</label>
    <input type='checkbox' name='${rememberMeParameter}' id='remember_me'
          <g:if test='${hasCookie}'>checked='checked'</g:if> />
  </div>

  <g:hiddenField name="id" value="${listingId}"/>
  <div class="buttonHolder" id="loginUserInfo"><button class="primaryAction" type="submit">Login</button></div>
  </fieldset>
</form>