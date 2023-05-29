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
                                            <h2>سامانه احرازهویت یکپارچه</h2>
                                            <h2>وزارت کار، تعاون و رفاه اجتماعی</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <span class="form__group__login__text">ورود / ثبت نام</span>
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                                </span>
                                            </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">                                            
                                            <#if usernameEditDisabled??>
                                                <input tabindex="1" id="username" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" disabled />
                                                <#else>
                                                    <input tabindex="1" id="username" placeholder="&#xf007; ${msg('username')}" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off"
                                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                            </#if>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="2" id="password" placeholder="&#xf023; ${msg('password')}" class="${properties.kcInputClass!} form__input" name="password" type="password" autocomplete="off"
                                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="3" id="captcha" placeholder="&#xf1c5; کد امنیتی"
                                             required class="${properties.kcInputClass!} form__input" name="user-captcha" type="text" autocomplete="off"
                                             oninvalid="this.setCustomValidity('لطفا مقادیر داخل عکس را وارد کنید')" oninput="setCustomValidity('')" />
                                             <img src="${url.resourcesPath}/img/captcha.jpg" class="form__captcha"/>
                                        </div>
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                            <#if realm.resetPasswordAllowed>
                                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">
                                                        ${msg("doForgotPassword")}
                                                    </a></span>
                                            </#if>
                                        </div>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="credentialId" />
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link">
                                                            <#if realm.password && social.providers??>
                        <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                            
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
                                        &#xf13e;
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
                                            <#--  <a href="#" disabled>&#xf13e; ورود از طریق پنجره خدمات دولت هوشمند</a>  -->
                                            <a class="block" href="#" disabled>&#xf095; ویرایش شماره تلفن همراه</a>
                                        </div>
                                    </div>
                                </form>
                                <div class="book__form-image">
                                    <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                                    <div class="book__form-image-text"><p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p></div>
                                    
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