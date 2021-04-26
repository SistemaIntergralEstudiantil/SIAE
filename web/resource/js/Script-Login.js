/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validarUser( d, regex ){
    d.getElementById( 'user' ).addEventListener( 'keyup' , ( e ) => {
        e.target.classList.remove( 'input-err' );
        e.target.classList.remove( 'input-val' );
        let val = e.target.value;
        let exr = new RegExp( regex );
        let a = false;
        if( exr.test( val ) ){
            a = true;
        }else{
            a = false;
        }
        e.target.classList.add( ( a )? 'input-val' : 'input-err' );
        
    } );
}

function validarPassword( d, regex ){
    d.getElementById( 'pass' ).addEventListener( 'keyup' , ( e ) => {
        e.target.classList.remove( 'input-err' );
        e.target.classList.remove( 'input-val' );
        let val = e.target.value;
        let exr = new RegExp( regex );
        let a = false;
        if( exr.test( val ) ){
            a = true;
        }else{
            a = false;
        }
        e.target.classList.add( ( a )? 'input-val' : 'input-err' );
        
    } );
}

(function( d ) {
    validarUser( d, '^[0-9]{1,20}$' );
    validarPassword( d, '^(.){8}$' );
    
    
})(document);



$(document).ready( 
    
    setTimeout(function(){
    
    $('.content-form').css("opacity", "1");
    }, 100)
)

//Email

$('#user').on('focus', function(){
    
    $('.lbl-user').css("margin-top", "-20px");
    $('.lbl-user').css("font-size", "14px");
})

$('#user').on('focusout', function(){
    
    if($('#user').val().length < 1){
        
        $('.lbl-user').css("margin-top", "12px");
        $('.lbl-user').css("font-size", "20px");
    }else{
        $('.lbl-user').css("margin-top", "-20px");
    $('.lbl-user').css("font-size", "14px");
    }
})

//Contraseña

$('#pass').on('focus', function(){
    
    $('.lbl-pass').css("margin-top", "10px");
    $('.lbl-pass').css("font-size", "14px");
})

$('#pass').on('focusout', function(){
    
    if($('#pass').val().length < 1){
        
        $('.lbl-pass').css("margin-top", "40px");
        $('.lbl-pass').css("font-size", "20px");
    }else{
        $('.lbl-pass').css("margin-top", "10px");
    $('.lbl-pass').css("font-size", "14px");
    }
})