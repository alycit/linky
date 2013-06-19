$(document).ready(function() {
  $('#sign-out').on('click', function(e) {
    e.preventDefault();
    $(this).append('<p>Signing you out...</p>');
    $(this).append('<iframe id="logoutframe" src="https://accounts.google.com/logout" style="display: none"></iframe>');
    setTimeout(function() { window.location = window.location.origin; }, 2000);
  });
});
