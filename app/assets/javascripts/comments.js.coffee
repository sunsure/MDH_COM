# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  # remove the form and show the new comment link
  # if the user decides to cancel creating a new comment
  # when creating a NEW comment
  $("a#cancel_new_comment_link").live "click", (event) ->
    $("form#new_comment").removeWithFlair();
    $("a#new_comment_link").show()
    event.preventDefault()

  # hide the form when we're editing an EXISTING comment
  $("a#cancel_edit_comment_link").live "click", (event) ->
    $("form#edit_comment").removeWithFlair();
    $("a#new_comment_link").show()
    $("a#cancel_edit_comment_link").closest("div.media").find("div.media[id^='my_comment_content_']").show();
    $("a#cancel_edit_comment_link").closest("div.media").find("div[id^='comment_actions_']").show();
    event.preventDefault()

  # Hide the form when canceling a reply
  $("a#cancel_reply_comment_link").live "click", (event) ->
    $("form#reply_comment").removeWithFlair();
    $("a#new_comment_link").show()
    $("a#cancel_reply_comment_link").closest("div.media").find("div.media[id^='my_comment_content_']").show();
    $("a#cancel_reply_comment_link").closest("div.media").find("div[id^='comment_actions_']").show();
    event.preventDefault()

