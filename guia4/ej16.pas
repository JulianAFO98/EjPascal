{Mediante una función booleana determinar si un número es capicúa}

program ej16;
type
 str15=string[15];

function capicua(pal:str15):boolean;
var 
primermitad,segundamitad:str15;
lugarDeCorte,i:byte;
begin
  lugarDeCorte:= Length(pal) div 2 +1;  
  
  primermitad:=copy(pal,1,lugarDeCorte-1);

  if(Length(pal)mod 2 <>0) then
    lugarDeCorte:=lugarDeCorte+1;

  segundamitad:='';
  for i:=Length(pal) downto lugarDeCorte do 
   begin
     segundamitad:=segundamitad+Copy(pal,i,1);
   end;
  capicua:=primermitad=segundamitad;
end;


var 
pal:str15;
begin
  WriteLn('Ingrese una palabra para ver si es capicua');
  ReadLn(pal);
  if(capicua(pal))then
    WriteLn('Es capicua')
  else  
    WriteLn('No es capicua');
end.