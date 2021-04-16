/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//Declaramos los elementos HTML

const imgDiv = document.querySelector(
        '.profile-pic-div');
const img = document.querySelector('#foto');
const file = document.querySelector('#file');
const subirFoto = document.querySelector('#subirFoto');

//Si el usuario se desplaza sobre la sección perfil

imgDiv.addEventListener('mouseenter', function()
{
subirFoto.style.display = "block";
});

//Sí el usuario sale del contenido de la imagen

imgDiv.addEventListener('mouseleave', function()
{
    subirFoto.style.display = "none";
});

//Funcionamiento al escoger una imágen para subir

//Cuando subimos una foto

file.addEventListener('change', function()
{
  const choosedFile = this.files[0];
  
  if(choosedFile){
      const reader = new FileReader();
      //FileReader es una función predefinida de JavaScript
      
      reader.addEventListener('load', function(){
          img.setAttribute('src', reader.result); 
      });
        reader.readAsDataURL(choosedFile);
        
  }
});