{En un archivo se almacenó el Nombre del alumno y la nota de los K parciales, pasar los datos a un
vector Nbre paralelo a la matriz Notas e informar:
a) Listado de los alumnos que aprobaron los K parciales.
b) Por cada alumno determinar su situación:
 Promociona: si el promedio es >= 7
 Habilita: si promedio >= 5 y < 7; y la K-ésima nota >= 5
 Desaprobado: en otro caso
y generar un arreglo con los nombres de aquellos que promocionaron. }

program ej2;
type 
str30 = string[30];
TVS = array [1..255] of str30;
TM = array [1..255,1..255] of byte;

procedure llenarDatos(var vec:TVS;var mat:TM;var N,M:byte);
var
arch:text; 
i:byte;
begin
  Assign(arch,'datos.txt');
  reset(arch);
  WriteLn('Ingrese el valor de K');
  ReadLn(M);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     Read(arch,vec[N]);
     for i:=1 to M do 
      begin
        read(arch,mat[N,i]);
      end;
     ReadLn(arch); 
   end;
  Close(arch);
end;

procedure mostrarDatos(mat:TM;nombres:TVS;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
    begin
      Write(nombres[i],' ');
      for j:=1 to M do 
        Write(mat[i,j],' ');
      WriteLn;  
    end;
end;

procedure InformarAprobaron3(mat:TM;vec:TVS;N,M:byte);
var
i,j,cont:byte;
begin
  for i:=1 to N do 
   begin
     cont:=0;
     for j:=1 to M do 
       begin
         if(mat[i,j]>=5) then
           cont:=cont+1;
       end;
      if(cont=3) then
        WriteLn(vec[i],' aprobo los 3 parciales'); 
   end;
   
end;

function calcularNota(notas:TM;fila,M:byte):real;
var 
i:byte;
acum:real;
begin
   acum:=0;
   for i:=1 to M do
     begin
       acum:=acum+notas[fila,i];
     end;
   calcularNota:=acum/M;  
end;

procedure InformarSituacion(notas:TM;nombres:TVS;N,M:byte;var promocionan:TVS;var K:byte);
var 
 i:byte;
 notaFinal:real;
begin
  K:=0;
  for i:=1 to N  do 
   begin
     notaFinal := calcularNota(notas,i,M);
     if(notaFinal>=7) then
       begin
         K:=K+1;
         promocionan[K]:=nombres[i];
         WriteLn('El alumno ',nombres[i],' promociona');
       end
     else 
       begin
         if(notaFinal>=5) and (notas[i,M]>=5)then 
          WriteLn('El alumno ',nombres[i],' habilita')
         else 
           WriteLn('El alumno ',nombres[i],' desaprueba');
       end;  
   end;
end;


procedure mostrarNombres(nombres:TVS;N:byte);
var 
i,j:byte;
begin
  WriteLn('Promocionados');
  for i:=1 to N do 
    begin
      Write(nombres[i],' ');
    end;
  WriteLn;  
end;

var
Nombres,promocionados:TVS;
notas:TM;
N,M,K:byte;
begin
  llenarDatos(nombres,notas,N,M);
  mostrarDatos(notas,nombres,N,M);
  //a
  InformarAprobaron3(notas,nombres,N,M);
  //b
  InformarSituacion(notas,nombres,N,M,promocionados,K);
  mostrarNombres(promocionados,K);
end.