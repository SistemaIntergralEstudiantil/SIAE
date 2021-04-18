/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function clickBuscar ( e ) {
    let lista = e.getElementsByClassName( 'reporte' );
    let sel = lista[0].innerHTML;
    let option = document.getElementById( 'status' );
    option.value = sel;
    
    let nombre = e.getElementsByClassName( 'nombre' )[0].innerHTML;
    let matricula = e.getElementsByClassName( 'matricula' )[0].innerHTML;
    let curso = e.getElementsByClassName( 'curso' )[0].innerHTML;
    
    let lblNombre = document.getElementById( 'sel_nombre' );
    let lblMatricula = document.getElementById( 'sel_matricula' );
    lblMatricula.innerHTML = matricula;
    lblNombre.innerHTML = nombre;
    
    document.getElementById( 'sel_cur' ).value = curso;
    document.getElementById( 'sel_mat' ).value = matricula;
    
 }

