import { API_URL, RES_PER_PAGE, KEY } from './config.js';
// import { getJSON, sendJSON } from './helpers.js';
import { AJAX } from './helpers.js';

export const state = {
  static: {}
};

// const createStaticObject = function(data) {
//   return {

//   }
// }
export const loadStaticConfig = async function() {
  try {
    const data  = await AJAX(`${API_URL}/auth_config.json`);
    state.static = {...data};
  } catch (error) {
     console.error(`${err} 💥💥💥💥`);
    throw err;
  }
}

// const init = function () {
//   const storage = localStorage.getItem('bookmarks');
//   if (storage) state.bookmarks = JSON.parse(storage);
// };
// init();

// const clearBookmarks = function () {
//   localStorage.clear('bookmarks');
// };
// clearBookmarks();

