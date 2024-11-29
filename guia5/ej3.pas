{Dado un arreglo V y un número K, cambiar todas las ocurrencias de K por 0. }

program ej3;
type 
TV = array [1..23] of integer;

const 
M:TV = (3,3,5,8,4,7,-1,6,4,6,3,6,8,0,50,3,2,4,5,8,6,2,1);

var 
V:TV;
i:byte;
K:integer;
begin
  V:=M;
  WriteLn('Ingrese K');
  ReadLn(K);
  for i:=1 to 23 do
    begin
      if(V[i]=K) then
        V[i]:=0;
    end;
   for i:=1 to 23 do
      begin
        Write(V[i],' ');
      end; 
end.