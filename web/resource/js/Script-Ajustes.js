/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function validarForm( e ){
    let d = document;
    let contra = d.getElementById( 'contra' ).value;
    
    let newContra = d.getElementById( 'newContra' ).value;
    let valideContra = d.getElementById( 'valideContra' ).value;
    
    if( contra !== '' && newContra !== '' && valideContra !== '' ) {
        if(newContra === valideContra)
            return true;
        else {
            alert( 'La confirmación de la contraseña no es valida' );
            return false;
        }
    }
    return false;
}
