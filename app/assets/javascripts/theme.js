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
        $('.left_219').animate({ "left": '-268px' });
        $('#page-content-wrapper').animate({ "left": '267px' });
        $(".overlay").css("display", "block");
        $(".close").css("display", "block");


    }

    function close_div() {
        $('.left_219').animate({ "left": '-267px' });
        $('#page-content-wrapper').animate({ "left": '0px' });
        $(".overlay").css("display", "none");
        $(".close").css("display", "none");
    }
