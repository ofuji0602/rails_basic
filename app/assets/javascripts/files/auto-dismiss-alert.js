// app/javascript/packs/auto-dismiss-alert.js

document.addEventListener('DOMContentLoaded', function () {
  const alertElement = document.getElementById('auto-dismiss-alert');
  if (alertElement) {
    setTimeout(function () {
      alertElement.classList.remove('show');
      alertElement.classList.add('fade');
    }, 2000); // 2秒後に非表示
  }
});
