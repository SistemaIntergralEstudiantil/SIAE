/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function addStyles( node, type, style ){
    let list = node.getElementsByClassName( type );
    for (var j = 0; j < list.length; j++) {
        list[j].setAttribute( 'style', style );
    }
}

function clearStyles( tbody, max ){
    for (var i = 1; i < max; i++) {
        let list = tbody.getElementsByClassName( i );
        if(list !== null){
            for (var j = 0; j < list.length; j++) {
                list[j].setAttribute( 'style', '' );
            }
        }
    }
}

function validarSemestre( d ) {
    let sel = d.getElementById( 'semestre' );
    sel.addEventListener( 'change', function () {
        let tbody = d.getElementById( 'content-body' );
        let comboS = d.getElementById("area");
        let size = 9;
        // se limpian todos
        for (var i = 1; i < size; i++) {
            addStyles( tbody, i, 'display: none;' );
        }
        let selec = this.options[sel.selectedIndex].value;
        //console.log(selec + ' saddsa');
        let list = tbody.getElementsByClassName( selec );
        let max = list.length;
        if(max === 0){
            if( selec === '10' ){
                clearStyles( tbody, 11 ); // Opción todos
                comboS.value = 0;
            }else{
                sel.value = 0; // No hay datos del semestre
                alert( 'El semestre no esta vigente' );
                for (var i = 1; i < size; i++) {
                    addStyles( tbody, i, '' );
                }
            }
        }else{
            comboS.value = 0;
            for (var i = 0; i < max; i++) { // Recorrido normal
                list[i].setAttribute( 'style', '' );
            }
        }
        
    } );
}


(function( d ) {
    validarSemestre( d );
    
    let selectA = d.getElementById( 'area' );
    selectA.addEventListener( 'change', function () {
        let tbody = d.getElementById( 'content-body' );
        let selec = this.options[selectA.selectedIndex].value;
        let comboS = d.getElementById("semestre");
        let semestre = comboS.options[comboS.selectedIndex].value;
        console.log(semestre + ' -> ' + selec);
        if( semestre !== '0' && semestre !== '10' ){
            for (var i = 1; i < 9; i++) {
                addStyles( tbody, i, 'display: none;' );
            }
            if( selec !== 'AL' ) {
                let list = tbody.getElementsByClassName( semestre + ' ' + selec );
                let max = list.length;
                for (var i = 0; i < max; i++) {
                    list[i].setAttribute( 'style', '' );
                }
            } else {
                clearStyles( tbody, 11 ); // Opción todos
            }
        } else {
            console.log(semestre + ' <-2-> ' + selec);
            if( selec === 'AL' ) {
                semestre.value = 0;
                clearStyles( tbody, 11 ); // Opción todos
            } else {
                semestre.value = 0;
                let lis = tbody.getElementsByClassName( selec );
                for (var i = 1; i < 9; i++) {
                    addStyles( tbody, i, 'display: none;' );
                }
                for (var j = 0; j < lis.length; j++) { // Recorrido normal
                    lis[j].setAttribute( 'style', '' );
                }
            }
        }
    } );
    
})(document);
