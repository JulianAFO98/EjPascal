{) Implementar un procedimiento o función recursiva que determine si los dígitos de un número natural
están dispuestos de forma creciente, esto es,

 si N = dm dm-1 …..d2 d1 y para todo i: 1 <= i <= m, verifica que d i >= d i+1
Por ejemplo: para 2337, 356, 88 o 459 debería retornar verdadero
No se permite el uso de cadenas ni de vectores. }

program ej9;


function cumple(num,valAnterior:word):boolean;
var 
valActual:word;
begin 
  valActual:=num mod 10;
  if(num div 10 = 0) then 
    cumple:=true
  else 
    begin
       if(valActual<=valAnterior) then 
        cumple:=cumple(num div 10,valActual)
       else 
        cumple:=false;
    end;
        
end;

begin
  WriteLn(cumple(12345,12345 mod 10));
end.