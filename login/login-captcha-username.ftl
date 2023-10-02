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
                                            <h2 id="first-level-system-title">${msg('mainTitle')}</h2>
                                            <h2 id="system-title">${msg('organization')}</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <span class="form__group__login__text">${msg('login')} / ${msg('register')}</span>
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if captchaIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('captchaIsNotValid')}
                                            </span>
                                        </#if>
                                        <#if userIsNotExist??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('userIsNotExist')}
                                            </span>
                                        </#if>
                                        <#if userIsNotEnable??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('userIsNotEnable')}
                                            </span>
                                        </#if>
                                        <#if inquiryCompanyInfoHasError??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('inquiryCompanyInfoHasError')}
                                            </span>
                                        </#if>
                                        <#if nationalCodeIsNotValid??>
                                            <#if sso_plus_user_type??>
                                                <#if sso_plus_user_type[0]??>
                                                    <#if msg(sso_plus_user_type[0]) == 'PERSON'>
                                                        <span id="input-error" aria-live="polite">
                                                         ${msg('nationalCodeIsNotValid')}
                                                        </span>
                                                    </#if>
                                                    <#if msg(sso_plus_user_type[0]) == 'LEGAL'>
                                                        <span id="input-error" aria-live="polite">
                                                         ${msg('companyIdIsNotValid')}
                                                        </span>
                                                    </#if>
                                                </#if>
                                            </#if>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                                <#--  <select name="sso_plus_user_type" id="sso_plus_user_type_input" class="form__input" tabindex="1" placeholder="نوع کاربر" required
                                                    oninvalid="this.setCustomValidity('لطفا نوع کاربر را وارد کنید')" oninput="setCustomValidity('')">
                                                    <option value="PERSON" <#if sso_plus_user_type??><#if sso_plus_user_type[0]??><#if msg(sso_plus_user_type[0]) == 'PERSON'>selected</#if></#if></#if>>حقیقی</option>
                                                    <option value="LEGAL" <#if sso_plus_user_type??><#if sso_plus_user_type[0]??><#if msg(sso_plus_user_type[0]) == 'LEGAL'>selected</#if></#if></#if>>حقوقی</option>
                                                </select>  -->
                                                <div class="form__group form__input center no-border no-padding ">
                                                    <input type="hidden" id="sso_plus_user_type"  value="<#if sso_plus_user_type??><#if sso_plus_user_type[0]??>${msg(sso_plus_user_type[0])}</#if></#if>">
                                                    <span class="padding-5-vertical">${msg('userType')}: </span>
                                                    <input type="radio" id="person" class="padding-5-vertical" name="sso_plus_user_type" onclick="setPlaceHolder('PERSON')" value="PERSON">
                                                    <label for="person" class="padding-5-vertical">${msg('person')}</label>
                                                    <input type="radio" id="legal" class="padding-5-vertical" name="sso_plus_user_type" onclick="setPlaceHolder('LEGAL')" value="LEGAL">
                                                    <label for="legal" class="padding-5-vertical">${msg('legal')}</label>
                                                </div>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <#if usernameEditDisabled??>
                                                <input tabindex="2" id="username" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" disabled />
                                                <#else>
                                                    <input tabindex="2" required id="username" class="${properties.kcInputClass!} form__input" name="username" value="<#if username??><#if username[0]??>${msg(username[0])}</#if></#if>" type="text" autofocus autocomplete="off"
                                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                                            </#if>
                                        </div>
                                        <#if (auth_captcha_is_active??)> 
                                            <#if (msg(auth_captcha_is_active[0]) == 'true')> 
                                                <div class="${properties.kcFormGroupClass!} form__group">
                                                    <input tabindex="3" id="captcha" placeholder="${msg('captchaText')}"
                                                        required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                        oninvalid="this.setCustomValidity('${msg('pleaseEnterTheCaptcha')}')" oninput="setCustomValidity('')" />
                                                    <span class="form__captcha"><img class ="locale-choose" src="data:image/png;charset=utf-8;base64,${captchaImage}" /></span>
                                                </div>
                                            </#if>
                                        </#if>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link">
                                            <#if auth_government_sso_is_active??>
                                                <#if (msg(auth_government_sso_is_active[0]) == 'true')>
                                                    <#if realm.password && social.providers??>
                                                        <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                                                            <ul class="ul ${properties.kcFormSocialAccountListClass!}<#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                                                                <#list social.providers as p>
                                                                    <a id="social-${p.alias}" class="li btn ${properties.kcFormSocialAccountListButtonClass!}<#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
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
                                                </#if>
                                            </#if>
                                            
                                            <#if (auth_change_phone_number_is_active??)> 
                                                <#if (msg(auth_change_phone_number_is_active[0]) == 'true')>                                                    
                                                    <a class="block center-aling no-padding" href="#" disabled><i class="padding-5-all fa fa-mobile font-size-large margin-left-5px"></i><span>${msg('changeMobileNumber')}</span></a>
                                                </#if>
                                            </#if>
                                        </div>
                                    </div>
                                </form>
                                <div class="book__form-image locale-choose">
                                    <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                                    <div class="book__form-image-text">
                                        <p id="copyright">${msg('footerText')}</p>
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


    <script type="text/javascript">
        const usernameElement = document.getElementById('username');
        const ssoPlusUserTypeEl = document.getElementById('sso_plus_user_type');
        const legalElement = document.getElementById('legal');
        const personElement = document.getElementById('person');
        const kcLoginEl = document.getElementById('kc-login');
        const inputErrorEl = document.getElementById('input-error');
        const p2e = s => s.replace(/[۰-۹]/g, d => '۰۱۲۳۴۵۶۷۸۹'.indexOf(d));
        if(!ssoPlusUserTypeEl?.value ) {
            personElement.checked = true;
            setPlaceHolder('PERSON');
        } else if(ssoPlusUserTypeEl?.value === 'LEGAL') {
            legalElement.checked = true;
            setPlaceHolder('LEGAL');
        } else if(ssoPlusUserTypeEl?.value === 'PERSON') {
            personElement.checked = true;
            setPlaceHolder('PERSON');
        }        

        function setPlaceHolder (value) {            
            if(value === 'PERSON') {       
                usernameElement.placeholder = "${msg('nationalCode')}/${msg('userName')}";
            }
            if(value === 'LEGAL') {    
                usernameElement.placeholder = "${msg('companyID')}/${msg('userName')}"; 
            }
        }
        kcLoginEl.addEventListener('click', (e) => {
            //const reg = new RegExp('^[0-9]+$');
            //const value = p2e(usernameElement.value);
            //if(!reg.test(value)) {
                //usernameElement.setCustomValidity('لطفا فقط مقادیر عددی وارد کنید')
            //}
            if(!usernameElement?.value) {
                usernameElement.setCustomValidity('${msg('pleaseEnterUsername')}');  
            }
        })
        
        usernameElement.oninput = function(e) {
            e.target.setCustomValidity("");
        };

    </script>

