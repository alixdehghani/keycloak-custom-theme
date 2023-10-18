<#import "template.ftl" as layout>
    <@layout.registrationLayout displayMessage=false; section>
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
                                <form id="kc-form-login" class="form">
                                    <img class="book__form-title-logo" src="${url.resourcesPath}/img/fingerprint.png">
                                    <div class="book__form-section">
                                        <div class="book__form__title">
                                            <h2 id="first-level-system-title">${msg('auth_mainTitle')}</h2>
                                            <h2 id="system-title">${msg('auth_organization')}</h2>
                                        </div>
                                        <span id="input-error" aria-live="polite">
                                                ${msg('errorMessage')}
                                        </span>
                                        <div id="kc-error-message">
                                             <p  class="instruction">${message.summary?no_esc}</p>
                                        </div>   
                                       <div class="form__group__external-link center-aling" style="margin: 115px auto 25px auto">                                            
                                                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                                    <#if client?? && client.baseUrl?has_content>
                                                        <a id="reset-login" class="no-padd-marg" href="${url.loginRestartFlowUrl}">
                                                            <div class="kc-login-tooltip center">
                                                                <i class="fa-repeat padding-25 margin-left-5px"></i>
                                                                <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                                            </div>
                                                        </a>
                                                    <#else>
                                                    <a id="reset-login" href="/">
                                                        <div class="kc-login-tooltip center">
                                                            <i class="fa-repeat padding-25 margin-left-5px"></i>
                                                            <span class="kc-tooltip-text">
                                                                ${msg("auth_backToApp")}
                                                            </span>
                                                        </div>
                                                    </a>
                                                    </#if>
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