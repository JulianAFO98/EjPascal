{Dado un conjunto de números leídos desde un archivo, informar si están ordenados en forma
ascendente.}

program ej9;

var 
 Arch:text;
 num,num2:integer;
 ordenados:Boolean;
begin
  Assign(Arch,'datos.txt');reset(Arch);
  ordenados:=true;
  ReadLn(Arch,num);
  while not eof(Arch) do
   begin
     ReadLn(Arch,num2);
     if(num2<num) then
       ordenados:=false;
     num:=num2;  
   end;
   if ordenados then
      WriteLn('Estan ordenados')
   else 
      WriteLn('Estan desordenados');   
end.