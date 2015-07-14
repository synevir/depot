$(document).on "ready page:change", ->
  $('.store .entry > img').click ->
    $(this).parent().find(':submit').click()




# $(document).on("ready page:change", function() {
#   return $('.store .entry > img').click(function() {
#     return $(this).parent().find(':submit').click();
#   });
# });
