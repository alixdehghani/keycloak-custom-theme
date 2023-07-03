<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
    <#--  <#elseif section = "form">
        <p id="instruction1" class="instruction">
            ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
            ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}">${msg("doClickHere")}</a> .
        </p>
    </#if>  -->

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
                                    <h2>سامانه احرازهویت یکپارچه</h2>
                                    <h2>وزارت کار، تعاون و رفاه اجتماعی</h2>
                                </div>
                                <div class="form__group__login">
                                    <span class="form__group__login__text"></span>
                                </div>
                                <#--  <p id="instruction1 input-error" class="instruction">
                                    ${msg("pageExpiredMsg1")} <a id="loginRestartLink" href="${url.loginRestartFlowUrl}">${msg("doClickHere")}</a> .<br/>
                                    ${msg("pageExpiredMsg2")} <a id="loginContinueLink" href="${url.loginAction}">${msg("doClickHere")}</a> .
                                </p>  -->
                                <div class="form__group__external-link">                                             
                                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                                            <#--  <label id="kc-attempted-username">${auth.attemptedUsername}</label>  -->
                                                <a id="reset-login" class="btn main-color center" href="${url.loginRestartFlowUrl}">
                                            
                                                <div class="kc-login-tooltip">
                                                    <#--  <i class="${properties.kcResetFlowIcon!}"></i>  -->
                                                    <i class="fa-repeat"></i>
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
                                <p>این سامانه توسط مرکز فناوری اطلاعات و توسعه داده شده است</p>
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
