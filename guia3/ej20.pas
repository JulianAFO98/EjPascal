{Leer desde un archivo números enteros, calcular y escribir el promedio de los elementos positivos y
distintos de cero que se encuentran entre dos negativos no consecutivos. }


program ej20;

var 
Arch:text;
num,sum:integer;
contN,contP:byte;
bandera:boolean;
begin
  Assign(Arch,'datos.txt');Reset(Arch);
  sum:=0;
  contN:=0;
  contP:=0;
  bandera:=false;
  while not Eof(Arch) do
    begin
      read(arch,num);
      if(num<0) then
        begin
           bandera:=true;
           contN:=contN+1;
        end;
      if(contN=2)then
        begin
          if(contP<>0)then
            WriteLn('El prom entre los negativos es:',sum/contP:4:2);
          contN:=1;
          contP:=0;
          sum:=0;
        end
      else 
        begin
          if(num>0) and bandera then
            begin
              contP:=contP+1;
              sum:=sum+num;
            end;
        end;   
    end;
end.