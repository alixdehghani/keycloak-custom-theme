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
                                                        <#--  <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>  -->
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
                                        <#if inquiryCompanyInfoHasError??>
                                            <span id="input-error" aria-live="polite">
                                                پاسخی از سرویس استعلام شرکت ها دریافت نشد
                                            </span>
                                        </#if>
                                        <#if nationalCodeIsNotValid??>
                                            <#if sso_plus_user_type??>
                                                <#if sso_plus_user_type[0]??>
                                                    <#if msg(sso_plus_user_type[0]) == 'PERSON'>
                                                        <span id="input-error" aria-live="polite">
                                                         کد ملی وارد شده اشتباه است
                                                        </span>
                                                    </#if>
                                                    <#if msg(sso_plus_user_type[0]) == 'LEGAL'>
                                                        <span id="input-error" aria-live="polite">
                                                         شناسه شرکت وارد شده اشتباه است
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
                                                    <span class="padding-5-vertical">نوع کاربر: </span>
                                                    <input type="radio" id="person" class="padding-5-vertical" name="sso_plus_user_type" onclick="setPlaceHolder('PERSON')" value="PERSON">
                                                    <label for="person" class="padding-5-vertical">حقیقی</label>
                                                    <input type="radio" id="legal" class="padding-5-vertical" name="sso_plus_user_type" onclick="setPlaceHolder('LEGAL')" value="LEGAL">
                                                    <label for="legal" class="padding-5-vertical">حقوقی</label>
                                                </div>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <#if usernameEditDisabled??>
                                                <input tabindex="2" id="username" class="${properties.kcInputClass!} form__input" name="username" value="${(login.username!'')}" type="text" disabled />
                                                <#else>
                                                    <input tabindex="2" required id="username" class="${properties.kcInputClass!} form__input" name="username" value="<#if username??><#if username[0]??>${msg(username[0])}</#if></#if>" type="text" autofocus autocomplete="off"
                                                        aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" oninvalid="this.setCustomValidity('لطفا نام کاربری را وارد کنید')" oninput="setCustomValidity('')"/>
                                            </#if>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="3" id="captcha" placeholder="کد امنیتی"
                                                required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                oninvalid="this.setCustomValidity('لطفا مقادیر داخل عکس را وارد کنید')" oninput="setCustomValidity('')" />
                                            <img src="data:image/png;charset=utf-8;base64,${captchaImage}" class="form__captcha"/>
                                        </div>
                                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                            <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                            <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                                        </div>
                                        <div class="form__group__external-link">
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
                                            <a class="block center-aling no-padding" href="#" disabled><i class="padding-5-all fa fa-mobile font-size-large margin-left-5px"></i><span>تغییر شماره تلفن همراه</span></a>
                                        </div>
                                    </div>
                                </form>
                                <div class="book__form-image">
                                    <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                                    <div class="book__form-image-text">
                                        <p>این سامانه توسط مرکز فناوری اطلاعات و ارتباطات وزارت تعاون، کار و رفاه اجتماعی توسعه داده شده است</p>
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


    <script type="text/javascript">
        const usernameElement = document.getElementById('username');
        const ssoPlusUserTypeEl = document.getElementById('sso_plus_user_type');
        const legalElement = document.getElementById('legal');
        const personElement = document.getElementById('person');
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
                usernameElement.placeholder = "کدملی";
            }
            if(value === 'LEGAL') {    
                usernameElement.placeholder = "شناسه شرکت"; 
            }
        }
    </script>
