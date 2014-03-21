$(document).ready ->
  $(".no-wins").hide()

  $("#show-no-wins").click ->
    $("div#show-no-wins").hide()
    $(".no-wins").show("fade", {}, 200)