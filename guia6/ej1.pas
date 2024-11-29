{Leer desde un archivo una matriz de NxM elementos enteros, (N y M se encuentran en la primera
línea del archivo y luego en las restantes N líneas vienen los M elementos). Se pide:
a) Generar un arreglo con el máximo de cada fila y mostrarlo.
b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento si la
columna no tiene impares.
c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos. }


program ej1;
type
TM = array[1..255,1..255] of integer;
TV = array[1..255] of integer;

procedure llenarMatriz(var mat:TM;var N,M:byte);
var 
arch:text;
i,j:byte;
begin
 Assign(arch,'datos.txt');
 reset(arch);
 readln(arch,N,M);
 for i:=1 to N  do 
   begin
     for j:=1 to M do 
      read(arch,mat[i,j]);
     ReadLn(arch); 
   end;
end;

procedure mostrarMatriz(mat:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
    begin
      for j:=1 to M do 
        Write(mat[i,j],' ');
      WriteLn;  
    end;
end;

function buscarMaximo(mat:TM;fila,M:byte):integer;
var 
i:byte;
maximo:integer;
begin
  maximo:=mat[fila,1];
  for i:=2 to M do 
    if(maximo<mat[fila,i]) then
      maximo:=mat[fila,i];
  buscarMaximo:=maximo;    
end;

procedure generarArrMaximos(mat:TM;var vecMax:TV;N,M:byte);
var 
i:byte;
begin
  for i:=1 to N do 
    vecMax[i]:=buscarMaximo(mat,i,M);  
end;

procedure mostrarVec(vec:TV;N:byte);
var 
i:byte;
begin
 for i:=1 to N do
    begin
      Write(vec[i],' ');
    end;
    WriteLn;
end;

function calcularSuma(mat:TM;columna,N:byte):integer;
var 
i:byte;
suma:integer;
begin
   suma:=0;
   for i:=1 to N do 
     begin
       if(mat[i,columna] mod 2 <> 0) then
         suma:=suma+mat[i,columna];
     end;
   calcularSuma:=suma;
end;

function tieneImpar(mat:TM;columna,N:byte):boolean;
var 
i:byte;
begin
  i:=1;
  while (i<=N) and (mat[i,columna] mod 2 = 0) do 
   i:=i+1;
  tieneImpar:=i<=N; 
end;

procedure generarArrImpar(mat:TM;var vecImp:TV;N,M:byte;var K:byte);
var 
j:byte;
begin
  K:=0;
  for j:=1 to M do 
    begin
      if(tieneImpar(mat,j,N))then 
       begin 
         K:=K+1;
         vecImp[K]:=calcularSuma(mat,j,N);
       end;
    end;
end;

function calcularPromX(mat:TM;columna,N:byte):real;
var
 i:byte; 
 acum:real;
begin
  acum:=0;
  for i:=1 to N do 
    begin
      acum:=acum+mat[i,columna];
    end;
   calcularPromX:=acum/N; 
end;

var 
mat:TM;
vecMax,vecSumaImp:TV;
N,M,K,X:byte;
begin
  llenarMatriz(mat,N,M);
  mostrarMatriz(mat,N,M);
  //a) Generar un arreglo con el máximo de cada fila y mostrarlo.
  generarArrMaximos(mat,vecMax,N,M);
  WriteLn('Este es el arreglo');
  mostrarVec(vecMax,N);
  //b) Generar un arreglo con la suma de los impares de cada columna, no generar elemento si la columna no tiene impares.
  generarArrImpar(mat,vecSumaImp,N,M,K);
  WriteLn('Este es el arreglo impar');
  mostrarVec(vecSumaImp,K);
  //c) Dada una columna X, ingresada por el usuario, hallar el promedio de sus elementos.
  WriteLn('Ingrese una columna X');
  readln(X);
  WriteLn('El promedio de la columna ',X, ' es:',calcularPromX(mat,X,N):6:2);
end.