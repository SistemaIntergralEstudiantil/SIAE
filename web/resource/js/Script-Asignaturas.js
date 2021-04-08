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

(function( d ) {
    let sel = d.getElementById( 'semestre' );
    sel.addEventListener( 'change', function () {
        let tbody = d.getElementById( 'content-body' );
        let size = 9;
        for (var i = 1; i < size; i++) {
            addStyles( tbody, i, 'display: none;' );
        }
        let selec = this.options[sel.selectedIndex].value;
        //console.log(selec + ' saddsa');
        if(selec !== 10){
            let list = tbody.getElementsByClassName( selec );
            let max = list.length;
            if(max === 0){
                sel.value = 0;
                alert( 'El semestre no esta vigente' );
                for (var i = 1; i < size; i++) {
                    addStyles( tbody, i, '' );
                }
            }else{
                for (var i = 0; i < max; i++) {
                    list[i].setAttribute( 'style', '' );
                }
            }
        }else{
            for (var i = 1; i < size; i++) {
                addStyles( tbody, i, '' );
            }
        }
    } );
    
})(document);
