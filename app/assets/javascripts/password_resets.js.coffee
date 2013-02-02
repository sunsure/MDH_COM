jQuery ->
  # disable submitting the Reset Password form if the fields are empty!
  $("form#reset_password input").keyup ->
    empty = false
    $("form#reset_password input").each ->
      empty = true  if $(this).val() is ""
    if empty
      $("input[type=submit]").prop('disabled', true);
    else
      $("input[type=submit]").prop('disabled', false);
  .trigger("keyup")
