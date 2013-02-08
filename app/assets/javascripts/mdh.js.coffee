jQuery ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

# Allows us to dynamically remove fields for nested models
remove_fields = (link) ->
  $(link).prev("input[type=hidden]").val "1"
  $(link).closest(".fields").hide()

# Allows us to dynamically add fields for nested models
add_fields = (link, association, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp("new_" + association, "g")
  $(link).parent().before content.replace(regexp, new_id)

# God, forgive me.
jQuery.fn.removeWithFlair = ->
  $(this).slideUp().delay(2000).queue ->
    $(this).remove()
   this
