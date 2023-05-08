<#import "template.ftl" as layout>
    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section="header">
            
            <#elseif section="form">
                <div id="kc-form" class="section-book">
                    <div id="kc-form-wrapper" class="row">
                        <div class="book">
                            <div class="book__form">
                            
                                <form id="kc-form-login" class="form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                    <img class="book__form-image-logo" src="${url.resourcesPath}/img/fingerprint.png">
                                    <div class="book__form__title">
                                        <h2>سامانه احرازهویت یکپارچه</h2>
                                        <h2>وزارت کار، تعاون و رفاه اجتماعی</h2>
                                    </div>
                                    <div class="${properties.kcFormGroupClass!} form__group">
                                        <h3 style="text-align: center;margin-bottom: .5rem;">ورود با رمز یک بار مصرف</h3>
                                        <#if messagesPerField.existsError('username','password')>
                                                    <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                                    </span>
                                                </#if>
                                        <#if usernameEditDisabled??>
                                        
                                            <input tabindex="1" id="username" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" disabled />
                                            <#else>
                                                <input tabindex="1" id="username" placeholder="${msg('username')}" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                                                    aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                                
                                        </#if>
                                    </div>
                                    <div class="${properties.kcFormGroupClass!} form__group">
                                        
                                        <input tabindex="2" id="password" placeholder="${msg('password')}" class="${properties.kcInputClass!} form__input" name="password" type="password" autocomplete="off"
                                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                    </div>
                                    <div class="${properties.kcFormOptionsWrapperClass!}">
                                        <#if realm.resetPasswordAllowed>
                                            <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">
                                                    ${msg("doForgotPassword")}
                                                </a></span>
                                        </#if>
                                    </div>
                                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                                        <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                                    </div>
                                </form>
                                <div class="book__form-image">
                                    <img class="book__form-image-logo" src="${url.resourcesPath}/img/logo.png">
                                    <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>
                                </div>
                            </div>
                        </div>
                        <#if realm.password>
                            <form id="kc-form-login2" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                                
                                
                                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                                    <div id="kc-form-options">
                                        <#if realm.rememberMe && !usernameEditDisabled??>
                                            <div class="checkbox">
                                                <label>
                                                    <#if login.rememberMe??>
                                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked>
                                                        ${msg("rememberMe")}
                                                        <#else>
                                                            <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                                                            ${msg("rememberMe")}
                                                    </#if>
                                                </label>
                                            </div>
                                        </#if>
                                    </div>
                                    <div class="${properties.kcFormOptionsWrapperClass!}">
                                        <#if realm.resetPasswordAllowed>
                                            <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">
                                                    ${msg("doForgotPassword")}
                                                </a></span>
                                        </#if>
                                    </div>
                                </div>
                               
                    </form>
        </#if>
        </div>
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr />
                <h4>
                    ${msg("identity-provider-login-label")}
                </h4>
                <ul class="${properties.kcFormSocialAccountListClass!}
<#if social.providers?size gt 3>
${properties.kcFormSocialAccountListGridClass!}
</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!}
<#if social.providers?size gt 3>
${properties.kcFormSocialAccountGridItem!}
</#if>"
                            type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">
                                    ${p.displayName!}
                                </span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">
                                        ${p.displayName!}
                                    </span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
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