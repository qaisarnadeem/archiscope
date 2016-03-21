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
        $('body').addClass("menu-shown");


    }

    function close_div(duration) {
        if(duration==undefined)
        {
            $('.left_219').animate({ "left": '-280px' });
            $('#page-content-wrapper').animate({ "left": '0px' });
        }else {
            $('.left_219').animate({ "left": '-267px' },duration);
            $('#page-content-wrapper').animate({ "left": '0px' },duration);
        }
        $(".overlay").css("display", "none");
        $(".close").css("display", "none");
        $('body').removeClass("menu-shown");
    }
