$(function() {
  var id =document.getElementById("spigotId").value;
  var currentStatus = document.getElementById("spigotStatus").value;
  startPolling(id, currentStatus);
});

var startPolling = function(spigot_id, status) {
  var poll = setInterval(function() {
    var newStatus = status
    $.ajax("/spigots/" + spigot_id +"/status", {
      method: "GET",
      success: function(response) {
        newStatus = response.status;
        if (newStatus != status) {
          location.reload();
        };
      } 
  });

}, 2000);
}