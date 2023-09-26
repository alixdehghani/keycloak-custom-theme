const code = document.getElementById("password");
const display = document.getElementsByClassName("textbox")[0];
const passwordIsExistInPastEl = document.getElementById('password-is-exist-in-past');
let passwordPolicyHints = [];

const minLengthPolicy = () => passwordPolicyHints.find(item => item.name === 'MINIMUM_LENGTH');
const lowerCasePolicy = () => passwordPolicyHints.find(item => item.name === 'LOWERCASE_CHARACTERS');
const upperCasePolicy = () => passwordPolicyHints.find(item => item.name === 'UPPERCASE_CHARACTERS');
const specialCharacterPolicy = () => passwordPolicyHints.find(item => item.name === 'SPECIAL_CHARACTERS');
const digitsPolicy = () => passwordPolicyHints.find(item => item.name === 'DIGITS');

code.addEventListener("keyup", function () {
    checkpassword(code.value);
});

function checkpassword(password) {
    if (passwordPolicyHints.length === 0) {
        return;
    }
    if (minLengthPolicy()) {
        if (minLengthPolicy().status && password.length < minLengthPolicy().value) {
            display.innerHTML = `${msgFromPolicy(minLengthPolicy())}`;
            return;
        }
    }
    let errorText = [];
    let matchString = '';
    
    if (lowerCasePolicy()) {
        if (lowerCasePolicy().status) {
            matchString = `(?=(.*[a-z]){${lowerCasePolicy().value},})`;
            if (!password.match(matchString)) {
                errorText.push(`${msgFromPolicy(lowerCasePolicy())}`);
            }
        }
        matchString = '';
    }

    if (upperCasePolicy()) {
        if (upperCasePolicy().status) {
            matchString = `(?=(.*[A-Z]){${upperCasePolicy().value},})`;
            if (!password.match(matchString)) {
                errorText.push(`${msgFromPolicy(upperCasePolicy())}`);
            }
        }
        matchString = '';
    }

    if (digitsPolicy()) {
        if (digitsPolicy().status) {
            matchString = `^(?=(.*\\d){${digitsPolicy().value}})`;
            if (!password.match(matchString)) {
                errorText.push(`${msgFromPolicy(digitsPolicy())}`);
            }
        }
        matchString = '';
    }

    if (specialCharacterPolicy) {
        if (specialCharacterPolicy().status) {
            matchString = `(?=(.*[!@#$%^&*?.+-]){${specialCharacterPolicy().value}})`;
            if (!password.match(matchString)) {
                errorText.push(`${msgFromPolicy(specialCharacterPolicy())}`);
            }
        }
        matchString = '';
    }

    if (errorText.length > 0) {
        display.innerHTML = errorText.join(', ');
    } else {
        display.innerHTML = "";
    }
}

function msgFromPolicy(policyObject) {
    return locale === 'rtl' ? policyObject.hints.fa : policyObject.hints.en;
}

const loadPasswordHintsPolicy = async function () {
    try {
        const data = await AJAX(`${location.origin}/password_policy_hints.json?nocache=${Date.now()}`, null);
        passwordPolicyHints = [...data];
        if (passwordIsExistInPastEl) {
            const message = passwordPolicyHints.find(item => item.name === passwordIsExistInPastEl.value);
            if (message) {
                showErrorToast(locale === 'rtl' ? message.hints.fa : message.hints.en);
            }
        }
    } catch (err) {
        passwordPolicyHints = [];
        if (passwordIsExistInPastEl) {
            const message = passwordPolicyHints.find(item => item.name === passwordIsExistInPastEl.value);
            if (message) {
                showErrorToast(locale === 'rtl' ? message.hints.fa : message.hints.en);
            }
        }
        throw err;
    }
}();
