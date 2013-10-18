
// Opacity - works but slow
$(document).ready(function(){
    $(window).scroll(function() {
        if ($(this).scrollTop() > 50) {
            $('.carousel-caption').stop().animate({opacity: 0.2}, 500);   
        } 
        if ($(this).scrollTop() < 50) {
            $('.carousel-caption').stop().animate({opacity: 1}, 500);
        }
     });
});

// FadeOut - works like charm :)
$(document).ready(function() {
    $(window).scroll( function(){
    	//-----------------------------------
        if($(window).scrollTop()>50){
            $(".carousel-caption").fadeOut();
        } else {
            $(".carousel-caption").fadeIn();
        }
        //-----------------------------------
        if($(window).scrollTop()>100){
        	$(".marketing").fadeOut();
        } else {
        	$(".marketing").fadeIn();
        }
        ///-----------------------------------
    });

    $(window).scroll(function(){
    	if($(window).scrollTop()>100){
        	$(".marketing").fadeOut();
        } else {
        	$(".marketing").fadeIn();
        }
    });
});

// Animate CSS - conflicts fixed background
$(document).ready(function() {
    $(window).scroll(function() {
        if ($(window).scrollTop() > 60) {
            $(".effect").addClass("animated fadeOut");
        } else {
            $(".effect").removeClass("animated fadeOut");
        }
    });
});
