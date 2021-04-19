/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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

function validarTime( h_i, m_i, h_f, m_f ){
    if( h_i !== '', m_i !== '', h_f !== '', m_f !== '' ){
        let hora_inicio = new Date(2014, 11, 31, h_i, m_i, 0);
        let hora_fin = new Date(2014, 11, 31, h_f, m_f, 0);
        if( hora_inicio.getTime() < hora_fin.getTime() ){ // true
            return true;
        } else{
            alert('El horario seleccionado no es valido');
            return null;
        }
    }
    return null;
}

function validarForm2( e ){
    let d = document;
    let url = d.getElementById( 'url' ).value;
    
    let hora_inicio = d.getElementById( 'hora_inicio' ).value;
    let hora_fin = d.getElementById( 'hora_fin' ).value;
    let codigo = d.getElementById( 'codigo' );
    let asignatura = d.getElementById( 'idAsignatura' );
    let responsable = d.getElementById( 'idResponsable' );
    //console.log(url);
    //console.log(hora_inicio);
    let idAsignatura = validarOptions( asignatura, 'Id de asignatura no valido ' );
    let idResponsable = validarOptions( responsable, 'Id del docente no valido ' );
    let time = validarTime( hora_inicio.split( ':' )[0], hora_inicio.split( ':' )[1], hora_fin.split( ':' )[0], hora_fin.split( ':' )[1] );
    if( time !== null && url !== '' && idAsignatura !== null && idResponsable !== null ) {
        return true;
    }
    return false;
}