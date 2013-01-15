# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $("h4.media-heading button.close").click ->
    $(this).closest(".media").slideUp('slow')

  $(".pop").popover()
  $(".datepicker").datepicker(format: 'yyyy-mm-dd')

  $("form#calendar-datepicker input#date").on "changeDate", (e) ->
    $(this).parent("form").submit()

  $("form select#article_per_page").change ->
    $(this).parent("form").submit();
