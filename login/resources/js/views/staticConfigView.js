import View from './View.js';

class StaticConfigView extends View {
  _parentElement = document.querySelector('.section-book');
  _errorMessage = 'No config found ;)';
  _message = '';

  addHandlerRender(handler) {
    window.addEventListener('load', handler);
  }

  _generateMarkup() {
    return '';
  }
}

export default new StaticConfigView();
