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
    var mappings={"1":"Technology Areas of Interest","2":"Application Areas of Interest","3":"Problem"}
    $('.add_edit_tag').click(function () {
        previous_tag = $(this).data().previousTag;
        clicked_element=this;
        var popup_title="";
        if (previous_tag) {
            $('.tags-modal #tag_input').val(previous_tag);
            $('.tags-modal #previous_tag_input').val(previous_tag);
            popup_title="Edit "
        }else{
            $('.tags-modal #tag_input').val('');
            $('.tags-modal #previous_tag_input').val('');
            popup_title="Add New "
        }
        popup_title += mappings[$(this).data().type];
        $('.tags-modal form').attr('action', $(this).data().action);
        $('.tags-modal #index_input').val($(this).index);
        $('.tags-modal .popup-title').text(popup_title);
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
            $(elem).parents(".full_width.ptb-20").fadeOut('normal',function(){
                $(this).remove();
            });
        }
    });
}
$('body').bind('hidden.bs.modal', function(e){
    $('.modal-backdrop.fade.in').remove();
});
function tab_open(){
    $('li a[role="tab"]').on("shown.bs.tab", function(e) {
        var id = $(e.target).attr("href").substr(1);
        window.location.hash = id;
    });

// on load of the page: switch to the currently selected tab
    var hash = window.location.hash;
    console.log(hash);
    if(hash) {
        $('li a[role="tab"][href="' + hash + '"]').tab('show');
    }
}
$(document).ready(tab_open);
$(document).on('page:load', tab_open);
$(document).ready(function(e){
    $('.background-overlay').bind('touchstart',close_div);
    e.stopPropagation();
});
