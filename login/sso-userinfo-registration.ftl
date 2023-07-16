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
                                            <h2>سامانه احرازهویت یکپارچه</h2>
                                            <h2>وزارت کار، تعاون و رفاه اجتماعی</h2>
                                        </div>
                                        <div class="form__group__login">
                                            <span class="form__group__login__text">ورود / ثبت نام</span>
                                        </div>
                                        <#if messagesPerField.existsError('password')>
                                            <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                                ${kcSanitize(messagesPerField.getFirstError('password'))?no_esc}
                                            </span>
                                        </#if>
                                        <#if invalidPasswordMessage??>
                                            <span id="input-error" aria-live="polite">
                                                نام کاربری یافت نشد
                                            </span>
                                        </#if>
                                        <#if inquiryServiceIdMatchingHasError??>
                                            <span id="input-error" aria-live="polite">
                                                پاسخی از سرویس استعلام مالکیت شماره تلفن همراه دریافت نشد
                                            </span>
                                        </#if>
                                        <#if inquiryCivilRegistryHasError??>
                                            <span id="input-error" aria-live="polite">
                                                پاسخی از سرویس استعلام ثبت احوال دریافت نشد
                                            </span>
                                        </#if>
                                        <#if inquiryPostalCodeHasError??>
                                            <span id="input-error" aria-live="polite">
                                                پاسخی از سرویس استعلام کدپستی دریافت نشد
                                            </span>
                                        </#if>                                        
                                        <#if userIsNotOwnerOfMobile??>
                                            <span id="input-error" aria-live="polite">
                                                شماره موبایل وارد شده متعلق به این کد ملی نیست
                                            </span>
                                        </#if>                                        
                                        <#if postalCodeIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                کد پستی وارد شده اشتباه است
                                            </span>
                                        </#if>                                        
                                        <#if birthDateAndNationalCodeAreNotCorrect??>
                                            <span id="input-error" aria-live="polite">
                                                تاریخ تولد وارد شده برای این کد ملی صحیح نمی باشد
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">                                            
                                            <input tabindex="1" id="mobile_number_input" required title="" placeholder="شماره همراه" class="${properties.kcInputClass!} form__input" name="mobile_number" value="<#if mobile_number??><#if mobile_number[0]??>${msg(mobile_number[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                oninvalid="this.setCustomValidity('لطفا شماره همراه را وارد کنید')" oninput="setCustomValidity('')"/>
                                        </div>
                                        <#--  <div class="${properties.kcFormGroupClass!} form__group" style="position: relative">
                                            <input tabindex="2" data-jdp  required title="" placeholder="تاریخ تولد" type="text" id="sso_plus_user_birth_date_key_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_birth_date_key" value="<#if sso_plus_user_birth_date_key??><#if sso_plus_user_birth_date_key[0]??>${msg(sso_plus_user_birth_date_key[0])}</#if></#if>" readonly
                                                oninvalid="this.setCustomValidity('لطفا تاریخ تولد را وارد کنید')" oninput="setCustomValidity('')"/>
                                        </div>                                          -->
                                        <div class="${properties.kcFormGroupClass!} form__group" style="position: relative;">
                                            <input tabindex="2" required title="" placeholder="تاریخ تولد" type="text" id="sso_plus_user_birth_date_key_input" class="${properties.kcInputClass!} form__input birth_date" name="sso_plus_user_birth_date_key" value="<#if sso_plus_user_birth_date_key??><#if sso_plus_user_birth_date_key[0]??>${msg(sso_plus_user_birth_date_key[0])}</#if></#if>" readonly
                                                oninvalid="this.setCustomValidity('لطفا تاریخ تولد را وارد کنید')" oninput="setCustomValidity('')"/>
                                        </div>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="3" id="sso_plus_user_postal_code_input" placeholder="کد پستی" required title="" class="${properties.kcInputClass!} form__input" name="sso_plus_user_postal_code" value="<#if sso_plus_user_postal_code??><#if sso_plus_user_postal_code[0]??>${msg(sso_plus_user_postal_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                pattern="^[0-9]{10}$" oninvalid="this.setCustomValidity('لطفا کد پستی را وارد کنید')" oninput="setCustomValidity('')"/>
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

    <#--  <link type="text/css" rel="stylesheet" href="${url.resourcesPath}/jalalidatepicker/jalalidatepicker.min.css" />
    <script type="text/javascript" src="${url.resourcesPath}/jalalidatepicker/jalalidatepicker.min.js"></script>
    <script type="text/javascript">
        jalaliDatepicker.startWatch();
    </script>  -->

<script src="${url.resourcesPath}/jquery/jquery-3.7.0.min.js"></script>

<#--  <link rel="stylesheet" href="${url.resourcesPath}/jdpv2/persian-datepicker.min.css"/>
<script src="${url.resourcesPath}/jdpv2/persian-date.min.js"></script>
<script src="${url.resourcesPath}/jdpv2/persian-datepicker.min.js"></script>
<script type="text/javascript">
    const birthEl = document.getElementById('sso_plus_user_birth_date_key_input');
    const p2e = s => s.replace(/[۰-۹]/g, d => '۰۱۲۳۴۵۶۷۸۹'.indexOf(d));
    const e2p = s => s.replace(/\d/g, d => '۰۱۲۳۴۵۶۷۸۹'[d]);
    console.log(birthEl.value)
    //birthEl.value = e2p(birthEl.value);
    birthEl.value = replaceAll(birthEl.value, '/', '-');
    console.log(birthEl.value);
    if(birthEl.value) {
        $(document).ready(function() {
            $("#sso_plus_user_birth_date_key_input").pDatepicker({
                initialValue: true,
                initialValueType: 'persion',            
                format: 'L',
                autoClose: true,
                responsive: false,
                toolbox: {
                    calendarSwitch: false
                }
            });
        });
    } else {
        $(document).ready(function() {
            $("#sso_plus_user_birth_date_key_input").pDatepicker({
                initialValue: false,           
                format: 'L',
                autoClose: true,
                responsive: false,
                toolbox: {
                    calendarSwitch: false
                }
            });
        });
    }
    
    function DoSubmit(){        
        birthEl.value = p2e(birthEl.value);
        return true;
    }
    function replaceAll(str, find, replace) {
        return str.replace(new RegExp(find, 'g'), replace);
    }
    
</script>  -->



<#--  <link rel="stylesheet" href="${url.resourcesPath}/kamanddp/kamadatepicker.min.css">
<script src="${url.resourcesPath}/kamanddp/kamadatepicker.min.js"></script>

<script type="text/javascript">
    kamaDatepicker('sso_plus_user_birth_date_key_input', {
        markToday: true,
        markHolidays: true,
        highlightSelectedDay: true,
	    sync: true,	
	    gotoToday: true,
        forceFarsiDigits: true,
        swapNextPrev: true
    });
</script>  -->



<link type="text/css" rel="stylesheet" href="${url.resourcesPath}/datepicker-persian/persianDatepicker-default.css" />
<script type="text/javascript" src="${url.resourcesPath}/datepicker-persian/persianDatepicker.min.js"></script>
<script type="text/javascript">
    $(function() {
        $("#sso_plus_user_birth_date_key_input").persianDatepicker();       
    });
</script>
