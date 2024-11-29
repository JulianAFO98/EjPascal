{Verificar si una matriz A de NxN de números enteros cumple que para cada fila el elemento
respectivo de la diagonal principal es mayor a la suma del resto de los elementos de la fila}

program ej12;
type 
TM = array [1..255,1..255] of integer; 

procedure llenarMatriz(var Matriz:TM;var N:byte);
var 
i,j:byte;
arch:text;
begin
  WriteLn('Ingrese N ');
  ReadLn(N);
  Assign(arch,'ej12.txt');
  Reset(arch);
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      Read(arch,Matriz[i,j]);
   end;
   Close(arch);
end;

{function CalcularSumaFilaSinDiagonal(matriz:TM;fila,columna:byte):integer;
begin
  if(columna>1) then 
    if(fila=columna) then 
      CalcularSumaFilaSinDiagonal:=CalcularSumaFilaSinDiagonal(matriz,fila,columna-1)
    else  
     CalcularSumaFilaSinDiagonal:=matriz[fila,columna]+CalcularSumaFilaSinDiagonal(matriz,fila,columna-1)
  else 
    CalcularSumaFilaSinDiagonal:=matriz[fila,columna];
end;}

{function VerificarMatriz(matriz:TM;N,i,j:byte):boolean;
var 
suma:integer;
begin
  if(i>1) then 
   begin
     suma:=CalcularSumaFilaSinDiagonal(matriz,i,N);
     if(matriz[i,i]>suma) then 
       VerificarMatriz:=VerificarMatriz(matriz,N,i-1,N)
     else 
       VerificarMatriz:=false;  
   end
  else 
   VerificarMatriz:=true; 
end;}

procedure VerificarMatriz(mat:TM;i,j,M:byte;var suma:integer);
begin
  if(i>0)then 
   begin
     if(j=M)then 
      suma:=0;
     if(j>0)then 
      begin
        if(i=j)then 
         VerificarMatriz(mat,i,j-1,M,suma)
        else 
         begin
           suma:=suma+mat[i,j];
           VerificarMatriz(mat,i,j-1,M,suma);
         end; 
      end
     else 
      begin
        if(suma<mat[i,i]) then 
          VerificarMatriz(mat,i-1,M,M,suma)
        else 
         WriteLn('No cumple los requisitos');  
      end
   end
  else 
    Writeln('Cumple los requisitos'); 
end;

procedure mostrarMatriz(mat:TM;N:byte);
var 
i,j:byte;
begin
  for i:=1 to N do 
   begin
     for j:=1 to N do 
      Write(mat[i,j],' ');
     WriteLn;
   end;
end;

var 
Matriz:TM;
N:byte;
suma:integer;
begin
  llenarMatriz(Matriz,N);
  mostrarMatriz(Matriz,N);
 VerificarMatriz(matriz,N,N,N,suma);

end.