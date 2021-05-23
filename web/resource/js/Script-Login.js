/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready( 
    setTimeout(function(){
        $('.content-form').css("opacity", "1");
    }, 100)
);

//Email
$( '#user' ).on( 'focus' , function() {
    $('.lbl-user').css("margin-top", "-20px");
    $('.lbl-user').css("font-size", "14px");
});

$( '#user' ).on( 'focusout' , function() {
    if($( '#user' ).val().length < 1){
        $( '.lbl-user' ).css( 'margin-top' , '12px' );
        $( '.lbl-user' ).css( 'font-size' , '20px' );
    }else{
        $( '.lbl-user' ).css( 'margin-top' , '-20px' );
        $( '.lbl-user' ).css('font-size', '14px' );
    }
});

//Contraseña
$( '#pass' ).on( 'focus' , function() {
    $( '.lbl-pass' ).css( 'margin-top' , '10px' );
    $( '.lbl-pass' ).css( 'font-size' , '14px' );
});
$( '#pass' ).on( 'focusout' , function(){ 
    if($( '#pass' ).val().length < 1){
        $( '.lbl-pass' ).css('margin-top' , '40px' );
        $( '.lbl-pass' ).css('font-size' , '20px' );
    }else{
        $( '.lbl-pass' ).css( 'margin-top', '10px' );
        $( '.lbl-pass' ).css( 'font-size' , '14px' );
    }
});