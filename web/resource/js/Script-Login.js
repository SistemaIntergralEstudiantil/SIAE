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

