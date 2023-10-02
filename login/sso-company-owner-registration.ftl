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
                                        <#if companyOwnerNationalCodeIsNotValid??>
                                            <span id="input-error" aria-live="polite">
                                                ${msg('companyOwnerNationalCodeIsNotValid')}
                                            </span>
                                        </#if>
                                        <div class="${properties.kcFormGroupClass!} form__group">
                                            <input tabindex="1" id="sso_plus_user_company_owner_national_code_input" class="${properties.kcInputClass!} form__input" name="sso_plus_user_company_owner_national_code" value="<#if sso_plus_user_company_owner_national_code??><#if sso_plus_user_company_owner_national_code[0]??>${msg(sso_plus_user_company_owner_national_code[0])}</#if></#if>" type="text" autofocus autocomplete="on"
                                                required title=""  placeholder="${msg('companyOwnerNationalCode')}"/>
                                                <#--  pattern="^[0-9]{10}$"  -->
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
        const usernameElement = document.getElementById('sso_plus_user_company_owner_national_code_input');
        const kcLoginEl = document.getElementById('kc-login');
        const p2e = s => s.replace(/[۰-۹]/g, d => '۰۱۲۳۴۵۶۷۸۹'.indexOf(d));
        kcLoginEl.addEventListener('click', (e) => {
            const reg = new RegExp('^[0-9]+$');
            const value = p2e(usernameElement.value);
            if(!reg.test(value)) {
                usernameElement.setCustomValidity('${msg('pleaseEnterNumeric')}')
            }
            if(!value) {
                usernameElement.setCustomValidity('${msg('pleaseEnterComponyOwnerCode')}');  
            }
        })
        
        usernameElement.oninput = function(e) {
                    e.target.setCustomValidity("");
        };

        
        

    </script>