<#import "template.ftl" as layout>
<@layout.registrationLayout displayRequiredFields=false displayMessage=!messagesPerField.existsError('totp','userLabel'); section>

    <#if section = "header">
        
    <#elseif section = "form">
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
                        <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" class="form" method="post">
                            <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                            <div class="book__form-section">
                                <div class="book__form__title">
                                    <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                    <h2 id="system-title">${msg('auth_organization')}</h2>
                                </div>
                                <div class="form__group__login">
                                    <span class="form__group__login__text">${msg("loginTotpTitle")}</span>
                                </div>

                                <ol id="kc-totp-settings">
                                    <li>
                                        <p>${msg("loginTotpStep1")}</p>

                                        <ul id="kc-totp-supported-apps">
                                            <#list totp.policy.supportedApplications as app>
                                                <li>${app}</li>
                                            </#list>
                                        </ul>
                                    </li>

                                    <#if mode?? && mode = "manual">
                                        <li>
                                            <p>${msg("loginTotpManualStep2")}</p>
                                            <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                                            <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                                        </li>
                                        <li>
                                            <p>${msg("loginTotpManualStep3")}</p>
                                            <p>
                                            <ul>
                                                <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                                                <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                                                <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                                                <#if totp.policy.type = "totp">
                                                    <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                                                <#elseif totp.policy.type = "hotp">
                                                    <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                                                </#if>
                                            </ul>
                                            </p>
                                        </li>
                                    <#else>
                                        <li>
                                            <p>${msg("loginTotpStep2")}</p>
                                            <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                                            <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                                        </li>
                                    </#if>
                                    <li>
                                        <p>${msg("loginTotpStep3")}</p>
                                        <p>${msg("loginTotpStep3DeviceName")}</p>
                                    </li>
                                </ol>
                                <div class="${properties.kcFormGroupClass!} form__group">
                                    <input tabindex="0" type="text" id="totp" name="totp" autocomplete="off" required placeholder="${msg('authenticatorCode')}" class="${properties.kcInputClass!} form__input" autofocus 
                                        aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" />
                                    <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                                    <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
                                </div>
                                <div class="${properties.kcFormGroupClass!} form__group">
                                    <input tabindex="2" type="text" id="userLabel" name="userLabel" autocomplete="off" required placeholder="${msg('loginTotpDeviceName')}" class="${properties.kcInputClass!} form__input" autofocus 
                                        aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>" />
                                </div>
                                <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} form__group form__group__btn">
                                    <input tabindex="3" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" id="saveTOTPBtn" type="submit" value="${msg('doSubmit')}" />
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

        <#--  <form action="${url.loginAction}" class="${properties.kcFormClass!}" id="kc-totp-settings-form" method="post">
            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="totp" class="control-label">${msg("authenticatorCode")}</label> <span class="required">*</span>
                </div>
                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" id="totp" name="totp" autocomplete="off" class="${properties.kcInputClass!}"
                           aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                    />

                    <#if messagesPerField.existsError('totp')>
                        <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                        </span>
                    </#if>

                </div>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>

            <div class="${properties.kcFormGroupClass!}">
                <div class="${properties.kcInputWrapperClass!}">
                    <label for="userLabel" class="control-label">${msg("loginTotpDeviceName")}</label> <#if totp.otpCredentials?size gte 1><span class="required">*</span></#if>
                </div>

                <div class="${properties.kcInputWrapperClass!}">
                    <input type="text" class="${properties.kcInputClass!}" id="userLabel" name="userLabel" autocomplete="off"
                           aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                    />

                    <#if messagesPerField.existsError('userLabel')>
                        <span id="input-error-otp-label" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                            ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                        </span>
                    </#if>
                </div>
            </div>

            <#if isAppInitiatedAction??>
                <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
                <button type="submit"
                        class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} ${properties.kcButtonLargeClass!}"
                        id="cancelTOTPBtn" name="cancel-aia" value="true" />${msg("doCancel")}
                </button>
            <#else>
                <input type="submit"
                       class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                       id="saveTOTPBtn" value="${msg("doSubmit")}"
                />
            </#if>
        </form>  -->
    </#if>
</@layout.registrationLayout>