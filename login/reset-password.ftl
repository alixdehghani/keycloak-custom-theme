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
                                            <span class="form__group__login__text">اصلاح شماره تلفن همراه</span>
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if captchaIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                کد امنیتی اشتباه است
                                            </span>
                                        </#if>
                                        <#if userIsNotExist??>
                                            <span id="input-error" aria-live="polite">
                                                نام کاربری یافت نشد
                                            </span>
                                        </#if>
                                        <#if userIsNotEnable??>
                                            <span id="input-error" aria-live="polite">
                                                نام کاربری مورد نظر غیر فعال است
                                            </span>
                                        </#if>
                                        <#if userIsNotOwnerOfMobile??>
                                            <span id="input-error" aria-live="polite">
                                                شماره موبایل وارد شده اشتباه است
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="1" id="nid" placeholder="&#xf007; کد ملی" class="${properties.kcInputClass!} form__input" name="username" value="" type="text" autofocus autocomplete="off" />
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="1" id="mobile" placeholder="&#xf095; موبایل" class="${properties.kcInputClass!} form__input" name="mobile" value="" type="text" autofocus autocomplete="off" />
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="3" id="captcha" placeholder="&#xf1c5; کد امنیتی"
                                                required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                oninvalid="this.setCustomValidity('لطفا مقادیر داخل عکس را وارد کنید')" oninput="setCustomValidity('')" />
                                            <img src="data:image/png;charset=utf-8;base64,${captchaImage}" class="form__captcha" />
                                        </div>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                            <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link">
                                            <div id="kc-username" class="${properties.kcFormGroupClass!}">
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
                                        <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>
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