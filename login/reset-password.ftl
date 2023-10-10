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
                                                <a href="#" id="kc-current-locale-link">
                                                    ${locale.current}
                                                </a>
                                                <ul>
                                                    <#list locale.supported as l>
                                                        <li class="kc-dropdown-item"><a href="${l.url}">
                                                                ${l.label}
                                                            </a></li>
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
                                        <#if (auth_forget_password_is_active??)> 
                                            <#if (msg(auth_forget_password_is_active[0]) == 'true')> 
                                                <div class="form__group__login">
                                                    <span class="form__group__login__text">${msg('auth_forgetPassword')}</span>
                                                </div>
                                            </#if>
                                        </#if>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if captchaIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_captchaIsNotValid')}
                                            </span>
                                        </#if>
                                        <#if userIsNotExist??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_userIsNotExist')}
                                            </span>
                                        </#if>
                                        <#if userIsNotEnable??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_userIsNotEnable')}
                                            </span>
                                        </#if>
                                        <#if userIsNotOwnerOfMobile??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('auth_userIsNotOwnerOfMobile')}
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="1" id="nid" placeholder="${msg('auth_nationalCode')}" required class="${properties.kcInputClass!} form__input" name="username" value="" type="text" autofocus autocomplete="off"
                                                oninvalid="this.setCustomValidity('${msg('auth_pleaseEnterNationalCode')}')" oninput="setCustomValidity('')"/>
                                        </div>
                                        <#--  <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="2" id="mobile" placeholder="موبایل" required class="${properties.kcInputClass!} form__input" name="mobile_number" value="" type="text" autofocus autocomplete="off"
                                                oninvalid="this.setCustomValidity('لطفا موبایل را وارد کنید')" oninput="setCustomValidity('')"/>
                                        </div>  -->
                                        <#if (auth_captcha_is_active??)> 
                                            <#if (msg(auth_captcha_is_active[0]) == 'true')> 
                                                <div class="${properties.kcFormGroupClass!} form__group">
                                                    <input tabindex="2" id="captcha" placeholder="${msg('auth_captchaText')}"
                                                        required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                        oninvalid="this.setCustomValidity('${msg('auth_pleaseEnterTheCaptcha')}')" oninput="setCustomValidity('')" />
                                                    <span class="form__captcha"><img class ="locale-choose" src="data:image/png;charset=utf-8;base64,${captchaImage}" /></span>
                                                </div>
                                                <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                            </#if>
                                        </#if>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
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