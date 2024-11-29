{Desarrollar  un  procedimiento  y  los  tipos  necesarios  para  el  cálculo  de  una  serie  finita.  Los 
parámetros serán: 
   N = cantidad de términos a sumar, con N>0 
   RES = resultado 
   F = función para calcular cada uno de los términos de la serie 
El procedimiento calculará:  RES  =  F(1) + F(2) + F(3) +...+ F(n) 
 
y se pide utilizarlo para evaluar por medio de un menú 
      RES1 =  1 + 1/4 + 1/9 +...+1/ n2 
      RES2 =  1 + 1/2 + 1/4 +...+ 1/ 2 (n-1) 
      RES3 =  1 + 1/2! + 1/3! +...+ 1/ n! 
Resolver utilizando el tipo función. ¿Cómo cambiaría F por P de tipo procedimiento?}

program ej15;
type
TFunc = function(N:byte):real;

function F1 (N:byte):real;
var
i:byte;
sum:real;
begin
  sum:=1;
  for i:=2 to N do
    begin
      sum:=sum+ (1/Sqr(n));
    end;
   F1:=sum; 
end;

function factorial(n:byte):word;
var
i:byte;
mult:word;
begin
  mult:=1;
  for i:=1 to N do
   begin
     mult:=mult*i;
   end;
   factorial:=mult;
end;

function F3 (N:byte):real;
var
i:byte;
sum:real;
begin
  sum:=1;
  for i:=2 to N do
    begin
      sum:=sum+ (1/factorial(N));
    end;
   F3:=sum; 
end;


function F2 (N:byte):real;
var
i:byte;
sum:real;
begin
  sum:=1;
  for i:=2 to N do
    begin
      sum:=sum+ (1/(2*(n-1)));
    end;
   F2:=sum; 
end;


procedure calcularSerie(N:byte;var RES:real;F:TFunc);
begin
  RES := F(N);
end;

var
N,opc:byte;
RES:real;
F:TFunc;
begin
  WriteLn('Ingrese cantidad de repeticiones');
  ReadLn(N);
  repeat
    WriteLn('Ingrese la opcion de serie que desea');
    WriteLn('1 ====> 1 + 1/4 + 1/9 +...+1/ n2');
    WriteLn('2 ====> 1 + 1/2 + 1/4 +...+ 1/ 2 (n-1)');
    WriteLn('3 ====> 1 + 1/2! + 1/3! +...+ 1/ n! ');
     WriteLn('0 ====> Finalizar');
    repeat
      ReadLn(opc);
    until opc in [0..3];
    Case opc of  
     1:F:=@F1;
     2:F:=@F2;
     3:F:=@F3;
    end;
    calcularSerie(N,RES,F);
    if(opc<>0)then
      WriteLn('El resultado es ',RES:4:2);
  until opc = 0;
end.