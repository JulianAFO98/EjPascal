Program ej5;
type
TV = array [1..5] of integer;



function suma(V:TV;N:byte):integer;
begin
  if(N>1) then 
    suma:=V[N]+suma(V,N-1)
  else 
    suma:=V[N];  
end;

procedure MostrarElementos(V:TV;N:byte);
begin
  if(N>0)then 
   begin
     MostrarElementos(V,N-1);
     Write(V[N],' ');
   end;
end;

procedure MostrarElementosInvertidos(V:TV;N:byte);
begin
  if(N>0)then 
   begin
     Write(V[N],' ');
     MostrarElementosInvertidos(V,N-1);
   end;
end;

function MaximoElem(V:TV;N:byte):integer;
var 
max:integer;
begin
  if(N>1) then 
   begin
     max:=MaximoElem(V,N-1);
     if(max>V[N])then 
      MaximoElem:=max
     else 
      MaximoElem:=V[N];
   end
  else 
    MaximoElem:=V[N]; 
end;

function PromV(V:TV;i,N:byte):real;
begin
  if(i>1) then 
    PromV:=(V[i]/N)+PromV(V,i-1,N)
  else 
    PromV:=V[i]/N;  
end;


const 
V:TV = (4,-5,1,0,-7);
N=5;
begin
  //a) Calcular e informar la suma de sus elementos. 
  WriteLn('La suma de su elementos es:',suma(V,N));
  MostrarElementos(V,N);
  WriteLn;
  MostrarElementosInvertidos(V,N);
  WriteLn;
  //Obtener el máximo de sus elementos.
   WriteLn('El maximo elem es:',MaximoElem(V,N));
  //Obtener el promedio.
  WriteLn('El promedio es: ',PromV(V,N,N):4:2);
end.