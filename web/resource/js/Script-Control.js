/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function sendAJAXAdd( idCurso, idUsuario, estado, cupo, tipo, idAsignatura ) {
    let http = new XMLHttpRequest();
    let url = 'http://localhost:8080/SIAE/Control';
    http.open( 'POST', url, true);
    http.setRequestHeader( 'Content-type', 'application/x-www-form-urlencoded' );
    http.send( 'clave=add&idCurso='+idCurso+'&idResponsable='+idUsuario+'&estado='+estado+'&cupo='+cupo+'&tipo='+tipo+'&idAsignatura='+idAsignatura );
}

function validarNumber( number, mensaje ) {
    let value = number.value;
    //console.log(value);
    if( value === '' ){
        alert( mensaje );
        return null;
    }else{
        return value;
    }
}

function validarOptions( options, mensaje ) {
    let selec = options.options[options.selectedIndex].value;
    if( selec === '0' ){
        alert( mensaje );
        return null;
    }else{
        return selec;
    }
}

function sendAJAXSesion( idCurso ) {
    let http = new XMLHttpRequest();
    let url = 'http://localhost:8080/SIAE/Control';
    http.open( 'POST', url, true);
    http.setRequestHeader( 'Content-type', 'application/x-www-form-urlencoded' );
    http.send( 'clave=session&idCurso='+idCurso );
}

function validarForm( e ){
    let d = document;
    let asignatura = d.getElementById( 'asignatura' );
    let responsable = d.getElementById( 'responsable' );

    let idCurso = d.getElementById( 'idCurso' );
    let ordinario = d.getElementById( 'ordinario' ).checked;
    let estado = d.getElementById( 'estado' ).checked;
    let cupo = d.getElementById( 'cupo' );

    let opC = validarNumber( idCurso, 'Id del curso no valido' );
    let opS = validarNumber( cupo, 'Cupo no valido' );
    // console.log(ordinario);
    let idAsignatura = validarOptions( asignatura, 'Id de asignatura no valido ' );
    let idResponsable = validarOptions( responsable, 'Id del docente no valido ' );
    let tipo = (ordinario===true)?'O':'V';
    if( opC !== null && opS !== null && idAsignatura !== null && idResponsable !== null ) {
        estado = (estado)?'E':'D';
        //sendAJAXAdd( opC, idResponsable, estado, opS, tipo, idAsignatura );
        //console.log( 'SEND' );
        
        return true;
    }
    return false;
}
(function( d ) {
    
    /*
     * 
     d.getElementById( 'add' ).addEventListener( 'click', () => {
        let asignatura = d.getElementById( 'asignatura' );
        let responsable = d.getElementById( 'responsable' );
        
        let idCurso = d.getElementById( 'idCurso' );
        let ordinario = d.getElementById( 'ordinario' ).checked;
        let estado = d.getElementById( 'estado' ).checked;
        let cupo = d.getElementById( 'cupo' );
        
        let opC = validarNumber( idCurso, 'Id del curso no valido' );
        let opS = validarNumber( cupo, 'Cupo no valido' );
        // console.log(ordinario);
        let idAsignatura = validarOptions( asignatura, 'Id de asignatura no valido ' );
        let idResponsable = validarOptions( responsable, 'Id del docente no valido ' );
        let tipo = (ordinario===true)?'O':'V';
        if( opC !== null && opS !== null && idAsignatura !== null && idResponsable !== null ) {
            estado = (estado)?'E':'D';
            //sendAJAXAdd( opC, idResponsable, estado, opS, tipo, idAsignatura );
            console.log( 'SEND' );
        }
    } );
    */
    
})( document );
