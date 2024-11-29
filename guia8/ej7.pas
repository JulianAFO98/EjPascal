{Ej 7) Crear una función recursiva que busque el elemento mínimo de una matriz cuadrada. }

program ej7;
type 
Mat = array [1..10,1..10] of real;


procedure llenarDatos(var matriz:Mat;var N:byte);
var 
i,j:byte;
begin
  WriteLn('Ingrese N');
  ReadLn(N);
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      begin
        WriteLn('Ingrese el valor ',i,',',j);
        ReadLn(matriz[i,j]);
      end;
   end;
end;

function buscarElemMinimo(M:mat;i,j,N:byte):real;
var 
min:real;
begin
  if(i>0)then 
   begin
    if(j>0) then 
       min:=buscarElemMinimo(M,i,j-1,N)
    else 
       min:=buscarElemMinimo(M,i-1,N,N);   
    if(min<M[i,j]) then 
      buscarElemMinimo:=min
    else 
      buscarElemMinimo:=M[i,j];     
   end
  else 
    buscarElemMinimo:=M[1,1]; 
end;

var 
M:Mat;
N:byte;
begin
  llenarDatos(M,N);
  WriteLn('El elemento minimo de la matriz es ',buscarElemMinimo(M,N,N,N):5:2);
end.