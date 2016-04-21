$(document).ready(function() {

  var bloomApp = {
    init: function() {
      var userTime = this.getUserTime();
      this.getSentence(userTime);

    },

    getUserTime: function() {
      var displayTime = $("time").text();
      var hour = displayTime.split(":")[0];
      if (hour[0] == "0") { hour = hour[1] }
      var period = displayTime.split(":")[1].split(" ")[1];

      return hour + period.toLowerCase();
    },

    getSentence: function(time) {
      $.ajax({
        url: "/api/v1/bloom/" + time,
        context: document.body
      }).done(function(res) {
        $(".sentence").text(res.text);
        $(".twitter-share-button").attr("href", "https://twitter.com/share?text=" + res.text);
      });
    }
  };

  bloomApp.init();

  !function(d,s,id){
    var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';
    if(!d.getElementById(id)){js=d.createElement(s);
      js.id=id;js.src=p+'://platform.twitter.com/widgets.js';
      fjs.parentNode.insertBefore(js,fjs);
    }}(document, 'script', 'twitter-wjs');
});
