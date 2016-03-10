    trigger = $('.hamburger');
    overlay = $('.overlay');
    function hamburger_cross() {
        trigger.toggleClass('is-open');
        trigger.toggleClass('is-closed');
        overlay.toggle();
    }
$(document).ready(function() {
    /*=======================
           Scroll
       =========================*/


});
/*=======================
           Change Icon First
    =========================*/
// function close_div() {
//     overlay.hide();
//     trigger.removeClass('is-closed');
//     $('#sidebar-wrapper').hide();

//     $('#wrapper').removeClass('toggled');

// }

function optoin_slide() {
    $('#show_down').slideToggle('down');
}

$(document).ready(function() {
    trigger = $('.hamburger');
    trigger.click(function() {
        hamburger_cross();
    });

    $('[data-toggle="offcanvas"]').click(function() {
        $('#wrapper').toggleClass('toggled');
    });
});
