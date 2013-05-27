# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("h4.media-heading button.close").click ->
    $(this).closest(".media").slideUp('slow')

  # don't follow the link!
  $(".pop").popover().click (e) ->
    e.preventDefault()

  $(".datepicker").datepicker(format: 'yyyy-mm-dd')

  $("form#calendar-datepicker input#date").on "changeDate", (e) ->
    $(this).parent("form").submit()

  $("form select#article_per_page").change ->
    $(this).parent("form").submit();


  # Automagic Permalinks
  $("a#automagic_permalink").click ->
    $.ajax
      type: "POST"
      format: "JSON"
      url: "/admin/articles/permalinker"
      data:
        query: $("form input#article_title").val()
    .complete (data, status, xhr) ->
      $("form input#article_permalink").val(data.responseText)