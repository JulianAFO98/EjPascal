{Dado un archivo que contiene en cada línea 4 números (N1, D1, N2, D2) numerador y denominador 
de dos fracciones. Se pide leer los pares de fracciones y por cada uno de ellos informe:   
a)  La suma como fracción. 
b)  El producto como fracción.}

Program ej9;
type
str10 = string[10];

function calcularSumaFrac(n1,d1,n2,d2:integer):str10;
var
 numerador,denominador:str10;

begin
  Str((n1*d2+d1*n2),numerador);
  Str(d1*d2,denominador);
  calcularSumaFrac:= numerador+'/'+denominador;
end;

function calcularProducto(n1,d1,n2,d2:integer):str10;
var
 numerador,denominador:str10;
begin
  Str((n1*n2),numerador);
  Str((d1*d2),denominador);
  calcularProducto:= numerador+'/'+denominador;
end;


var
Arch:text;
n1,d1,n2,d2:integer;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  readln(Arch,n1,d1,n2,d2);
  WriteLn(calcularSumaFrac(n1,d1,n2,d2));
  WriteLn(calcularProducto(n1,d1,n2,d2));
end.