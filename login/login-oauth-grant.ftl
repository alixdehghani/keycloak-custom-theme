<#import "template.ftl" as layout>
<@layout.registrationLayout bodyClass="oauth"; section>
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
                                                <li class="kc-dropdown-item"><a href="${l.url?replace('protocol/openid-connect/auth','login-actions/authenticate')}">${l.label}</a></li>
                                            </#list>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </#if>
                        <form id="kc-form-login" class="form-actions" method="POST">
                            <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                            <div class="book__form-section">
                                <div class="book__form__title">
                                    <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                    <h2 id="system-title">${msg('auth_organization')}</h2>
                                </div>
                                <div class="form__group__login">
                                    <span class="form__group__login__text">
                                        <#if client.name?has_content>
                                            ${msg("oauthGrantTitle",advancedMsg(client.name))}
                                        <#else>
                                            ${msg("oauthGrantTitle",client.clientId)}
                                        </#if>
                                    </span>
                                </div>
                                <input type="hidden" name="code" value="${oauth.code}">
                                <div class="form__group form__group__btn">
                                    <h3>${msg("oauthGrantRequest")}</h3>
                                    <ul style="padding: 2rem">
                                        <#if oauth.clientScopesRequested??>
                                            <#list oauth.clientScopesRequested as clientScope>
                                                <li>
                                                    <h2>${advancedMsg(clientScope.consentScreenText)}</h2>
                                                </li>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                                <div class="${properties.kcFormGroupClass!}">
                                    <div id="kc-form-options">
                                        <div class="${properties.kcFormOptionsWrapperClass!}">
                                        </div>
                                    </div>

                                    <div id="kc-form-buttons" class="form__group form__group__btn" style="display: flex;justify-content: space-between;">
                                        <#--  <div class="${properties.kcFormButtonsWrapperClass!}">  -->
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonLargeClass!} btn btn--green" style="width: 45%;" name="accept" id="kc-login" type="submit" value="${msg("doYes")}"/>
                                            <input class="${properties.kcButtonClass!} ${properties.kcButtonDefaultClass!} ${properties.kcButtonLargeClass!} btn " name="cancel" style="width: 45%;" id="kc-cancel" type="submit" value="${msg("doNo")}"/>
                                        <#--  </div>  -->
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="clearfix"></div>
                        <div class="book__form-image locale-choose">
                            <div class="book__form-image-logo"><img src="${url.resourcesPath}/img/logo.png"></div>
                            <div class="book__form-image-text">
                                <p id="copyright">${msg('auth_footerText')}</p>
                                <#--  <p>سامانه اس اس او پلاس به شماره 206911 نزد سازمان فناوری اطلاعات ثبت شده است</p>  -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
