<#import "template.ftl" as layout>
    <@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
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
                            <form id="kc-otp-login-form" class="${properties.kcFormClass!} form" action="${url.loginAction}">
                                <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                                <div class="book__form-section">
                                    <div class="book__form__title">
                                        <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                        <h2 id="system-title">${msg('auth_organization')}</h2>
                                    </div>
                                    <div class="form__group__login">
                                        <span class="form__group__login__text">${msg("doLogIn")}</span>
                                    </div>
                                    <#if otpLogin.userOtpCredentials?size gt 1>
                                        <div class="${properties.kcFormGroupClass!}">
                                            <div class="${properties.kcInputWrapperClass!}">
                                                <#list otpLogin.userOtpCredentials as otpCredential>
                                                    <div class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                                    <input type="hidden" value="${otpCredential.id}">
                                                        <div class="${properties.kcLoginOTPListItemHeaderClass!}">
                                                            <div class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                                            <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                                            </div>
                                                            <div class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</div>
                                                        </div>
                                                    </div>
                                                </#list>
                                            </div>
                                        </div>
                                    </#if>
                                    <div class="${properties.kcFormGroupClass!} form__group">
                                        <input tabindex="1" id="otp" name="otp" autocomplete="off" type="text" required placeholder="${msg('loginOtpOneTime')}" class="${properties.kcInputClass!} form__input" autofocus 
                                            aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" />
                                    </div>
                                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!} form__group form__group__btn">
                                        <input tabindex="2" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
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
                <#--  <form id="kc-otp-login-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
                    method="post">
                    <#if otpLogin.userOtpCredentials?size gt 1>
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcInputWrapperClass!}">
                                <#list otpLogin.userOtpCredentials as otpCredential>
                                    <div class="${properties.kcLoginOTPListClass!}" tabindex="${otpCredential?index}">
                                    <input type="hidden" value="${otpCredential.id}">
                                        <div class="${properties.kcLoginOTPListItemHeaderClass!}">
                                            <div class="${properties.kcLoginOTPListItemIconBodyClass!}">
                                              <i class="${properties.kcLoginOTPListItemIconClass!}" aria-hidden="true"></i>
                                            </div>
                                            <div class="${properties.kcLoginOTPListItemTitleClass!}">${otpCredential.userLabel}</div>
                                        </div>
                                    </div>
                                </#list>
                            </div>
                        </div>
                    </#if>

                <div class="${properties.kcFormGroupClass!}">
                        <div class="${properties.kcLabelWrapperClass!}">
                            <label for="otp" class="${properties.kcLabelClass!}">${msg("loginOtpOneTime")}</label>
                        </div>

                    <div class="${properties.kcInputWrapperClass!}">
                        <input id="otp" name="otp" autocomplete="off" type="text" class="${properties.kcInputClass!}"
                               autofocus aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"/>

                        <#if messagesPerField.existsError('totp')>
                            <span id="input-error-otp-code" class="${properties.kcInputErrorMessageClass!}"
                                  aria-live="polite">
                                ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                            </span>
                        </#if>
                    </div>
                </div>

                <div class="${properties.kcFormGroupClass!} form__group">
                    <input tabindex="1" id="otp" name="otp" autocomplete="off" type="text" required placeholder="${msg('loginOtpOneTime')}" class="${properties.kcInputClass!} form__input" autofocus 
                        aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>" />
                </div>

                    <div class="${properties.kcFormGroupClass!}">
                        <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                            <div class="${properties.kcFormOptionsWrapperClass!}">
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                            <input
                                class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                                name="login" id="kc-login" type="submit" value="${msg("doLogIn")}" />
                        </div>
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!} form__group form__group__btn">
                        <input tabindex="2" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn--green" name="login" id="kc-login" type="submit" value="${msg('doLogIn')}" />
                    </div>
                </form>  -->
            
            <script type="text/javascript">
            $(document).ready(function() {
                // Card Single Select
                $('.otp-tile').click(function() {
                  if ($(this).hasClass('pf-m-selected'))
                  { $(this).removeClass('pf-m-selected'); $(this).children().removeAttr('name'); }
                  else
                  { $('.otp-tile').removeClass('pf-m-selected');
                  $('.otp-tile').children().removeAttr('name');
                  $(this).addClass('pf-m-selected'); $(this).children().attr('name', 'selectedCredentialId'); }
                });

                var defaultCred = $('.otp-tile')[0];
                if (defaultCred) {
                    defaultCred.click();
                }
              });
            </script>
        </#if>
        </@layout.registrationLayout>