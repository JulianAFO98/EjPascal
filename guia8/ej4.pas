{ Escribir un subprograma recursivo que retorne una cadena de caracteres recibida como parametro
con su contenido invertido.
 Ejemplo: ‘lamina’  ‘animal’ }
program ej4;
type 
str10=string[10];

function invertirPalabra(pal:str10;indiceLetra:byte):str10;
begin
  if(indiceLetra=1) then 
   invertirPalabra:=pal[indiceLetra]
  else 
   invertirPalabra:=pal[indiceLetra]+invertirPalabra(pal,indiceLetra-1); 
end;


begin
  WriteLn(invertirPalabra('lamina',Length('lamina')));
end.