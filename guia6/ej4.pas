{Se tiene en un archivo los elementos de una matriz “rala” (se dice que una matriz es rala cuando la
mayoría de sus elementos son cero). En cada línea del archivo viene:
 fila, columna, dato (distinto de cero)
Se pide:
a) Armar la matriz original y mostrarla en forma matricial.
(Obtener N y M, sabiendo que hay al menos un valor no nulo en la última fila de alguna columna y
en la última columna de alguna fila ).
b) Si es cuadrada (N=M) determinar si es triangular inferior. }

program ej4;
type
TM = array [1..255,1..255] of byte; 
TV = array [1..255] of byte;

procedure inicializarMatriz(var mat:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to M do 
      begin
        mat[i,j]:=0;
      end;
   end;
end;



procedure colocarValores(var mat:TM;var N,M:byte);
var 
maxN,maxM,dato,K,i:byte;
arch:text;
VecI,vecJ,VecDato:TV;
begin
  assign(arch,'datos.txt');
  reset(arch);
  maxN:=0;maxM:=0;K:=0;
  while not eof(arch) do 
   begin
     ReadLn(arch,N,M,dato);
     if(N>maxN)then 
      maxN:=N;
     if(M>maxM)then 
      maxM:=M; 
     K:=K+1;
     VecI[K]:=N;
     vecJ[K]:=M;
     VecDato[K]:=dato;
   end;
   N:=maxN;
   M:=maxM;
   inicializarMatriz(mat,N,M);
   for i:=1 to  K do 
    begin
      mat[VecI[i],vecJ[i]]:=VecDato[i];
    end;
  close(arch);
end;

procedure mostrarMatriz(matriz:TM;N,M:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
    begin
        for j:=1 to M do 
         Write(matriz[i,j],' ');
        WriteLn; 
    end;
end;

function esTriangularInf(mat:TM;N,M:byte):boolean;
var 
i,j:byte;
triangular:boolean;
begin
  i:=1;
  triangular:=true;
  while (i<=N) and triangular do
   begin
     j:=i+1;
     while (j<=M) and triangular do 
      begin
        triangular:=mat[i,j]=0;
        j:=j+1;
      end;
     i:=i+1; 
   end;
   esTriangularInf:=triangular;
end;

var 
mat:TM;
N,M:byte;
begin
  colocarValores(mat,N,M);
  mostrarMatriz(mat,N,M);
  if (N=M) and esTriangularInf(mat,N,M) then 
    WriteLn('Es triangular Inferior');
end.