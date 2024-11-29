{) Hacer un programa que dada una fracción (numerador y denominador) la simplifique usando la
función MCD. }

program ej19;
type
str15=string[15];
function calcularMCD(N1,N2:Integer):Integer;
var 
resto,aux:integer;

begin
 repeat
   resto := N1 mod N2;
   N1:= N2;
   N2:=resto;
 until resto = 0;
 calcularMCD:=N1;
end;

function simplificarFrac(n1,n2:integer):str15;
var 
MCD:integer;
strnum1,strnum2:str15;
begin
  MCD := calcularMCD(n1, n2);
  Str(n1 div MCD, strnum1);
  Str(n2 div MCD, strnum2);
  simplificarFrac := strnum1 + '/' + strnum2; 
end;

var 
n1,n2:Integer;
begin
  WriteLn('Ingrese 2 numeros para simplificarla');
  ReadLn(N1,N2);
  WriteLn('La fraccion simplificada es: ',simplificarFrac(n1,n2));
end.