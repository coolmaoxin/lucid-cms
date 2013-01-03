<%@ page contentType="text/html;charset=UTF-8" %>


  <fieldset>

    <div class="ctrlHolder">
      <div>To view detailed listings you must register.</div>
      <div>Only a <b>valid email</b> and a <b>password</b> are required, all other fields are optional</div>
      <br/>
      <div>We will never sell or share this information with anyone. We will not spam you.</div>
    </div>
    <g:formRemote id="registerUser" class="uniForm ui-corner-all pad10" name="register" url="[ controller: 'user', action: 'registerUser']" onSuccess="userRegComplete(data)" onFailure="userRegComplete({success:false})">
    <div class="ctrlHolder">
      <label for="name">Your Name</label>
      <input type="text" class="textInput" size="65" value="" name="name" id="name">
    </div>
    <div class="ctrlHolder">
      <label for="username">Your E&ndash;Mail Address</label>
      <input type="text" class="textInput" size="35" value="" name="username" id="username">
      <p class="formHint" id="usernameValidation">Required. Use a real e&ndash;mail address. Activation email will be sent here.</p>
    </div>
    <div class="ctrlHolder">
      <label for="password">Choose a Password</label>
      <input type="password" class="textInput" size="35" value="" name="password" id="password">
      <p class="formHint" id="passwordValidation">Required.</p>
    </div>
    <div class="ctrlHolder">
      <label for="zip">Your ZIP Code</label>
      <input type="text" class="textInput" size="9" value="" name="zip" id="zip">
     <p class="formHint">Optional, but will help you find more relevant listings.</p>
    </div>
    <div class="ctrlHolder">
      <label for="phone">Your Phone Number</label>
      <input type="text" class="textInput" size="15" value="" name="phone" id="phone">
    </div>
    <div class="buttonHolder" id="registerUserInfo"><button class="primaryAction" type="submit">Register</button></div>
    <div class="ctrlHolder">I already have an account, let me <g:link controller="login" action="auth">log in</g:link></div>
    </g:formRemote>
  </fieldset>
