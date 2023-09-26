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
                                            <h2>${msg('mainTitle')}</h2>
                                            <h2>${msg('organization')}</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <span class="form__group__login__text">${msg('login')} / ${msg('register')}</span>
                                        </div>
                                        <#if messagesPerField.existsError('password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if invalidPasswordMessage??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('invalidPasswordMessage')}
                                            </span>
                                        </#if>
                                        <#if passwordIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('passwordIsNotValid')}
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="1" id="password" required placeholder="${msg('password')}" class="${properties.kcInputClass!} form__input" name="password" autofocus type="password" autocomplete="off"
                                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                                oninvalid="this.setCustomValidity('${msg('pleaseEnterPassword')}')" oninput="setCustomValidity('')"/>
                                                <span toggle="#password-field" onclick="onTogglePassword()" class="fa fa-fw fa-eye field-icon locale-choose toggle-password" id="toggle-password"></span>
                                        </div>
                                        
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <#--  <input type="hidden" id="id-hidden-input" name="credentialId" />  -->
                                            <input tabindex="2" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="${properties.kcFormOptionsWrapperClass!} form__group__external-link" style="margin-top: -1rem;">
                                            <#if realm.resetPasswordAllowed>                                                        
                                                <span><a tabindex="3" class="padding-5-vertical" href="${url.loginResetCredentialsUrl}">
                                                    <i class="fa-unlock-alt margin-left-5px"></i> ${msg("doForgotPassword")}
                                                </a></span>
                                            </#if>
                                        </div>                                       
                                        <div class="form__group__external-link center-aling" style="margin: 115px auto 25px auto">                                            
                                                <#--  <#if (msg(sso_spi_change_phone_number_is_active)?? && msg(sso_spi_change_phone_number_is_active[0]) == 'TRUE')>  -->
                                                    <a class="block center-aling no-padd-marg" href="#" disabled><i class="padding-25 fa fa-mobile font-size-large margin-left-5px"></i><span>${msg('changeMobileNumber')}</span></a>                                                
                                                <#--  </#if>  -->
                                                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                                    <#--  <label id="kc-attempted-username">${auth.attemptedUsername}</label>  -->
                                                    <a id="reset-login" class="no-padd-marg" href="${url.loginRestartFlowUrl}">
                                                    
                                                        <div class="kc-login-tooltip center">
                                                            <#--  <i class="${properties.kcResetFlowIcon!}"></i>  -->
                                                            <i class="fa-repeat padding-25 margin-left-5px"></i>
                                                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                                        </div>
                                                    </a>
                                                </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="book__form-image locale-choose">
                                    <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                                    <div class="book__form-image-text">
                                        <p>${msg('footerText')}</p>
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
        function onTogglePassword() {
            const x = document.getElementById("password");
            if (x.type === "password") {
                x.type = "text";
                document.getElementById("toggle-password").classList.remove('fa-eye');
                document.getElementById("toggle-password").classList.add('fa-eye-slash');
            } else {
                x.type = "password";
                document.getElementById("toggle-password").classList.remove('fa-eye-slash');
                document.getElementById("toggle-password").classList.add('fa-eye');
            }
        }
  </script>