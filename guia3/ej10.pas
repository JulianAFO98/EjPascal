{) Leer desde un archivo números enteros ordenados de menor a mayor, puede haber elementos
repetidos.
Calcular y mostrar cada número con su respectiva frecuencia.
Ejemplo: 2, 2, 3, 3, 3, 3, 7, 9, 9, 9 
}
program ej10;
var

Arch:text;
n1,n2:integer;
cont:byte;
begin
  Assign(Arch,'datos.txt');reset(Arch);
  ReadLn(Arch,n1);
  cont:=1;
  while not eof(Arch) do
     begin
       Readln(Arch,n2);
       if (n2<>n1) or eof(Arch)then
         begin
           WriteLn(n1,':',cont);
           cont:=1;
         end
       else
         cont:=cont+1;
         
       n1:=n2;
     end;
end.