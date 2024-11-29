{Idem ejercicio 5, leer dos matrices y calcular la matriz resultante de la suma de ambas. }
program ej6;

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

procedure LlenarVectorRegistros2(var Vector:TV;var N:byte);
var 
arch:text;
Casilla:TRegCasilla;
begin
  Assign(arch,'ej5txt2.txt');Reset(arch);
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



procedure GenerarMatrizSuma(VecA,VecB:TV;K,L,N,M:byte);
var 
i,j,pos1,pos2:byte;
begin
  for i:=1 to N do 
   begin
      for j:=1 to M do 
       begin
         pos1:=buscarPos(VecA,K,i,j);
         pos2:=buscarPos(VecB,L,i,j);
         if(pos1<>0) and (pos2<>0) then 
          Write(vecA[pos1].valor+VecB[pos2].valor,' ')
         else 
          if(pos1<>0) then 
            Write(vecA[pos1].valor,' ')
          else 
           if(pos2<>0) then 
            Write(vecB[pos2].valor,' ')
           else 
            Write('0 ');
       end;
      WriteLn; 
   end;
end;


var 
VecA,VecB:TV;
N,M,K,L:byte;
begin
  WriteLn('Ingrese N y M');
  ReadLn(N,M);
  LlenarVectorRegistros(VecA,K);
  LlenarVectorRegistros2(VecB,L);
  mostrarVecReg(VecA,K);
  mostrarVecReg(VecB,L);
  //a)
  GenerarMatrizSuma(VecA,VecB,K,L,N,M);
  
end.


