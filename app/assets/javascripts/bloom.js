$(document).ready(function() {

  var bloomApp = {
    init: function() {
      var userTime = this.getUserTime();
      this.getSentence(userTime);
      this.setListeners();
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
        $(".twitter-share-button").attr("href", "https://twitter.com/share?text=" + res.text + "&url=http://wanderingbloom.com");
      });
    },

    setListeners: function() {
      $(".twitter-share-button").on('click', function() {
        window.open(
          this.href,
          'targetWindow',
          'toolbar=no,menubar=no,scrollbars=no,resizable=yes,width=450,height=300'
          );
        return false;
      });

      $(".refresh-link").on('click', function() {
        var userTime = bloomApp.getUserTime();
        bloomApp.getSentence(userTime);
      });
    }
  };

  bloomApp.init();
});