{) Un cuadrado mágico de orden N (impar), es una matriz cuadrada de NxN que contiene números
naturales de 1 a N2
, tal que la suma de cualquier columna, fila o diagonal coincide. Se construye de la
siguiente manera:
 El número 1 se coloca en la casilla central de la primera fila.
 Cada número siguiente se coloca en la casilla correspondiente a
la fila anterior y columna posterior.
 Si el número es el que sigue a un múltiplo de N, se coloca en la
casilla de la fila posterior en la misma columna.
 Se considera fila anterior a la primera, la última.
 Se considera columna posterior a la última, la primera
Se pide:
a) Escribir un procedimiento que, dados una matriz Mat y N, genere el cuadrado mágico.
b) Escribir una función booleana que verifique si la matriz Mat es un cuadrado mágico. }


program ej6;
Type 
TM = array [1..255,1..255] of byte;
Tfunc = function(mat:TM;FoC,N:byte):byte;

procedure llenarCuadrado(var cuadrado:TM;N:byte);
var 
i,j,k:byte;
begin
  j:=(N div 2)+1;
  i:=1;
  for k:=1 to (N*N) do 
   begin
     cuadrado[i,j]:=k;
     if(k mod N = 0) then
       begin
         if(i+1>N) then
           i:=1
         else 
           i:=i+1;  
       end
     else 
      begin
        if(j+1>N)then
          j:=1
        else 
         j:=j+1;  
        if((i-1)=0)then
          i:=N
        else 
         i:=i-1;  
      end;  
   end;
end;

procedure mostrarCuadrado(CuadradoMagico:TM;N:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to N do 
       Write(CuadradoMagico[i,j],' ');
      WriteLn; 
   end;
end;

function SumFila(mat:TM;fila,N:byte):byte;
var 
j,sum:byte;
begin
  sum:=0;
  for j:=1 to N do 
   sum:=sum+mat[fila,j];
  SumFila:=sum; 
end;

function SumCol(mat:TM;columna,N:byte):byte;
var 
i,sum:byte;
begin
  sum:=0;
  for i:=1 to N do 
   sum:=sum+mat[i,columna];
  SumCol:=sum; 
end;

function comprobarLados(mat:TM;N,val:byte;func1,func2:Tfunc):boolean;
var 
i:byte;
begin
   i:=1;
   while (i<=N) and (func1(mat,i,N)=val) and (func2(mat,i,N)=val) do 
    i:=i+1;
   comprobarLados:=i>N; 
end;

function comprobarDiagonales(mat:TM;N,val:byte):boolean;
var 
i:byte;
sumPrin,sumSec:byte;
begin
  sumPrin:=0;sumSec:=0;
  for i:=1 to N do 
   begin
     sumPrin:=sumPrin+mat[i,i];
     sumSec:=sumSec+mat[i,N-i+1];
   end;
   comprobarDiagonales:= (sumPrin=val) and (sumSec=val);
end;

function esMagico(mat:TM;N:byte):Boolean;
var 
lados,diagonales:boolean;
val,i:byte;
begin
  val:=0;
  for i:=1 to N do 
   begin
     val:=val+mat[i,1];
   end;
  lados:=comprobarLados(mat,N,val,@SumFila,@SumCol);
  diagonales:=comprobarDiagonales(mat,N,val);
  esMagico:= lados and diagonales;
end;


var 
CuadradoMagico:TM;
N:byte;
begin
  WriteLn('Ingrese N');
  ReadLn(N);
  llenarCuadrado(CuadradoMagico,N);
  mostrarCuadrado(CuadradoMagico,N);
  if(esMagico(CuadradoMagico,N)) then
    WriteLn('Es un cuadrado magico!!')
  else 
    WriteLn('No es magico :(');  
end.