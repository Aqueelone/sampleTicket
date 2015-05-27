# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#widget_template").on('click', ->
    selected =  $(this).find(":selected").val()
    jxr = $.getJSON("/widgets/" + selected + "/get_template") if selected 
    
    if selected then jxr.done (data) -> $("#widget_widget_rules").val(data)
    else $("#widget_widget_rules").prop("selectedIndex", 0);
    );
$("#widget_is_readonly").on('click', ->
        if $(this).prop('checked') then $("#widget_widget_rules").prop("disabled", "disabled")
        else $("#widget_widget_rules").prop("disabled", "");
    );

$("form.new_widget").on('submit', ->
        $("#widget_widget_rules").prop("disabled", "");
    );    
$("form.edit_widget").on('submit', ->
        $("#widget_widget_rules").prop("disabled", "");
    );
$("#template_display_chooser").on('click', ->
        $(".template_field").toggleClass("template_off");
    );
 