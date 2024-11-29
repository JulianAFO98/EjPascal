program ej17;


function esPrimo(numero:Word):boolean;
var 
 primo:boolean;
 maxMod:word;
 i:byte;
begin
  if(numero=1)then
    primo:=false 
  else   
    primo:=true;
  maxMod:=Trunc(sqrt(numero));
  for i:=2 to maxMod do
    begin
      if(numero mod i=0) then
        primo:=false;
    end;
  esPrimo:=primo;
end;


var 
num:word;
begin
   WriteLn('Ingrese un numero para ver si es primo');
   ReadLn(Num);
   if(esPrimo(num)) then
      WriteLn('Es primo')
   else 
      WriteLn('No es primo');  
end.