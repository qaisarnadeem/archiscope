// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require easyautocomplete/jquery.easy-autocomplete.min
//= require nprogress
//= require nprogress-turbolinks
//= require turbolinks
//= require_tree .

function set_autocomplete_for(selector,data_key) {
    if (data_key == undefined || data_key == '') {
        data_key = 'all'
    }
    var options = {
        data: autocomplete_data[data_key],
        list: {
            maxNumberOfElements: 5,
            match: {
                enabled: true
            },
            showAnimation: {
                type: "fade", //normal|slide|fade
                time: 400,
                callback: function () {
                }
            },

            hideAnimation: {
                type: "fade", //normal|slide|fade
                time: 400,
                callback: function () {
                }
            }
        }
    };
    $(selector).easyAutocomplete(options);
}
function handle_tags_submission(){
    $('.tags-modal').modal('hide');
    if(previous_tag){
        $(clicked_element).parents('li.p-10').find('h4').text($('.tags-modal #tag_input').val());
        $(clicked_element).data('previous-tag',$('.tags-modal #tag_input').val());
    }
}
function handle_tags_removal(){
    $('.tag-remove-link').click(function(){
        var elem=this;
        $.ajax({
            url: $(this).data().href,
            type: 'DELETE',
            success: function(result) {
                $(elem).parents("li.p-10").fadeOut();
            }
        });
    })
}
function handle_tag_updation() {
    $('.add_edit_tag').click(function () {
        previous_tag = $(this).data().previousTag;
        clicked_element=this;
        if (previous_tag) {
            $('.tags-modal #tag_input').val(previous_tag);
            $('.tags-modal #previous_tag_input').val(previous_tag);
        }
        $('.tags-modal form').attr('action', $(this).data().action);
        $('.tags-modal #index_input').val($(this).index);
        $('.tags-modal').modal('show');
    });
}
function handle_contact_updation(elem){
        jQuery.get($(elem).data().href);
}
function handle_contacts_removal(elem){
        $.ajax({
            url: $(elem).data().href + '/',
            type: 'DELETE',
            success: function(result) {
                $(elem).parents("li.contact").fadeOut();
            }
        });
}
function handle_note_removal(elem){
    $.ajax({
        url: $(elem).data().href + '/',
        type: 'DELETE',
        success: function(result) {
            $(elem).parents(".full_width.ptb-20").fadeOut();
        }
    });
}