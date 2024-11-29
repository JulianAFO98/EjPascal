{Desarrollar la Función MCD que devuelve el máximo común N2 entre dos números.}

program ej18;
function calcularMCD(N1,N2:Integer):Integer;
var 
resto:integer;
begin
 repeat
   resto := N1 mod N2;
   N1:= N2;
   N2:=resto;
 until resto = 0;
 calcularMCD:=N1;
end;
var 
n1,n2:Integer;
begin
  WriteLn('Ingrese 2 numeros para calcular su MCD');
  ReadLn(N1,N2);
  WriteLn('El MCD entre ambos numeros es ',calcularMCD(N1,N2));
end.