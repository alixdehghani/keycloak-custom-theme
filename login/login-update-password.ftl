<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
    <#elseif section = "form">
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
                        <form id="kc-passwd-update-form" class="${properties.kcFormClass!} form" action="${url.loginAction}" method="post">
                            <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                            <div class="book__form-section">
                                <div class="book__form__title">
                                    <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                    <h2 id="system-title">${msg('auth_organization')}</h2>
                                </div>
                                <div class="form__group__login">
                                    <span class="form__group__login__text">${msg("updatePasswordTitle")}</span>
                                </div>
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
                                        
                                <input type="text" id="username" name="username" value="${username}" autocomplete="username"
                                    readonly="readonly" style="display:none;"/>
                                <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>

                                <div class="${properties.kcFormGroupClass!} form__group">
                                    <input type="password" id="password-new" name="password-new" class="${properties.kcInputClass!} password-hint-policy-el form__input"
                                            autofocus autocomplete="new-password" placeholder="${msg('passwordNew')}" 
                                            aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                        />
                                    <span toggle="#password-field" onclick="onTogglePassword('password-new', 'toggle-password-1')" class="fa fa-fw fa-eye field-icon locale-choose toggle-password" id="toggle-password-1"></span>
                                    <div  class="textbox text-center" style="padding: .25rem .5rem 0 0; color: red;"></div>
                                    
                                </div>

                                <div class="${properties.kcFormGroupClass!} form__group">
                                    <input type="password" id="password-confirm" name="password-confirm"
                                            class="${properties.kcInputClass!} form__input"
                                            autocomplete="new-password" placeholder="${msg('passwordConfirm')}"
                                            aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                        />
                                    <span toggle="#password-field" onclick="onTogglePassword('password-confirm', 'toggle-password-2')" class="fa fa-fw fa-eye field-icon locale-choose toggle-password" id="toggle-password-2"></span>
                                </div>


                                <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!} form__group form__group__btn">
                                    <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" type="submit" value="${msg('doSubmit')}" />
                                </div>
                                <div class="${properties.kcFormOptionsWrapperClass!} form__group__external-link center-aling" style="margin: 115px auto 25px auto">
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
                                <#--  <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>  -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
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