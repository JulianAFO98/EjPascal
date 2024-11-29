{Ej 1) Dado un arreglo A de N elementos reales, desarrollar subprogramas para:
a) Calcular la suma de sus elementos.
b) Mostrar los elementos que se encuentran en posiciones pares.
c) Calcular el máximo y el mínimo elemento.
d) Generar un arreglo B con los elementos de A permutado ( B[1]=A[N], B[2]=A[N-1] … B[N]=A[1] ).
Escribir el programa principal con las invocaciones a cada uno de los subprogramas, mostrando los
resultados correspondientes. 
}

program ej1;
type
TV = array[1..255] of real;

procedure llenarVector(var Vector:TV;var N:byte);
var
 i:byte;
begin
  WriteLn('Ingrese el valor de N');
  ReadLn(N);
  for i:=1 to N do
    begin
      Writeln('Ingrese el valor ',i,' del vector');
      readln(vector[i]);
    end;
end;
//Calcular la suma de sus elementos.
function sumarElementos(Vector:TV;N:byte):real;
var
 i:byte;
 sum:real;
begin
 sum:=0;
  for i:=1 to N do
    begin
      sum:=sum+vector[i];
    end;
  sumarElementos:=sum;  
end;

//Calcular el máximo y el mínimo elemento.
function calcularMin(Vector:TV;N:byte):real;
var
 min:real;
 i:byte;
begin
  min:=vector[1];
  for i:=2 to N do 
   begin
     if(vector[i]<min) then
       min:=vector[i];
   end;
   calcularMin:=min;
end;

function calcularMax(Vector:TV;N:byte):real;
var
 max:real;
 i:byte;
begin
  max:=vector[1];
  for i:=2 to N do 
   begin
     if(vector[i]>max) then
       max:=vector[i];
   end;
   calcularMax:=max;
end;

//Generar un arreglo B con los elementos de A permutado 
procedure InvertirValores(vector:TV;N:byte;var vector2:TV);
var 
i:byte;
begin
   for i:=1 to N do
     begin
       vector2[i]:=vector[N-i+1];
     end;
end;

procedure mostrarVector(vect:TV;N:byte);
var 
i:byte;
begin
   for i:=1 to N do
     begin
       Write(vect[i]:4:2,' ');
     end;
end;

var 
N:byte;
vect:TV;
vect2:TV;
begin
  llenarVector(vect,N);
  WriteLn('La suma de los elementos da',sumarElementos(vect,N):8:2);
  WriteLn('El minimo es',calcularMin(vect,N):8:2);
  WriteLn('El maximo es',calcularMax(vect,N):8:2);
  InvertirValores(vect,N,vect2);
  mostrarVector(vect,N);
  WriteLn;
  mostrarVector(vect2,N);
end.