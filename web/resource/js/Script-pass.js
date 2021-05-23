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

function changeViewPassword( d , idPassword, idSpam ) {
    const span = d.getElementById( idSpam );
    if( span !== null) {
        span.addEventListener( 'click' , e => {
            const passwordInput = d.getElementById( idPassword );
            if ( e.target.classList.contains( 'show' ) ) {
                e.target.classList.remove( 'show' );
                e.target.textContent = 'Ocultar';
                passwordInput.type = 'text';
            } else {
                e.target.classList.add( 'show' );
                e.target.textContent = 'Mostrar';
                passwordInput.type = 'password';
            }
        });
    }
}

(function( d ) {
    changeViewPassword( d, 'pass' , 'mostrar' );
    changeViewPassword( d, 'pass-uno' , 'mostrar-uno' );
    changeViewPassword( d, 'pass-dos' , 'mostrar-dos' );
    changeViewPassword( d, 'pass-tres' , 'mostrar-tres' );
    changeViewPassword( d, 'valideContra' , 'mostrar-cuatro' );
})(document);