$(document).ready(function() {

  var bloomApp = {
    init: function() {
      var userTime = this.getUserTime();
      this.getSentence(userTime);
    },

    getUserTime: function() {
      var displayTime = $("time").text();
      var hour = displayTime.split(":")[0];
      var period = displayTime.split(":")[1].split(" ")[1];
      console.log(hour + period.toLowerCase());
      return hour + period.toLowerCase();
    },

    getSentence: function(time) {
      $.ajax({
        url: "/api/v1/bloom/" + time,
        context: document.body
      }).done(function(res) {
        $(".sentence").text(res.text);
        console.log(res);
      });
    }
  };

  bloomApp.init();
});
