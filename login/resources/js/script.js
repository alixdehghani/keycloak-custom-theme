
const API_URL = 'http://sso1.ssoplus.ir';
const TIMEOUT_SEC = 10;
const state = {
  static: {}
};
const _parentElement = document.querySelector('body');
const element = document.getElementById('kc-form-wrapper');
const bodyBackgroundImage = document.getElementById('image-1');

const _errorMessage = 'No config found ;)';
const _message = '';
let _data = {};
const addHandlerRender = function (handler) {
  window.addEventListener('load', handler);
};
const render = function (data, render = true) {
  if (!data || (Array.isArray(data) && data.length === 0))
    return renderError();

  _data = data;
  // const markup = _generateMarkup();
  // if (!render) return markup;
  document.querySelector(':root').style.setProperty('--color-primary', state.static.auth_color_primary);
  document.querySelector(':root').style.setProperty('--colorprimary-light', state.static.auth_colorprimary_light);
  document.querySelector(':root').style.setProperty('--colorprimary-dark', state.static.auth_colorprimary_dark);
  document.querySelector(':root').style.setProperty('--colorgrey-dark', state.static.auth_colorgrey_dark);
  document.querySelector(':root').style.setProperty('--colorgrey-dark2', state.static.auth_colorgrey_dark2);
  document.querySelector(':root').style.setProperty('--colorgrey-dark5', state.static.auth_colorgrey_dark5);
  document.querySelector(':root').style.setProperty('--colorwhite', state.static.auth_colorwhite);
  document.querySelector(':root').style.setProperty('--colorblack', state.static.auth_colorblack);
  _clear();
  // _parentElement.insertAdjacentHTML('afterbegin', markup);
  
  $('.book__form-image-logo > img').attr("src", `${state.static.auth_customerLogo}?nocache=${Date.now()}`);
  //$(".book__form-image-logo > img").attr('height','349');
  $(".book__form-image-logo > img").css('max-width', '100%');
  $('.book__form-title-logo').attr("src", `${state.static.auth_fingerprintImageUrl}?nocache=${Date.now()}`);
  //$(".book__form-title-logo").attr('height','71');
  $(".book__form-title-logo").css('max-width', '100%');
  $("#favicon").attr("href", `${state.static.auth_favicon}?nocache=${Date.now()}`);
  $('#tab-title').text(setTextById('tab-title'));
  $('#copyright').text(setTextById('copyright'));
  $('#system-title').text(setTextById('system-title'));
  $('#first-level-system-title').text(setTextById('first-level-system-title'));
  _parentElement.style.display = 'block';
};
const _generateMarkup = function () {
  return element.outerHTML;
};
const _clear = function () {
  // _parentElement.innerHTML = '';
  _parentElement.style.display = 'none';
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
  // _parentElement.insertAdjacentHTML('afterbegin', markup);
  _parentElement.style.display = 'none';
};
const renderError = function () {
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
  // _parentElement.insertAdjacentHTML('afterbegin', markup);
  _parentElement.style.display = 'none';
};
// const timeout = function (s) {
//   return new Promise(function (_, reject) {
//     setTimeout(function () {
//       reject(new Error(`Request took too long! Timeout after ${s} second`));
//     }, s * 1000);
//   });
// };

// const AJAX = async function (url, uploadData = undefined) {
//   try {
//     const fetchPro = uploadData
//       ? fetch(url, {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: JSON.stringify(uploadData),
//       })
//       : fetch(url);

//     const res = await Promise.race([fetchPro, timeout(TIMEOUT_SEC)]);
//     const data = await res.json();

//     if (!res.ok) throw new Error(`${data.message} (${res.status})`);
//     return data;
//   } catch (err) {
//     throw err;
//   }
// };

const confEmitter$ = new ObsEmitter();
const loadStaticConfig = async function () {
  try {
    const data = await AJAX(`/app_init.json?nocache=${Date.now()}`);
    // const data = {
      //   "color_primary": "#003171",
      //   "colorprimary_light": "#143673",
      //   "colorprimary_dark": "#0A1E4B",
      //   "colorgrey_dark": "#777",
      //   "colorgrey_dark2": "#999",
      //   "colorgrey_dark5": "#8E8E8E",
      //   "colorwhite": "#fff",
      //   "colorblack": "#000",
      //   "image1Url": 'http://sso1.ssoplus.ir/statics/background1.jpg',
      //   "image2Url": 'http://sso1.ssoplus.ir/statics/background1.jpg'
      // };
      state.static = { ...data };
      confEmitter$.next();
  } catch (err) {
    console.error(`${err} 💥💥💥💥`);
    throw err;
  }
};

const controlStaticConfig = async function () {
  try {
    renderSpinner();
    await loadStaticConfig();
    // console.log(state.static);
    render(state.static);
  } catch (err) {
    renderError();
    render({
      "front.auth.init.background": "/statics/background1.jpg",
      "customer.name": "وزارت کار، تعاون و رفاه اجتماعی"
    });
    // bodyBackgroundImage.setAttribute('src', 'http://sso1.ssoplus.ir/statics/background1.jpg');
    //console.error(err);
  }
};

const init = function () {
  addHandlerRender(controlStaticConfig);
};
init();

// const kcContentWrapperEl = document.getElementById('kc-content-wrapper');
// console.log(kcContentWrapperEl.id)


function setTextById(id) {
  switch (id) {
    case 'tab-title':
      return state.static[`auth_tabTitle_${localeLabel}`] || '';
    case 'copyright':
      return state.static[`auth_copyright_${localeLabel}`] || '';
    case 'system-title':
      return state.static[`auth_systemTitle_${localeLabel}`] || '';
    case 'first-level-system-title':
      return state.static[`auth_firstLevelSystemTitle_${localeLabel}`] || '';
    default:
      break;
  }
}



