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
                                <form id="kc-form-login" class="form" onsubmit="login.disabled = true; DoSubmit();" action="${url.loginAction}" method="post">
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
                                        <#if inquiryServiceIdMatchingHasError??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('inquiryServiceIdMatchingHasError')}
                                            </span>
                                        </#if>
                                        <#if inquiryCivilRegistryHasError??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('inquiryCivilRegistryHasError')}
                                            </span>
                                        </#if>
                                        <#if inquiryPostalCodeHasError??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('inquiryPostalCodeHasError')}
                                            </span>
                                        </#if>                                        
                                        <#if userIsNotOwnerOfMobile??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('userIsNotOwnerOfMobile2')}
                                            </span>
                                        </#if>                                        
                                        <#if postalCodeIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('postalCodeIsNotValid')}
                                            </span>
                                        </#if>                                        
                                        <#if birthDateAndNationalCodeAreNotCorrect??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('birthDateAndNationalCodeAreNotCorrect')}
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">                                            
                                            <input tabindex="1" id="mobile_number_input" required title="" placeholder="${msg('mobileNumber')}" class="${properties.kcInputClass!} form__input" name="mobile_number" value="<#if mobile_number??><#if mobile_number[0]??>${msg(mobile_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                maxlength="11"/>
                                            <span class="locale-font-family" style="padding: .25rem .5rem 0 0">${msg('correctFormatOfMobileNumber')}: <span class="locale-choose"></span></span>
                                        </div>
                                        <#--  <div class="${properties.kcFormGroupClass!} form__group" style="position: relative">
                                            <input tabindex="2" data-jdp  required title="" placeholder="تاریخ تولد" type="text" id="sso_plus_user_birth_date_key_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_birth_date_key" value="<#if sso_plus_user_birth_date_key??><#if sso_plus_user_birth_date_key[0]??>${msg(sso_plus_user_birth_date_key[0])}</#if></#if>" readonly
                                                oninvalid="this.setCustomValidity('لطفا تاریخ تولد را وارد کنید')" oninput="setCustomValidity('')"/>
                                        </div>                                          -->
                                        <div class="${properties.kcFormGroupClass!} form__group" style="position: relative;">
                                            <input tabindex="2" required title="" placeholder="${msg('dateOfBirth')}" type="text" id="sso_plus_user_birth_date_key_input" class="${properties.kcInputClass!} form__input birth_date" name="sso_plus_user_birth_date_key" value="<#if sso_plus_user_birth_date_key??><#if sso_plus_user_birth_date_key[0]??>${msg(sso_plus_user_birth_date_key[0])}</#if></#if>" readonly
                                                />
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="3" id="sso_plus_user_postal_code_input" placeholder="${msg('postalCode')}" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_postal_code" value="<#if sso_plus_user_postal_code??><#if sso_plus_user_postal_code[0]??>${msg(sso_plus_user_postal_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                               maxlength="10"/>
                                        </div>                                        
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <#--  <input type="hidden" id="id-hidden-input" name="credentialId" />  -->
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

    <link type="text/css" rel="stylesheet" href="${url.resourcesPath}/datepicker-persian/persianDatepicker-default.css" />
    <script type="text/javascript" src="${url.resourcesPath}/datepicker-persian/persianDatepicker.min.js"></script>
    <script type="text/javascript">
        const phoneEl = document.getElementById('mobile_number_input');
        const postalCodeEl = document.getElementById('sso_plus_user_postal_code_input');
        const birthDateEl = document.getElementById('sso_plus_user_birth_date_key_input');
        const kcLoginEl = document.getElementById('kc-login');
        const correctFormatOfMobileNumberEl = document.querySelector('.locale-font-family');
        const mobileReg = new RegExp('^(\\+98|0)?9\\d{9}$');
        const postalCodeReg = new RegExp('^[0-9]{10}$');
        const p2e = s => s.replace(/[۰-۹]/g, d => '۰۱۲۳۴۵۶۷۸۹'.indexOf(d));
        if(locale === 'ltr') {
            birthDateEl.type='date';
            birthDateEl.readOnly = false;
        }
        if(locale === 'rtl') {
            $(function() {
                $("#sso_plus_user_birth_date_key_input").persianDatepicker();       
            });
        }
        console.log(locale);
        kcLoginEl.addEventListener('click', (e) => {
            const mobikeValue = p2e(phoneEl.value);
            const postalCodeValue = p2e(postalCodeEl.value);
            const birthDateValue = p2e(birthDateEl.value);
            if(!mobileReg.test(mobikeValue)) {
                phoneEl.setCustomValidity('${msg('pleaseEnterCorrectPhoneNumber')}');
            }
            if(!mobikeValue) {
                phoneEl.setCustomValidity('${msg('pleaseEnterPhoneNumber')}');  
            }
            if(!birthDateValue) {
                birthDateEl.setCustomValidity('${msg('pleaseEnterBirthDate')}');  
            }
            if(!postalCodeReg.test(postalCodeValue)) {
                postalCodeEl.setCustomValidity('${msg('pleaseEnterCorrectPostalCode')}')
            }
            if(!postalCodeValue) {
                postalCodeEl.setCustomValidity('${msg('pleaseEnterPostalCode')}');  
            }
        });
        phoneEl.oninput = function(e) {
            e.target.setCustomValidity("");
        };
        postalCodeEl.oninput = function(e) {
            e.target.setCustomValidity("");
        };
        birthDateEl.oninput = function(e) {
            e.target.setCustomValidity("");
        };
        if(correctFormatOfMobileNumberEl.querySelector('.ltr')) {
            correctFormatOfMobileNumberEl.querySelector('.ltr').innerText = '0912 *** ****';
        }
        if(correctFormatOfMobileNumberEl.querySelector('.rtl')) {
            correctFormatOfMobileNumberEl.querySelector('.rtl').innerText = '**** *** 0912';
        }
    </script>
