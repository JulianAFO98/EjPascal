{Leer desde archivo un conjunto de números, con elementos negativos no consecutivos que
delimitan subconjuntos. Obtener e informar el valor máximo de cada subconjunto (el máximo entre dos
negativos).
Ejemplo:
2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 -2 => 5 9 3
2 3 4 -7 4 5 -5 7 5 3 9 8 7 -1 3 1 => 5 9 }

program ej19;

var 
Arch:text;
num,max:integer;
contN:byte;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  max:=0;

  while not Eof(Arch) do
    begin
      read(arch,num);
      if(num<0) then
        begin
           contN:=contN+1;
        end;
      if(contN=2)then
        begin
           if(max>0)then
             WriteLn('Un maximo es:',max);
           max:=0;
           contN:=1;
        end
      else 
        begin
          if(num>max)then
             max:=num;
        end;   
    end;
end.