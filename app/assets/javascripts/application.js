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

function set_autocomplete_for(selector,data_key){
    if(data_key==undefined || data_key==''){
        data_key='all'
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
                callback: function() {}
            },

            hideAnimation: {
                type: "fade", //normal|slide|fade
                time: 400,
                callback: function() {}
            }
        }
    };
    $(selector).easyAutocomplete(options);
}