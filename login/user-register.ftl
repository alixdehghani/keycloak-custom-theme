<#import "template.ftl" as layout>
    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
        <#if section="header">
            <#elseif section="form">            
                <div id="kc-form" class="section-book">
                    <div id="kc-form-wrapper" class="row">
                        <div class="book">
                            <div class="book__form">
                                <#if realm.internationalizationEnabled && locale.supported?size gt 1>
                                    <#--  <div id="kc-locale">
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
                                    </div>  -->
                                </#if>
                                <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">
                                    <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                                    <div class="book__form-section">
                                        <div class="book__form__title">
                                            <h2 id="first-level-system-title">${msg('mainTitle')}</h2>
                                            <h2 id="system-title">${msg('organization')}</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <#--  <span class="form__group__login__text">${msg('login')} / ${msg('register')}</span>  -->
                                        </div>
                                        <#if messagesPerField.existsError('username','password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if requiredValueIsBlank??>
                                            <span id="input-error" aria-live="polite">
                                                همه ی مقادیر اجباری را کامل کنید
                                            </span>
                                        </#if>
                                        <#if phoneIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                شماره تلفن اشتباه است
                                            </span>
                                        </#if>
                                        <#if nationalCodeIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                کد ملی اشتباه است
                                            </span>
                                        </#if>
                                        <#if emailIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                فرمت آدرس ایمیل اشتباه است
                                            </span>
                                        </#if>
                                        <#if unknownUserType??>
                                            <span id="input-error" aria-live="polite">
                                                نوع کاربری اشتباه است
                                            </span>
                                        </#if>
                                        <#if userIsExist??>
                                            <span id="input-error" aria-live="polite">
                                                 کاربر وارد شده موجود است
                                            </span>
                                        </#if>                                        
                                        <#if passwordIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                 کلمه عبور را وارد کنید
                                            </span>
                                        </#if>
                                        <#if (captchaIsNotValid??)>
                                            <span id="input-error" aria-live="polite">
                                                کد امنیتی اشتباه است
                                            </span>
                                        </#if>
                                        <div class="form__group form__section" >
                                            <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="sso_plus_user_type_input">نوع کاربر*</label><br>
                                                <select name="sso_plus_user_type" id="sso_plus_user_type_input" class="form__input" tabindex="1">
                                                    <option value="PERSON" <#if sso_plus_user_type??><#if msg(sso_plus_user_type[0]) == 'PERSON'>selected</#if></#if>>حقیقی</option>
                                                    <option value="LEGAL" <#if sso_plus_user_type??><#if msg(sso_plus_user_type[0]) == 'LEGAL'>selected</#if></#if>>حقوقی</option>
                                                </select>
                                            </div>
                                            <div id="dynamic-form-section"></div>  
                                            <input type="hidden" id="id-hidden-input" name="locale" value="fa" />
                                          
                                        </div>
                                        <div class="form__group form__section__footer" >
                                            <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                                <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" type="submit" value="${msg("doRegister")}"/>
                                            </div>
                                            <#--  <div class="form__group__external-link">                                            
                                                <a class="block" href="#" disabled>&#xf10b; ویرایش شماره تلفن همراه</a>
                                            </div>   -->
                                            <div id="kc-username" class="${properties.kcFormGroupClass!} form__group__external-link">
                                                    <#--  <label id="kc-attempted-username">${auth.attemptedUsername}</label>  -->
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
                                    <div class="copyright">
                                        <p>${msg('footerText')}</p>
                                        <#--  <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>  -->
                                    </div>
                                </form>
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

    <link type="text/css" rel="stylesheet" href="${url.resourcesPath}/jalalidatepicker/jalalidatepicker.min.css" />
    <script type="text/javascript" src="${url.resourcesPath}/jalalidatepicker/jalalidatepicker.min.js"></script>
    <script type="text/javascript">
        jalaliDatepicker.startWatch();
        const dynamicFormElement = document.getElementById('dynamic-form-section');
        const PERSON_ELEMENTS = () => create(`<div class="custom-row">
                                                <input tabindex="2" id="username_input" type="hidden" title="" class="${properties.kcInputClass!} form__input" name="username" value="<#if username??>${msg(username[0])}</#if>"/>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="firstname_input">نام*</label><br>
                                                    <input tabindex="3" id="firstname_input" required title="" class="${properties.kcInputClass!} form__input" name="firstname" value="<#if firstname??>${msg(firstname[0])}</#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="lastname_input">نام خانوادگی*</label><br>
                                                    <input tabindex="4" id="lastname_input" required title="" class="${properties.kcInputClass!} form__input" name="lastname" value="<#if lastname??><#if lastname[0]??>${msg(lastname[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_national_code_key_input">کدملی*</label><br>
                                                    <input tabindex="5" id="sso_plus_user_national_code_key_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_national_code_key" value="<#if sso_plus_user_national_code_key??><#if sso_plus_user_national_code_key[0]??>${msg(sso_plus_user_national_code_key[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                required title="" pattern="^[0-9]{10}$" oninvalid="this.setCustomValidity('کد ملی اشتباه است')" oninput="setCustomValidity('')"/>
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item" style="position: relative">
                                                    <label class="form__label" for="sso_plus_user_birth_date_key_input">تاریخ تولد*</label><br>
                                                    <input tabindex="6" data-jdp data-jdp-max-date="today" required title="" type="text" id="sso_plus_user_birth_date_key_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_birth_date_key" value="<#if sso_plus_user_birth_date_key??><#if sso_plus_user_birth_date_key[0]??>${msg(sso_plus_user_birth_date_key[0])}</#if></#if>" readonly />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="mobile_number_input">شماره همراه*</label><br>
                                                    <input tabindex="7" id="mobile_number_input" required title="" placeholder="09121234567" class="${properties.kcInputClass!} form__input" name="mobile_number" value="<#if mobile_number??><#if mobile_number[0]??>${msg(mobile_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_phone_number_input">تلفن ثابت*</label><br>
                                                    <input tabindex="8" id="sso_plus_user_phone_number_input" required title="" placeholder="0212345678" class="${properties.kcInputClass!} form__input" name="sso_plus_user_phone_number" value="<#if sso_plus_user_phone_number??><#if sso_plus_user_phone_number[0]??>${msg(sso_plus_user_phone_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="email_input">پست الکترونیک*</label><br>
                                                    <input tabindex="9" id="email_input" required title="" class="${properties.kcInputClass!} form__input" placeholder="abcd@email.com" name="email" value="<#if email??><#if email[0]??>${msg(email[0])}</#if></#if>" type="email" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_gender_key_input">جنسیت*</label><br>
                                                    <select tabindex="10" name="sso_plus_user_gender_key" required title="" class="form__input" id="sso_plus_user_gender_key_input">
                                                        <option value="" disabled selected></option>
                                                        <option value="true" <#if sso_plus_user_gender_key??><#if sso_plus_user_gender_key[0]??><#if msg(sso_plus_user_gender_key[0]) == 'true'>selected</#if></#if></#if>>مرد</option>
                                                        <option value="false" <#if sso_plus_user_gender_key??><#if sso_plus_user_gender_key[0]??><#if msg(sso_plus_user_gender_key[0]) == 'false'>selected</#if></#if></#if>>زن</option>
                                                    </select>
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_postal_code_input">کد پستی*</label><br>
                                                    <input tabindex="11" id="sso_plus_user_postal_code_input" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_postal_code" value="<#if sso_plus_user_postal_code??><#if sso_plus_user_postal_code[0]??>${msg(sso_plus_user_postal_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="password_input">کلمه عبور*</label><br>
                                                    <input tabindex="12" id="password_input" required title="" class="${properties.kcInputClass!} form__input" name="password" value="" type="password" autofocus
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item" style="position: relative;">
                                                <label class="form__label" for="captcha_input">کد امنیتی*</label><br>
                                                <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                                <input tabindex="13" id="captcha_input"
                                                    required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                    oninvalid="this.setCustomValidity('لطفا مقادیر داخل عکس را وارد کنید')" oninput="setCustomValidity('')" />
                                                <img src="data:image/png;charset=utf-8;base64,${captchaImage}" class="form__captcha"/>
                                            </div>
                                            </div>`);
        const LEGAL_ELEMENTS = () => create(`<div class="custom-row">
                                                <input tabindex="2" id="username_input" type="hidden" title="" class="${properties.kcInputClass!} form__input" name="username" value="<#if username??>${msg(username[0])}</#if>"/>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="firstname_input">نام شرکت*</label><br>
                                                    <input tabindex="3" id="firstname_input" required title="" class="${properties.kcInputClass!} form__input" name="firstname" value="<#if firstname??>${msg(firstname[0])}</#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="sso_plus_user_economic_id_input">شناسه اقتصادی*</label><br>
                                                    <input tabindex="4" id="sso_plus_user_economic_id_input" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_economic_id" value="<#if sso_plus_user_economic_id??><#if sso_plus_user_economic_id[0]??>${msg(sso_plus_user_economic_id[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>                                                
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_national_code_key_input">شناسه ملی*</label><br>
                                                    <input tabindex="5" id="sso_plus_user_national_code_key_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_national_code_key" value="<#if sso_plus_user_national_code_key??><#if sso_plus_user_national_code_key[0]??>${msg(sso_plus_user_national_code_key[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                required title="" pattern="^[0-9]{10}$" oninvalid="this.setCustomValidity('کد ملی اشتباه است')" oninput="setCustomValidity('')"/>
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                <label class="form__label" for="sso_plus_user_economic_code_input">کد اقتصادی*</label><br>
                                                    <input tabindex="6" id="sso_plus_user_economic_code_input" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_economic_code" value="<#if sso_plus_user_economic_code??><#if sso_plus_user_economic_code[0]??>${msg(sso_plus_user_economic_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="mobile_number_input">شماره همراه*</label><br>
                                                    <input tabindex="7" id="mobile_number_input" required title="" placeholder="09121234567" class="${properties.kcInputClass!} form__input" name="mobile_number" value="<#if mobile_number??><#if mobile_number[0]??>${msg(mobile_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_phone_number_input">تلفن ثابت*</label><br>
                                                    <input tabindex="7" id="sso_plus_user_phone_number_input" required title="" placeholder="0212345678" class="${properties.kcInputClass!} form__input" name="sso_plus_user_phone_number" value="<#if sso_plus_user_phone_number??><#if sso_plus_user_phone_number[0]??>${msg(sso_plus_user_phone_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="email_input">پست الکترونیک*</label><br>
                                                    <input tabindex="8" id="email_input" required title="" class="${properties.kcInputClass!} form__input" placeholder="abcd@email.com" name="email" value="<#if email??><#if email[0]??>${msg(email[0])}</#if></#if>" type="email" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="sso_plus_user_postal_code_input">کد پستی*</label><br>
                                                    <input tabindex="9" id="sso_plus_user_postal_code_input" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_postal_code" value="<#if sso_plus_user_postal_code??><#if sso_plus_user_postal_code[0]??>${msg(sso_plus_user_postal_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!} form__section__item">
                                                    <label class="form__label" for="password_input">کلمه عبور*</label><br>
                                                    <input tabindex="10" id="password_input" required title="" class="${properties.kcInputClass!} form__input" name="password" value="" type="password" autofocus
                                                                />
                                                </div>
                                                <div class="${properties.kcFormGroupClass!}form__section__item" style="position: relative;">
                                                <label class="form__label" for="captcha_input">کد امنیتی*</label><br>
                                                <input type="hidden" id="id-hidden-input" name="captchaId" value="${captchaId}" />
                                                <input tabindex="11" id="captcha_input"
                                                    required class="${properties.kcInputClass!} form__input" name="userCaptchaValue" type="text" autocomplete="off"
                                                    oninvalid="this.setCustomValidity('لطفا مقادیر داخل عکس را وارد کنید')" oninput="setCustomValidity('')" />
                                                <img src="data:image/png;charset=utf-8;base64,${captchaImage}" class="form__captcha"/>
                                            </div>
                                            </div>`);
        const mySelect = document.getElementById('sso_plus_user_type_input');
        let usernameInput = document.getElementById('username_input');
        let nationalCodeInputElement = document.getElementById('sso_plus_user_national_code_key_input');
        mySelect.onchange = (event) => {
            const inputText = event.target.value;
            const removedNode = document.querySelector('.custom-row');
            if(removedNode) {
                removedNode.parentNode.removeChild(removedNode);
            }
            if(inputText === 'PERSON') {       
                addDynamicForm('PERSON');
            }
            if(inputText === 'LEGAL') {     
                addDynamicForm('LEGAL');
            }
        }

        function create(htmlStr) {
            const frag = document.createDocumentFragment(),
                temp = document.createElement('div');
            temp.innerHTML = htmlStr;
            while (temp.firstChild) {
                frag.appendChild(temp.firstChild);
            }
            return frag;
        }

        function addDynamicForm(name) {
            if(nationalCodeInputElement?.removeEventListener) {
                nationalCodeInputElement.removeEventListener('input', copyValue);
            }
            if(name === 'PERSON') {                
                dynamicFormElement.parentNode.appendChild(PERSON_ELEMENTS(),dynamicFormElement);
            }
            if(name === 'LEGAL') {
                dynamicFormElement.parentNode.appendChild(LEGAL_ELEMENTS(),dynamicFormElement);
            }
            usernameInput = document.getElementById('username_input');
            nationalCodeInputElement = document.getElementById('sso_plus_user_national_code_key_input');            
            nationalCodeInputElement.addEventListener('input', copyValue);
        }
        const selectValue = mySelect.value;
        if(selectValue) {
            if(selectValue === 'PERSON') {       
                addDynamicForm('PERSON');              
            }
            if(selectValue === 'LEGAL') {     
                addDynamicForm('LEGAL');
            } 
        } else {     
            addDynamicForm('PERSON');
        }
        function copyValue (evt) {
                usernameInput.value = evt.target.value;
        }
</script>