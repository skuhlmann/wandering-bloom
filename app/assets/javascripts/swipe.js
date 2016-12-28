$(document).ready(function() {
  var bodyElement = document.getElementById('body-id');
  var swiper = new Hammer(bodyElement);

  swiper.on('swipe', function(ev) {
    location.reload();
  })
});