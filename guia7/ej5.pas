{Ingresar N y M y luego los elementos no nulos de una matriz rala por filas (i, j, valor) y almacenar en
un arreglo de registros.
a) Mostrar en formato matricial completando los ceros faltantes.
b) Si es cuadrada, modificarla para obtener la traspuesta. }

program ej5;
type 
TRegCasilla = record 
 i,j,valor:byte;
end;
TV = array [1..255] of TRegCasilla;



procedure LlenarVectorRegistros(var Vector:TV;var N:byte);
var 
arch:text;
Casilla:TRegCasilla;
begin
  Assign(arch,'ej5txt.txt');Reset(arch);
  N:=0;
  while not eof(arch) do 
   begin
     N:=N+1;
     with Casilla do 
      begin
        Read(arch,Casilla.i,Casilla.j,Casilla.valor);
      end;
     ReadLn(arch);
     Vector[N]:=Casilla; 
   end;
  close(arch); 
end;

procedure mostrarVecReg(vec:TV;N:byte);
var 
i:byte;
begin
  for i:=1 to N do 
   begin
     WriteLn(Vec[i].i,' ',vec[i].j,' ',vec[i].valor);
   end;
end;

function buscarPos(Vec:TV;K,vali,valj:byte):byte;
var 
i:byte;

begin
  i:=1;
  while (i<=K) and  ((Vec[i].i<>vali) or (Vec[i].j<>valj)) do 
   i:=i+1;
  if(i<=K) then 
   buscarPos:=i
  else 
   buscarPos:=0; 
end;

procedure GenerarFalsaMatriz(Vec:TV;K,N,M:byte);
var 
i,j,pos:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         pos:=buscarPos(Vec,K,i,j);
         if(pos=0) then 
          Write('0 ')
         else 
          Write(vec[pos].valor,' ');  
       end;
      WriteLn; 
   end;
end;

procedure GenerarFalsaMatrizT(Vec:TV;K,N,M:byte);
var 
i,j,pos:byte;
begin
  for j:=1 to M do 
   begin
      for i:=1 to N do 
       begin
         pos:=buscarPos(Vec,K,i,j);
         if(pos=0) then 
          Write('0 ')
         else 
          Write(vec[pos].valor,' ');  
       end;
      WriteLn; 
   end;
end;



var 
Vec:TV;
N,M,K:byte;
begin
  WriteLn('Ingrese N y M');
  ReadLn(N,M);
  LlenarVectorRegistros(Vec,K);
  mostrarVecReg(Vec,K);
  //a)
  GenerarFalsaMatriz(Vec,K,N,M);
  //b)
  GenerarFalsaMatrizT(Vec,K,N,M);
end.
