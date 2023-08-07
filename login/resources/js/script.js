
const API_URL = 'http://sso1.ssoplus.ir';
const TIMEOUT_SEC = 10;
const state = {
  static: {}
};
const _parentElement = document.querySelector('.section-book');
const element = document.getElementById('kc-form-wrapper');
const bodyBackgroundImage = document.getElementById('body-background-image');

const _errorMessage = 'No config found ;)';
const _message = '';
let _data = {};
const addHandlerRender = function (handler) {
  window.addEventListener('load', handler);
};
const render = function(data, render = true) {
  if (!data || (Array.isArray(data) && data.length === 0))
    return renderError();

  _data = data;
  const markup = _generateMarkup();

  if (!render) return markup;

  _clear();
  _parentElement.insertAdjacentHTML('afterbegin', markup);
}
const _generateMarkup = function() {
  return element.outerHTML;
}
const _clear = function () {
  _parentElement.innerHTML = '';
};
const renderSpinner = function () {
  const markup = `
    <div class="spinner">
      <svg>
        <use href="#icon-loader"></use>
      </svg>
    </div>
  `;
  _clear();
  _parentElement.insertAdjacentHTML('afterbegin', markup);
};
const renderError = function() {
  const markup = `
    <div class="error">
      <div>
        <svg>
          <use href="#icon-alert-triangle"></use>
        </svg>
      </div>
      <p>${_errorMessage}</p>
    </div>
  `;
  _clear();
  _parentElement.insertAdjacentHTML('afterbegin', markup);
}
const timeout = function (s) {
  return new Promise(function (_, reject) {
    setTimeout(function () {
      reject(new Error(`Request took too long! Timeout after ${s} second`));
    }, s * 1000);
  });
};

const AJAX = async function (url, uploadData = undefined) {
  try {
    const fetchPro = uploadData
      ? fetch(url, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(uploadData),
      })
      : fetch(url);

    const res = await Promise.race([fetchPro, timeout(TIMEOUT_SEC)]);
    const data = await res.json();

    if (!res.ok) throw new Error(`${data.message} (${res.status})`);
    return data;
  } catch (err) {
    throw err;
  }
};

const loadStaticConfig = async function () {
  try {
    const data = await AJAX(`${API_URL}/auth_config.json`);
    state.static = { ...data };
  } catch (err) {
    console.error(`${err} 💥💥💥💥`);
    throw err;
  }
};

const controlStaticConfig = async function () {
  try {
    renderSpinner();
    await loadStaticConfig();
    console.log(model.state.static);
    render(model.state.static)
  } catch (err) {
    renderError();
    render({
      "front.auth.init.background": "/statics/background1.jpg",
      "customer.name": "وزارت کار، تعاون و رفاه اجتماعی"
    })
    // bodyBackgroundImage.setAttribute('src', 'http://sso1.ssoplus.ir/statics/background1.jpg');
    // document.querySelector(':root').style.setProperty('--color-primary', 'lightblue');
    console.error(err);
  }
};

const init = function () {
  addHandlerRender(controlStaticConfig);
};
init();
cansubmit




