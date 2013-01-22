# God, forgive me.
jQuery.fn.removeWithFlair = ->
  $(this).slideUp().delay(2000).queue ->
    $(this).remove()
   this
