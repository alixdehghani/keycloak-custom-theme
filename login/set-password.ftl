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
                                                        <li class="kc-dropdown-item"><a href="${l.url?replace('protocol/openid-connect/auth','login-actions/authenticate')}">${l.label}</a></li>
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
                                            <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                            <h2 id="system-title">${msg('auth_organization')}</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <span class="form__group__login__text">${msg('auth_setPassword')}</span>
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if passwordHasNotMinimumRequirement??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_passwordHasNotMinimumRequirement')}
                                            </span>
                                        </#if>
                                        <#if passwordsAreNotTheSame??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_passwordsAreNotTheSame')}
                                            </span>
                                        </#if>
                                        <#if setPasswordHasError??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_psetPasswordHasError')}
                                            </span>
                                        </#if>
                                        <#if passwordIsExistInPast??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_passwordIsExistInPast')}
                                            </span>                                            
                                            <input id="password-is-exist-in-past" type="hidden" value="${msg(auth_passwordIsExistInPast)}">
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input id="username" style="display: none;" value="<#if auth_username??><#if auth_username[0]??>${msg(auth_username[0])}</#if></#if>">
                                            <input tabindex="1" id="password" required placeholder="&#xf023; ${msg('auth_newPassword')}" class="${properties.kcInputClass!} form__input" autofocus name="passwordNew" type="password" autocomplete="off"
                                                oninvalid="this.setCustomValidity('${msg('auth_pleaseEnterPassword')}')" oninput="setCustomValidity('')"/>
                                            <span toggle="#password-field" onclick="onTogglePassword('password', 'toggle-password-1')" class="fa fa-fw fa-eye field-icon locale-choose toggle-password" id="toggle-password-1"></span>
                                            <div  class="textbox text-center" style="padding: .25rem .5rem 0 0; color: red;"></div>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="2" id="repeat-password" required placeholder="&#xf023; ${msg('auth_repeatNewPassword')}" class="${properties.kcInputClass!} form__input" name="passwordRepeatNew" type="password" autocomplete="off"
                                                oninvalid="this.setCustomValidity('${msg('auth_repeatNewPassword')}')" oninput="setCustomValidity('')"/>
                                            <span toggle="#password-field" onclick="onTogglePassword('repeat-password', 'toggle-password-2')" class="fa fa-fw fa-eye field-icon locale-choose toggle-password" id="toggle-password-2"></span>
                                        </div>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="credentialId" />
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link center-aling" style="margin: 115px auto 25px auto">                                            
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
                                        <p id="copyright">${msg('auth_footerText')}</p>
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
    function onTogglePassword(inputId, toggleIconId) {
        const x = document.getElementById(inputId);
        if (x.type === "password") {
            x.type = "text";
            document.getElementById(toggleIconId).classList.remove('fa-eye');
            document.getElementById(toggleIconId).classList.add('fa-eye-slash');
        } else {
            x.type = "password";
            document.getElementById(toggleIconId).classList.remove('fa-eye-slash');
            document.getElementById(toggleIconId).classList.add('fa-eye');
        }
    }
</script>
<script src="${url.resourcesPath}/js/passwordPolicyHints.js" type="text/javascript"></script>