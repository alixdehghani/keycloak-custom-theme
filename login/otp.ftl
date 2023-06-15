<#import "template.ftl" as layout>
    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section="header">
            <#elseif section="form">            
                <div id="kc-form" class="section-book">
                    <div id="kc-form-wrapper" class="row">
                        <div class="book">
                            <div class="book__form">
                                <#if realm.internationalizationEnabled && locale.supported?size gt 1>
                                    <div id="kc-locale">
                                        <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                            <div class="kc-dropdown" id="kc-locale-dropdown">
                                                <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                                <ul>
                                                    <#list locale.supported as l>
                                                        <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                                    </#list>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </#if>
                                <form id="kc-form-login" class="form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                    <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                                    <div class="book__form-section">
                                        <div class="book__form__title">
                                            <h2>سامانه احرازهویت یکپارچه</h2>
                                            <h2>وزارت کار، تعاون و رفاه اجتماعی</h2>                                            
                                        </div>
                                        <div class="form__group__login">
                                        <#if otpUserPhoneSent??>
                                            <span id="otp-user-phone-sent" style="display: none;">${msg(otpUserPhoneSent)}</span>
                                            <span class="form__group__login__text ">رمز به شماره <span class="otp-user-phone-sent-txt" style="display:inline-block;direction: ltr;"></span> ارسال شده است</span>
                                        </#if>
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if otpIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                کد وارد شده اشتباه است
                                            </span>
                                        </#if>
                                        <div class="sms-container form__group">
                                            <div class="inputfield">
                                            <input type="number" maxlength="1" class="sms-input" disabled />
                                            <input type="number" maxlength="1" class="sms-input" disabled />
                                            <input type="number" maxlength="1" class="sms-input" disabled />
                                            <input type="number" maxlength="1" class="sms-input" disabled />
                                            <input type="number" maxlength="1" class="sms-input" disabled />
                                            </div>
                                        </div>
                                        <#if generatedOtpRemainTime??>
                                            <span id="generated-otp-expire" style="display: none;">${msg(generatedOtpRemainTime)}</span>
                                        </#if>
                                        <span class="time-to-live"></span>
                                        <div class="form__group form__group__btn resend-otp-ctx">
                                            <input type="hidden" id="kc-form-buttons" class="resend-otp-submit" id="kc-resend-code" name="resendOtp" type="submit" value="true"/>
                                            <input id="kc-form-buttons" class="btn btn--light resend-otp-btn" id="kc-resend-code" type="submit" value="&#xf1d8; ارسال مجدد"/>
                                        </div>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="userOtpValue"/>
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green submit" onclick="validateOTP()" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link">
                                                <a class="block" href="#" disabled>&#xf095; ویرایش شماره تلفن همراه</a>
                                                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                                    <#--  <label id="kc-attempted-username">${auth.attemptedUsername}</label>  -->
                                                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                                    
                                                        <div class="kc-login-tooltip">
                                                            <#--  <i class="${properties.kcResetFlowIcon!}"></i>  -->
                                                            <i class="fa-repeat"></i>
                                                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                                        </div>
                                                    </a>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="book__form-image">
                                    <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                                    <div class="book__form-image-text">
                                        <#--  <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>  -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <#elseif section="info">
                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <div id="kc-registration-container">
                            <div id="kc-registration">
                                <span>
                                    ${msg("noAccount")}
                                    <a tabindex="6"
                                        href="${url.registrationUrl}">
                                        ${msg("doRegister")}
                                    </a></span>
                            </div>
                        </div>
                    </#if>
        </#if>
    </@layout.registrationLayout>

<script>
    //Initial references
    const input = document.querySelectorAll(".sms-input");
    const inputField = document.querySelector(".inputfield");
    const submitButton = document.querySelector(".submit");
    const dataInput = document.querySelector("#id-hidden-input");
    submitButton.disabled = true;
    let inputCount = 0,
    finalInput = "";

    //Update input
    const updateInputConfig = (element, disabledStatus) => {
    element.disabled = disabledStatus;
    if (!disabledStatus) {
        element.focus();
    } else {
        element.blur();
    }
    };

    input.forEach((element) => {
    element.addEventListener("keyup", (e) => {
        e.target.value = e.target.value.replace(/[^0-9]/g, "");
        let { value } = e.target;

        if (value.length == 1) {
        updateInputConfig(e.target, true);
        if (inputCount <= 4 && e.key != "Backspace") {
            finalInput += value;
            if (inputCount < 4) {
            updateInputConfig(e.target.nextElementSibling, false);
            }
        }
        inputCount += 1;
        } else if (value.length == 0 && e.key == "Backspace") {
        finalInput = finalInput.substring(0, finalInput.length - 1);
        if (inputCount == 0) {
            updateInputConfig(e.target, false);
            return false;
        }
        updateInputConfig(e.target, true);
        e.target.previousElementSibling.value = "";
        updateInputConfig(e.target.previousElementSibling, false);
        inputCount -= 1;
        } else if (value.length > 1) {
        e.target.value = value.split("")[0];
        }
        submitButton.disabled = true;
    });
    });

    window.addEventListener("keyup", (e) => {
    if (inputCount > 4) {        
        submitButton.disabled = false;
        if (e.key == "Backspace") {
        finalInput = finalInput.substring(0, finalInput.length - 1);
        updateInputConfig(inputField.lastElementChild, false);
        inputField.lastElementChild.value = "";
        inputCount -= 1;
        submitButton.disabled = true;
        }
    }
    });

    const validateOTP = () => {
        dataInput.value = finalInput;
    };

    //Start
    const startInput = () => {
    inputCount = 0;
    finalInput = "";
    input.forEach((element) => {
        element.value = "";
    });
    updateInputConfig(inputField.firstElementChild, false);
    };

    window.onload = startInput();
</script>

<script>
	function startTimer(duration, display, resentCtx) {
		var timer = duration, minutes, seconds;
		//document.getElementById('resend-sms').style.display = "none";
		setInterval(function () {
			minutes = parseInt(timer / 60, 10);
			seconds = parseInt(timer % 60, 10);

			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;

			display.textContent = minutes + ":" + seconds;

			if (--timer < 0) {
				timer = duration;
				//document.getElementById('resend-sms').style.display = "inline";
				//document.getElementById('time-to-live-message').style.display = "none";
                resentCtx.style.display = 'block';
                display.style.display = 'none';
                resendOtpSubmit.value = 'true';
			}
		}, 1000);
	}
	const ttlResult = document.getElementById('generated-otp-expire').innerHTML;    
    const ttl = Math.floor(Number(ttlResult.slice(1, ttlResult.length - 1)) / 1000);
    console.log(ttl)
    resentCtx = document.querySelector('.resend-otp-ctx');
	display = document.querySelector('.time-to-live');
    resendOtpSubmit = document.querySelector('.resend-otp-submit');
    otpUserPhoneSent = document.querySelector('#otp-user-phone-sent');
    otpUserPhoneSentTxt = document.querySelector('.otp-user-phone-sent-txt'); 
    const phooneNumber = otpUserPhoneSent.innerHTML.slice(1, otpUserPhoneSent.innerHTML.length - 1);
    otpUserPhoneSentTxt.innerHTML = phooneNumber;
    if(ttl > 0) {
        resentCtx.style.display = 'none';
        display.style.display = 'block';
        startTimer(ttl, display, resentCtx);
        resendOtpSubmit.value = 'false';
    } else {
        resentCtx.style.display = 'block';
        display.style.display = 'none';
        resendOtpSubmit.value = 'true';
    }

</script>