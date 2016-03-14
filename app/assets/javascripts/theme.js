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

    function nav_bar() {
        $('#nav_bar').show();
        $('#nav_bar').addClass('left_0');
        $('#page-content-wrapper').addClass('page_left');
        $('#nav_bar').removeClass('left_219');
        $(".overlay").css("display", "block");


    }

    function close_div() {
        $('#nav_bar').hide();
        $('#page-content-wrapper').removeClass('page_left');
        $('#nav_bar').removeClass('left_0');
        $('#nav_bar').addClass('left_219');
        $(".overlay").css("display", "none");
    }
