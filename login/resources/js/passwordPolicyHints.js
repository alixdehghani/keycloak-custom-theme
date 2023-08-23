const code = document.getElementById("password");
const display = document.getElementsByClassName("textbox")[0];
const passwordIsExistInPastEl = document.getElementById('password-is-exist-in-past');
let passwordPolicyHints = [
    {
        "name": "MINIMUM_LENGTH",
        "value": 8,
        "status": true,
        "hints": {
            "en": "",
            "fa": "حداقل تعداد کاراکتر رمز عبور 8 عدد می باشد"
        }
    },
    {
        "name": "UPPERCASE_CHARACTERS",
        "value": 2,
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور می بایست حداقل دو حرف بزرگ داشته باشد"
        }
    },
    {
        "name": "DIGITS",
        "value": 2,
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور می بایست شامل 2 عدد باشد"
        }
    },
    {
        "name": "SPECIAL_CHARACTERS",
        "value": 3,
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور می بایست شامل 3 کاراکتر خاص باشد"
        }
    },
    {
        "name": "NOT_RECENTLY_USED",
        "value": 5000,
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور ایجاد شده، یکی از رمزهای عبور قدیمی می باشد"
        }
    },
    {
        "name": "NOT_USERNAME",
        "value": "",
        "status": true,
        "hints": {
            "en": "",
            "fa": ""
        }
    },
    {
        "name": "NOT_EMAIL",
        "value": "",
        "status": true,
        "hints": {
            "en": "",
            "fa": ""
        }
    },
    {
        "name": "LOWERCASE_CHARACTERS",
        "value": 2,
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور حداقل می بایست شامل 2 حرف کوچک باشد"
        }
    },
    {
        "name": "PASSWORD_BLACKLIST",
        "value": "",
        "status": true,
        "hints": {
            "en": "",
            "fa": "رمز عبور به عنوان رمز عبور نامعتبر می باشد"
        }
    },
    {
        "name": "EXPIRE_PASSWORD",
        "value": "",
        "status": false,
        "hints": {
            "en": "",
            "fa": ""
        }
    },
    {
        "name": "REGULAR_EXPRESSION",
        "value": "",
        "status": false,
        "hints": {
            "en": "",
            "fa": ""
        }
    }
];

const minLengthPolicy = () => passwordPolicyHints.find(item => item.name === 'MINIMUM_LENGTH');
const lowerCasePolicy = () => passwordPolicyHints.find(item => item.name === 'LOWERCASE_CHARACTERS');
const upperCasePolicy = () => passwordPolicyHints.find(item => item.name === 'UPPERCASE_CHARACTERS');
const specialCharacterPolicy = () => passwordPolicyHints.find(item => item.name === 'SPECIAL_CHARACTERS');
const digitsPolicy = () => passwordPolicyHints.find(item => item.name === 'DIGITS');

code.addEventListener("keyup", function () {
    checkpassword(code.value);
});

function checkpassword(password) {
    if (minLengthPolicy().status && password.length < minLengthPolicy().value) {
        display.innerHTML = `${msgFromPolicy(minLengthPolicy())}`;
        return;
    }
    let errorText = [];
    let matchString = '';
    if (lowerCasePolicy().status) {
        matchString = `(?=(.*[a-z]){${lowerCasePolicy().value},})`;
        if (!password.match(matchString)) {
            errorText.push(`${msgFromPolicy(lowerCasePolicy())}`);
        }
    }
    matchString = '';

    if (upperCasePolicy().status) {
        matchString = `(?=(.*[A-Z]){${upperCasePolicy().value},})`;
        if (!password.match(matchString)) {
            errorText.push(`${msgFromPolicy(upperCasePolicy())}`);
        }
    }
    matchString = '';

    if (digitsPolicy().status) {
        matchString = `^(?=(.*\\d){${digitsPolicy().value}})`;
        if (!password.match(matchString)) {
            errorText.push(`${msgFromPolicy(digitsPolicy())}`);
        }
    }
    matchString = '';
    if (specialCharacterPolicy().status) {
        matchString = `(?=(.*[!@#$%^&*?.+-]){${specialCharacterPolicy().value}})`;
        if (!password.match(matchString)) {
            errorText.push(`${msgFromPolicy(specialCharacterPolicy())}`);
        }
    }
    matchString = '';

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
    let config = {};
    try {
        config = await loadConfig();
        const data = await AJAX(`${config.api_url}/password_policy_hints.json`, null, config);
        passwordPolicyHints = [...data];
        if (passwordIsExistInPastEl) {
            const message = passwordPolicyHints.find(item => item.name === passwordIsExistInPastEl.value);
            if (message) {
                showErrorToast(locale === 'rtl' ? message.hints.fa : message.hints.en);
            }
        }
    } catch (err) {
        passwordPolicyHints = [...config.password_policy_hints];
        if (passwordIsExistInPastEl) {
            const message = passwordPolicyHints.find(item => item.name === passwordIsExistInPastEl.value);
            if (message) {
                showErrorToast(locale === 'rtl' ? message.hints.fa : message.hints.en);
            }
        }
        throw err;
    }
}();
